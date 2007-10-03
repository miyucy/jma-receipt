/*
 * orcqrencode - QR Code encode front end for jma-receipt
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <qrencode.h>
#include <png.h>
#include <jconv.h>

/*
 *	struct qrencode_ctx;
 *		char infile[256];
 *		char qrfile[256];
 *		char opt_l;
 *		char opt_s;
 *		char opt_m;
 *		char opt_v[2];
 *		char opt_k;
 *		char opt_C;
 *		char ver[2];
 *		char num[2];
 *		char ret[1];
 *	};
 */

#define	MAX_DATA_SIZE	7090 * 16

#define	SIZE_INFILE		256
#define SIZE_QRFILE		256
#define SIZE_SL			1
#define SIZE_SS			1
#define SIZE_SM			1
#define SIZE_SV			2
#define SIZE_SK			1
#define SIZE_LC			1
#define SIZE_VER		2
#define SIZE_NUM		2
#define SIZE_RET		1

#define OFFSET_INFILE	(0)
#define OFFSET_QRFILE	(OFFSET_INFILE + SIZE_INFILE)
#define OFFSET_SL		(OFFSET_QRFILE + SIZE_QRFILE)
#define OFFSET_SS		(OFFSET_SL     + SIZE_SL)
#define OFFSET_SM		(OFFSET_SS     + SIZE_SS)
#define OFFSET_SV		(OFFSET_SM     + SIZE_SM)
#define OFFSET_SK		(OFFSET_SV     + SIZE_SV)
#define OFFSET_LC		(OFFSET_SK     + SIZE_SK)
#define OFFSET_VER		(OFFSET_LC     + SIZE_LC)
#define OFFSET_NUM		(OFFSET_VER    + SIZE_VER)
#define OFFSET_RET		(OFFSET_NUM    + SIZE_NUM)

#define QRENCODE_OK		'0'
#define QRENCODE_ERROR	'1'
#define CHAR_CONV_ERROR	'2'
#define WRITE_PNG_ERROR	'3'
#define PARAM_ERROR		'4'
#define KANA_CONV_ERROR	'5'

#define	CTX(p, offset)		(p + offset)

void orcqrencode(char *ctx);

static int 
writePNG(QRcode *qrcode, 
	const char *outfile,
	int size,
	int margin)
{
	FILE *fp;
	png_structp png_ptr;
	png_infop info_ptr;
	unsigned char *row, *p, *q;
	int x, y, xx, yy, bit;
	int realwidth;
	
	realwidth = (qrcode->width + margin * 2) * size;
	row = (unsigned char *)malloc((realwidth + 7) / 8);

	if(outfile[0] == '-' && outfile[1] == '\0') {
		fp = stdout;
	} else {
		fp = fopen(outfile, "w");
		if(fp == NULL) {
			return -1;
		}
	}

	png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if(png_ptr == NULL) {
		fclose(fp);
		return -1;
	}

	info_ptr = png_create_info_struct(png_ptr);
	if(info_ptr == NULL) {
		fclose(fp);
		return -1;
	}

	if(setjmp(png_jmpbuf(png_ptr))) {
		png_destroy_write_struct(&png_ptr, &info_ptr);
		fclose(fp);
		return -1;
	}

	png_init_io(png_ptr, fp);
	png_set_IHDR(png_ptr, info_ptr,
			realwidth, realwidth,
			1,
			PNG_COLOR_TYPE_GRAY,
			PNG_INTERLACE_NONE,
			PNG_COMPRESSION_TYPE_DEFAULT,
			PNG_FILTER_TYPE_DEFAULT);
	png_write_info(png_ptr, info_ptr);

	/* top margin */
	memset(row, 0xff, (realwidth + 7) / 8);
	for(y=0; y<margin * size; y++) {
		png_write_row(png_ptr, row);
	}

	/* data */
	p = qrcode->data;
	for(y=0; y<qrcode->width; y++) {
		bit = 7;
		memset(row, 0xff, (realwidth + 7) / 8);
		q = row;
		q += margin * size / 8;
		bit = 7 - (margin * size % 8);
		for(x=0; x<qrcode->width; x++) {
			for(xx=0; xx<size; xx++) {
				*q ^= (*p & 1) << bit;
				bit--;
				if(bit < 0) {
					q++;
					bit = 7;
				}
			}
			p++;
		}
		for(yy=0; yy<size; yy++) {
			png_write_row(png_ptr, row);
		}
	}
	/* bottom margin */
	memset(row, 0xff, (realwidth + 7) / 8);
	for(y=0; y<margin * size; y++) {
		png_write_row(png_ptr, row);
	}

	png_write_end(png_ptr, info_ptr);
	png_destroy_write_struct(&png_ptr, &info_ptr);

	fclose(fp);
	free(row);
	return 0;
}

static int
euc2sjis(char *file, 
	char *out)
{
	FILE *fp;
	char *sjis;
	char src[MAX_DATA_SIZE];
	int ret;

	if((fp = fopen(file, "r")) == NULL)return -1;
	ret = fread(src, 1, MAX_DATA_SIZE, fp);
	if(ret == 0){
		return -1;	
	}
	src[ret] = '\0';
	fclose(fp);

	if((sjis = convert_kanji_strict(src, "SJIS", "EUCJP")) == NULL){
		return -1;	
	}
	strncpy(out, sjis, MAX_DATA_SIZE);
	free(sjis);
	return 0;
}

static int
power(int base,
	int pow)
{
	if(pow <= 0){
		return 1;
	}
	else{
		return power(base, pow - 1) * base;	
	}
}

static int
ctx_int(char *p, int offset, int size)
{
	int ret = 0;
	int i;
	for(i = 0; i < size; i++) {
		ret	+= ((*CTX(p, offset + i) - 0x30) % 10) * power(10, size - i - 1);
	}
	return ret;
}

/* Shift-JIS hankaku-kan zenkaku-kana mapping table */
static unsigned char
z2h_map[][2][2] = {
	{{0x81,0x41},{0x00,0xA4}}, {{0x81,0x42},{0x00,0xA1}},
	{{0x81,0x45},{0x00,0xA5}}, {{0x81,0x4A},{0x00,0xDE}},
	{{0x81,0x4B},{0x00,0xDF}}, {{0x81,0x5b},{0x00,0xB0}},
	{{0x81,0x75},{0x00,0xA2}}, {{0x81,0x76},{0x00,0xA3}},
	{{0x83,0x40},{0x00,0xA7}}, {{0x83,0x41},{0x00,0xB1}},
	{{0x83,0x42},{0x00,0xA8}}, {{0x83,0x43},{0x00,0xB2}},
	{{0x83,0x44},{0x00,0xA9}}, {{0x83,0x45},{0x00,0xB3}},
	{{0x83,0x46},{0x00,0xAA}}, {{0x83,0x47},{0x00,0xB4}},
	{{0x83,0x48},{0x00,0xAB}}, {{0x83,0x49},{0x00,0xB5}},
	{{0x83,0x4A},{0x00,0xB6}}, {{0x83,0x4B},{0xB6,0xDE}},
	{{0x83,0x4C},{0x00,0xB7}}, {{0x83,0x4D},{0xB7,0xDE}},
	{{0x83,0x4E},{0x00,0xB8}}, {{0x83,0x4F},{0xB8,0xDE}},
	{{0x83,0x50},{0x00,0xB9}}, {{0x83,0x51},{0xB9,0xDE}},
	{{0x83,0x52},{0x00,0xBA}}, {{0x83,0x53},{0xBA,0xDE}},
	{{0x83,0x54},{0x00,0xBB}}, {{0x83,0x55},{0xBB,0xDE}},
	{{0x83,0x56},{0x00,0xBC}}, {{0x83,0x57},{0xBC,0xDE}},
	{{0x83,0x58},{0x00,0xBD}}, {{0x83,0x59},{0xBD,0xDE}},
	{{0x83,0x5A},{0x00,0xBE}}, {{0x83,0x5B},{0xBE,0xDE}},
	{{0x83,0x5C},{0x00,0xBF}}, {{0x83,0x5D},{0xBF,0xDE}},
	{{0x83,0x5E},{0x00,0xC0}}, {{0x83,0x5F},{0xC0,0xDE}},
	{{0x83,0x60},{0x00,0xC1}}, {{0x83,0x61},{0xC1,0xDE}},
	{{0x83,0x62},{0x00,0xAF}}, {{0x83,0x63},{0x00,0xC2}},
	{{0x83,0x64},{0xC2,0xDE}}, {{0x83,0x65},{0x00,0xC3}},
	{{0x83,0x66},{0xC3,0xDE}}, {{0x83,0x67},{0x00,0xC4}},
	{{0x83,0x68},{0xC4,0xDE}}, {{0x83,0x69},{0x00,0xC5}},
	{{0x83,0x6A},{0x00,0xC6}}, {{0x83,0x6B},{0x00,0xC7}},
	{{0x83,0x6C},{0x00,0xC8}}, {{0x83,0x6D},{0x00,0xC9}},
	{{0x83,0x6E},{0x00,0xCA}}, {{0x83,0x6F},{0xCA,0xDE}},
	{{0x83,0x70},{0xCA,0xDF}}, {{0x83,0x71},{0x00,0xCB}},
	{{0x83,0x72},{0xCB,0xDE}}, {{0x83,0x73},{0xCB,0xDF}},
	{{0x83,0x74},{0x00,0xCC}}, {{0x83,0x75},{0xCC,0xDE}},
	{{0x83,0x76},{0xCC,0xDF}}, {{0x83,0x77},{0x00,0xCD}},
	{{0x83,0x78},{0xCD,0xDE}}, {{0x83,0x79},{0xCD,0xDF}},
	{{0x83,0x7A},{0x00,0xCE}}, {{0x83,0x7B},{0xCE,0xDE}},
	{{0x83,0x7C},{0xCE,0xDF}}, {{0x83,0x7D},{0x00,0xCF}},
	{{0x83,0x7E},{0x00,0xD0}}, {{0x83,0x80},{0x00,0xD1}},
	{{0x83,0x81},{0x00,0xD2}}, {{0x83,0x82},{0x00,0xD3}},
	{{0x83,0x83},{0x00,0xAC}}, {{0x83,0x84},{0x00,0xD4}},
	{{0x83,0x85},{0x00,0xAD}}, {{0x83,0x86},{0x00,0xD5}},
	{{0x83,0x87},{0x00,0xAE}}, {{0x83,0x88},{0x00,0xD6}},
	{{0x83,0x89},{0x00,0xD7}}, {{0x83,0x8A},{0x00,0xD8}},
	{{0x83,0x8B},{0x00,0xD9}}, {{0x83,0x8C},{0x00,0xDA}},
	{{0x83,0x8D},{0x00,0xDB}}, {{0x83,0x8F},{0x00,0xDC}},
	{{0x83,0x92},{0x00,0xA6}}, {{0x83,0x93},{0x00,0xDD}},
	{{0x83,0x8D},{0x00,0xDB}}, {{0x83,0x8F},{0x00,0xDC}},
	{{0x83,0x92},{0x00,0xA6}}, {{0x83,0x93},{0x00,0xDD}},
	{{0x83,0x94},{0xB3,0xDE}}, {{0x81,0x40},{0x00,0x20}}
};

static void
z2h(unsigned char *in,
	unsigned char *out)
{
	int i;
	int j;
	int k;
	int size;
	size = strlen(in);
	for(i = 0, k = 0; i < size; ){
		/* hankaku kana */
		if(in[i] >= 0xA1 && in[i] <= 0xDF){
			out[k] = in[i];
			i++;
			k++;
		}
		/* space */
		else if(in[i] <= 0x7f){
			if(in[i] == 0x20){
				out[k] = in[i];
				k++;
			}
			i++;
		}
		/* zenkaku kana */
		else{
			for(j = 0; j < sizeof(z2h_map)/4; j++){
				if(in[i+0] == z2h_map[j][0][0] &&
					in[i+1] == z2h_map[j][0][1]){
					if(z2h_map[j][1][0] != 0x00){
						out[k+0] = z2h_map[j][1][0];
						out[k+1] = z2h_map[j][1][1];
						k += 2;
					}
					else{
						out[k+0] = z2h_map[j][1][1];
						k++;
					}
					j = 0;
					break;
				}
			}
			i += 2;
		}
	}
	out[k] = 0x00;
}

#define MAX_COLUMN_NUM 32
#define MAX_COLUMN_SIZE 256

static int
parse_csv(char *in, 
	char *out)
{
	char *str;
	char *record;
	char *save;
	char delim[] = {0x0d, 0x0a, 0x00};
	char *p;
	char column[MAX_COLUMN_NUM][MAX_COLUMN_SIZE];
	char buf[MAX_COLUMN_SIZE];
	int loop;
	int i;
	int j;

	out[0] = 0x00;
	for(str = in; ; str = NULL){
		record = strtok_r(str, delim, &save);
		if(record == NULL) break;

		p = record;
		i = j = 0;
		loop = 1;
		while(loop){
			switch(*p){
				case ',':
					column[i][j] = 0x00;
					i++;
					if(i >= MAX_COLUMN_SIZE) return(-1);
					j = 0;
					break;
				case 0x00:
					column[i][j] = 0x00;
					i++;
					loop = 0;
					j = 0;
					break;
				default:
					column[i][j] = *p;
					j++;
					if(j >= MAX_COLUMN_SIZE) return(-1);
					break;
			}
			p++;
		}

		/* Patient name record  */
		if(strcmp(column[0], "11") == 0){
			for(j = 0; j < i; j++){
				if(j == 3){
					z2h(column[j], buf);
					strcat(out, buf);
				}
				else{
					strcat(out, column[j]);
				}
				if(j < i - 1) strcat(out, ",");
			}
		}
		else{
			strcat(out, record);
		}
		strcat(out, delim);
	}
	return(0);
}

void
orcqrencode(char *ctx)
{
	int version;
	int level;
	int hint;
	int size;
	int margin;
	int comb;
	int i;
	char buf[MAX_DATA_SIZE];
	char buf2[MAX_DATA_SIZE];
	char qrfile[SIZE_QRFILE];
	char qrfile_suffix[SIZE_QRFILE + 10];
	char *p;
	QRcode *code;
	QRcode_List *head, *tail;

	if((p = strchr(CTX(ctx, OFFSET_INFILE), ' ')) != NULL) *p = '\0';
	if((p = strchr(CTX(ctx, OFFSET_QRFILE), ' ')) != NULL) *p = '\0';

#if 0
	printf("infile:%s\n", CTX(ctx, OFFSET_INFILE));
	printf("qrfile:%s\n", CTX(ctx, OFFSET_QRFILE));
	printf("l:%02x\n", *CTX(ctx, OFFSET_SL));
	printf("s:%02x\n", *CTX(ctx, OFFSET_SS));
	printf("m:%02x\n", *CTX(ctx, OFFSET_SM));
	printf("v:%02x%02x\n", *CTX(ctx, OFFSET_SV), *CTX(ctx, OFFSET_SV+1));
	printf("k:%02x\n", *CTX(ctx, OFFSET_SK));
	printf("C:%02x\n", *CTX(ctx, OFFSET_LC));
	printf("ver:%02x%02x\n", *CTX(ctx, OFFSET_VER), *CTX(ctx, OFFSET_VER+1));
	printf("num:%02x%02x\n", *CTX(ctx, OFFSET_NUM), *CTX(ctx, OFFSET_NUM+1));
	printf("ret:%02x\n", *CTX(ctx, OFFSET_RET));
#endif

	memset(CTX(ctx, OFFSET_RET), QRENCODE_OK, SIZE_RET);

	if(euc2sjis(CTX(ctx, OFFSET_INFILE), buf) != 0){
		memset(CTX(ctx, OFFSET_RET), CHAR_CONV_ERROR, SIZE_RET);
		return;
	}

	if(parse_csv(buf, buf2) !=0){
		memset(CTX(ctx, OFFSET_RET), KANA_CONV_ERROR, SIZE_RET);
		return;
	}

	snprintf(qrfile, SIZE_QRFILE, "%s", CTX(ctx, OFFSET_QRFILE));
	version = ctx_int(ctx, OFFSET_SV, SIZE_SV);
	if(version <= 0 || version > 40){
		memset(CTX(ctx, OFFSET_RET), PARAM_ERROR, SIZE_RET);
		return;	
	}
	switch(*CTX(ctx, OFFSET_SL)){
		case 'L':
			level = QR_ECLEVEL_L;
			break;
		case 'M':
			level = QR_ECLEVEL_M;
			break;
		case 'Q':
			level = QR_ECLEVEL_Q;
			break;
		case 'H':
			level = QR_ECLEVEL_H;
			break;
		default:
			level = QR_ECLEVEL_L;
	}
	hint = ctx_int(ctx, OFFSET_SK, SIZE_SK) == 0 ? QR_MODE_KANJI : QR_MODE_8;
	size = ctx_int(ctx, OFFSET_SS, SIZE_SS);
	margin = ctx_int(ctx, OFFSET_SM, SIZE_SM);
	comb = ctx_int(ctx, OFFSET_LC, SIZE_LC);

#if 0
	printf("version:%d\n", version);
	printf("level:%d\n", level);
	printf("hint:%d\n", hint);
	printf("size:%d\n", size);
	printf("margin:%d\n", margin);
	printf("comb:%d\n", comb);
#endif

	if(comb == 0){
		code = QRcode_encodeString(buf2, version, level, hint);
		if(code == NULL){
			memset(CTX(ctx, OFFSET_RET), QRENCODE_ERROR, SIZE_RET);
		 	return;
		}
		if(writePNG(code, qrfile, size, margin) != 0){
			memset(CTX(ctx, OFFSET_RET), WRITE_PNG_ERROR, SIZE_RET);
			return;
		}
		sprintf(buf, "%02d" , code->version);
		memcpy(CTX(ctx, OFFSET_VER), buf, SIZE_VER);
		sprintf(buf, "%02d" , 1);
		memcpy(CTX(ctx, OFFSET_NUM), "01", SIZE_NUM);
		QRcode_free(code);
	}
	else{
		head = tail = QRcode_encodeStringStruct(buf2, 
			strlen(buf2), 
			version,
			level,
			hint);
	
		if(head == NULL){
			memset(CTX(ctx, OFFSET_RET), QRENCODE_ERROR, SIZE_RET);
			return;
		}
		
		p = strrchr(qrfile, '.');
		if(p != NULL)*p = '\0';
		
		i = 1;
		while(tail != NULL){
			snprintf(qrfile_suffix, 
				sizeof(qrfile_suffix), "%s_%02d.png", qrfile, i);
			if(tail->code == NULL) {
				memset(CTX(ctx, OFFSET_RET), QRENCODE_ERROR, SIZE_RET);
				QRcode_List_free(head);
				return;

			}
			if(writePNG(tail->code, qrfile_suffix, size, margin) != 0){
				memset(CTX(ctx, OFFSET_RET), WRITE_PNG_ERROR, SIZE_RET);
				QRcode_List_free(head);
				return;
			}
			tail = tail->next;
			i++;
		}
		i--;

		sprintf(buf, "%02d" , head->code->version);
		memcpy(CTX(ctx, OFFSET_VER), buf, SIZE_VER);
		sprintf(buf, "%02d" , i);
		memcpy(CTX(ctx, OFFSET_NUM), buf, SIZE_NUM);
		QRcode_List_free(head);
	}
	return;
}

#if 0
int
main(int argc, 
	char *argv[])
{
	char buf[OFFSET_RET + SIZE_RET];
	int len;

	if(argc < 7){
		printf("\nusage:orcqrencode <infile> <outfile> <version> <level> <kanji> <comb>\n");
		exit(0);
	}

	memset(buf, 0, sizeof(buf));

	len = strlen(argv[1]);
	snprintf(CTX(buf, OFFSET_INFILE), SIZE_INFILE, "%s", argv[1]);
	memset(CTX(buf, OFFSET_INFILE) + len, ' ', SIZE_INFILE - len);
	len = strlen(argv[2]);
	snprintf(CTX(buf, OFFSET_QRFILE), SIZE_QRFILE, "%s", argv[2]);
	memset(CTX(buf, OFFSET_QRFILE) + len, ' ', SIZE_QRFILE - len);
	CTX(buf, OFFSET_INFILE)[SIZE_INFILE-1] = 0;
	CTX(buf, OFFSET_QRFILE)[SIZE_QRFILE-1] = 0;

	memcpy(CTX(buf, OFFSET_SL), argv[4], SIZE_SL);
	memcpy(CTX(buf, OFFSET_SS), "3", SIZE_SS);
	memcpy(CTX(buf, OFFSET_SM), "1", SIZE_SM);
	memcpy(CTX(buf, OFFSET_SV), argv[3], SIZE_SV);
	memcpy(CTX(buf, OFFSET_SK), argv[5], SIZE_SK);
	memcpy(CTX(buf, OFFSET_LC), argv[6], SIZE_LC);

	printf("infile:%s\n", CTX(buf, OFFSET_INFILE));
	printf("qrfile:%s\n", CTX(buf, OFFSET_QRFILE));

	orcqrencode(buf);

	printf("infile:%s\n", CTX(buf, OFFSET_INFILE));
	printf("qrfile:%s\n", CTX(buf, OFFSET_QRFILE));
	printf("l:%02x\n", *CTX(buf, OFFSET_SL));
	printf("s:%02x\n", *CTX(buf, OFFSET_SS));
	printf("m:%02x\n", *CTX(buf, OFFSET_SM));
	printf("v:%02x%02x\n", *CTX(buf, OFFSET_SV), *CTX(buf, OFFSET_SV+1));
	printf("k:%02x\n", *CTX(buf, OFFSET_SK));
	printf("C:%02x\n", *CTX(buf, OFFSET_LC));
	printf("ver:%02x%02x\n", *CTX(buf, OFFSET_VER), *CTX(buf, OFFSET_VER+1));
	printf("num:%02x%02x\n", *CTX(buf, OFFSET_NUM), *CTX(buf, OFFSET_NUM+1));
	printf("ret:%02x\n", *CTX(buf, OFFSET_RET));

	return 0;
}
#endif
