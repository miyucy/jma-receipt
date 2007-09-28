/*
 * orcqrencode - QR Code encode front end for jma-receipt
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <png.h>
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
	char *p, *q;
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

	p = sjis;
	q = out;
	while(*p != '\0' && (q - out) < MAX_DATA_SIZE){
		if(*p == 0x0a){
			*q = 0x0d;
			q++;
		}
		*q = *p;
		p++;
		q++;
	}
	*q = '\0';
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

	if(euc2sjis( CTX(ctx, OFFSET_INFILE), buf) != 0){
		memset(CTX(ctx, OFFSET_RET), CHAR_CONV_ERROR, SIZE_RET);
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
		code = QRcode_encodeString(buf, version, level, hint);
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
		head = tail = QRcode_encodeStringStruct(buf, 
			strlen(buf), 
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
