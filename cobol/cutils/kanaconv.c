#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

#include "kanaconv.h"

#define ISZENKAKU(c)    	(((c) >= 0xa1) && ((c) <= 0xfe))
#define ISJIS208(c)     	((((c) >= 0xa1) && ((c) <= 0xa8)) || (((c) >= 0xb0) && ((c) <= 0xf4)))
#define ISHANKAKUKANA(c)	(((c)&0xff) == 0x8e)
#define ISDAKU(c)			(((c)&0xff) == 0xde)
#define ISHANDAKU(c)		(((c)&0xff) == 0xdf)
#define ISHIRAGANA(c)		(((c)&0xff) == 0xa4)
#define ISKATAKANA(c)		(((c)&0xff) == 0xa5)
#define MAYBEDAKU(c)		((c)-0xb6u < 15 || (c)-0xcau < 5)
#define MAYBEHANDAKU(c)		((c)-0xcau < 5)
#define ISHANKAKU(c)		(((c)&0xff) <= 0x7e)
#define ISLF(c)         	(((c)&0xff) == 0x0a)
#define ISG3(c)         	(((c)&0xff) == 0x8f)
#define ISSPACEONLY(c)     	(((c)&0xff) == 0x20)

/* 0x8E0xA1 - 0x8E0xDF */
const unsigned char kana_table[][2] = 
{
	"\241\243", "\241\326", "\241\327",	"\241\242",
	"\241\246", "\245\362", "\245\241", "\245\243",
	"\245\245", "\245\247", "\245\251",	"\245\343",
	"\245\345", "\245\347", "\245\303",	"\241\274",
	"\245\242", "\245\244", "\245\246", "\245\250",
	"\245\252", "\245\253", "\245\255",	"\245\257",
	"\245\261", "\245\263", "\245\265",	"\245\267",
	"\245\271", "\245\273", "\245\275",	"\245\277",
	"\245\301", "\245\304", "\245\306",	"\245\310",
	"\245\312", "\245\313", "\245\314",	"\245\315",
	"\245\316", "\245\317", "\245\322",	"\245\325",
	"\245\330", "\245\333", "\245\336",	"\245\337",
	"\245\340", "\245\341", "\245\342",	"\245\344",
	"\245\346", "\245\350", "\245\351",	"\245\352",
	"\245\353", "\245\354", "\245\355",	"\245\357",
	"\245\363", "\241\253", "\241\254"
};

/* 0x20 - 0x7E */
const unsigned char ascii_table[][2] = 
{
	"\241\241", "\241\252", "\241\311", "\241\364",
	"\241\360",	"\241\363", "\241\365", "\241\307",
	"\241\312",	"\241\313", "\241\366", "\241\334",
	"\241\244",	"\241\335", "\241\245", "\241\277",
	"\243\260",	"\243\261", "\243\262", "\243\263", 
	"\243\264",	"\243\265", "\243\266", "\243\267",
	"\243\270",	"\243\271", "\241\247", "\241\250",
	"\241\343",	"\241\341", "\241\344", "\241\251",
	"\241\367",	"\243\301", "\243\302", "\243\303",
	"\243\304",	"\243\305", "\243\306", "\243\307",
	"\243\310",	"\243\311", "\243\312", "\243\313",
	"\243\314",	"\243\315", "\243\316", "\243\317",
	"\243\320",	"\243\321", "\243\322", "\243\323",
	"\243\324",	"\243\325", "\243\326", "\243\327",
	"\243\330",	"\243\331", "\243\332", "\241\316",
	"\241\300",	"\241\317", "\241\260", "\241\262",
	"\241\256",	"\243\341", "\243\342", "\243\343",
	"\243\344",	"\243\345", "\243\346", "\243\347",
	"\243\350",	"\243\351", "\243\352", "\243\353",
	"\243\354",	"\243\355", "\243\356", "\243\357",
	"\243\360",	"\243\361", "\243\362", "\243\363",
	"\243\364",	"\243\365", "\243\366", "\243\367",
	"\243\370",	"\243\371", "\243\372", "\241\320",
	"\241\303",	"\241\321", "\241\301"
};

const unsigned char henkan_funou[] = { 0xa2, 0xa3 };

void
StringCobol2C(
	char	*str,
	size_t	size)
{
	char	*p;

	for	( p = str + size - 1 ; p >= str ; p -- ) {
		if (  *p  ==  ' '  ) {
			*p = 0;
		} else if (  *p  ==  0  ) {
			/*	*/
		} else {
			break;
		}
	}
}

void
StringC2Cobol(
	char	*str,
	size_t	size)
{
	int i;
	int fEnd;

	fEnd = 0;
	for	( i = 0 ; i < size ; i ++, str ++ ) {
		if		(  *str  ==  0  )	{
			fEnd = 1;
		}
		if		(  fEnd  ) {
			*str = ' ';
		}
	}
}

int 
search_ascii_zenkaku(unsigned char d0, unsigned char d1)
{
	int i;
	unsigned char c0, c1;

	for (i=0; c0 = ascii_table[i][0], c1 = ascii_table[i][1] ;i++){
		if ( (d0 == c0) && (d1 == c1) ){
			return (0x20+i);
		}
	}
	return 0;
}


int
asciiconv(int conv_flg,
		  int char_type,
		  unsigned char inputChar,
		  ConvertChar *cchar)
{
	int advanced_bytes;

	advanced_bytes = 1;
	cchar->in_type = KIGOU;

	if ( isgraph(inputChar) || ISSPACEONLY(inputChar) ) {
		if ( (conv_flg) && (char_type & ZENKAKU) ){
			cchar->out_type = OTHER;
			cchar->out_len = 2;
			cchar->out_char[0] = ascii_table[(inputChar - 0x20)][0];
			cchar->out_char[1] = ascii_table[(inputChar - 0x20)][1];
		} else {
			cchar->out_len = 1;
			cchar->out_char[0] = inputChar;
			cchar->out_type = KIGOU;
			if ( isdigit(cchar->out_char[0]) ){
				cchar->in_type = NUMBER;
				cchar->out_type = NUMBER;
			} else if ( isalpha(cchar->out_char[0]) ){
				cchar->in_type  = ALPHA;
				cchar->out_type = ALPHA;
			}
		}
	} else if ( ISLF(inputChar) ){
		cchar->out_type = KIGOU;
		cchar->out_len = 1;
		cchar->out_char[0] = inputChar;
	} else {
		/* do nothing */
		cchar->in_type = UNKNOWN;
		cchar->out_type = UNKNOWN;
		cchar->out_len = 0;
	}
	return advanced_bytes;
}

int
hankakukanaconv(int conv_flg,
				int char_type,
				unsigned char c0,
				unsigned char c1,
				unsigned char c2,
				unsigned char c3,
				ConvertChar *cchar)
{
	int advanced_bytes;

	advanced_bytes = 2;
	cchar->out_len   = 2;
	cchar->in_type = HKANA;
	cchar->out_type = KATAKANA;
	cchar->out_char[0] = (char )kana_table[(c1 - 0xa1)][0];
	cchar->out_char[1] = (char )kana_table[(c1 - 0xa1)][1];
	if ( c2 != '\0' ){
		if (MAYBEDAKU(c1) && ISDAKU(c3)) {
			cchar->out_char[1] += 1;
			advanced_bytes += 2;
		}
		if (MAYBEHANDAKU(c1) && ISHANDAKU(c3)) {
			cchar->out_char[1] += 2;
			advanced_bytes += 2;
		}
	}
	return advanced_bytes;
}

void
gaiji(ConvertChar *cchar)
{
	cchar->out_len   = 2;
	cchar->in_type = GAIJI;
	cchar->out_type = OTHER;
	cchar->out_char[0] = henkan_funou[0];
	cchar->out_char[1] = henkan_funou[1];
}


int 
zenkakuconv(int conv_flg,
			int char_type,
			unsigned char c0,
			unsigned char c1,
			ConvertChar *cchar)
{
	unsigned char c;
	int advanced_bytes;

	if ( ISZENKAKU(c1)){
		advanced_bytes = 2;	
		cchar->in_type = ZENKAKU;
		if ( ISJIS208(c0) ){
			if ( (conv_flg) && (char_type & ASCII) 
				 && ( (c0 == 0xa1) || (c0 == 0xa3) )
				 && (c = search_ascii_zenkaku(c0, c1)) ) {
				cchar->out_type = KIGOU;
				cchar->out_len   = 1;
				cchar->out_char[0] = c;
				if ( isdigit(cchar->out_char[0]) ){
					cchar->out_type = NUMBER;
				} else if ( isalpha(cchar->out_char[0]) ){
					cchar->out_type = ALPHA;
				}
			} else {
				cchar->out_type = OTHER;
				cchar->out_len   = 2;
				cchar->out_char[0] = c0;				
				cchar->out_char[1] = c1;
				if ( ISHIRAGANA(cchar->out_char[0]) ){
					cchar->in_type  = HIRAGANA;
					cchar->out_type = HIRAGANA;
				}
				if ( ISKATAKANA(cchar->out_char[0]) ){
					cchar->in_type  = KATAKANA;
					cchar->out_type = KATAKANA;
				}
			}
			
		} else { /* GAIJI*/
			gaiji(cchar);
		}
	} else { /* invalid char */ 
		advanced_bytes = 1;	
		cchar->in_type = UNKNOWN;
		cchar->out_type = UNKNOWN;
		cchar->out_len = 0;
	}

	return advanced_bytes;
}

int
g3conv(int conv_flg,
	   int char_type,
	   unsigned char c0,
	   unsigned char c1,
	   unsigned char c2,
	   ConvertChar *cchar)
{
	int advanced_bytes;
	
	if ( ISZENKAKU(c1) && ISZENKAKU(c2)){
		advanced_bytes = 3;
		gaiji(cchar);
	} else {
		advanced_bytes = 1;
		cchar->in_type = UNKNOWN;
		cchar->out_type = UNKNOWN;
		cchar->out_len = 0;
	}
	
	return advanced_bytes;
}

void
tokatakana(ConvertChar *cchar)
{
	if ( cchar->out_type == HIRAGANA ){
		cchar->out_type = KATAKANA;
		cchar->out_char[0]++;
	}
}

void
tohiragana(ConvertChar *cchar)
{
	if ( cchar->out_type == KATAKANA ) {
		cchar->out_type = HIRAGANA;
		cchar->out_char[0]--;
	}
}

int
kana_euc_convert (int conv_flg,
				  int char_type,
				  size_t max_len,
				  size_t *ret_len,
				  char *inchar,
				  char *ouchar)
{
	int advanced_bytes;
	ConvertChar ochar, *cchar;
	unsigned char c0, c1, c2, c3;
	char *p;
	int i, ret;
	int intype = 0;
	size_t current_len = 0;
	
	cchar = &ochar;
	p = ouchar;
	ret = 0;

	while (*inchar) {
		c0 = *inchar;     c1 = *(inchar+1);
		c2 = *(inchar+2); c3 = *(inchar+3);

		if        ( ISHANKAKUKANA(c0) ) {
			advanced_bytes = hankakukanaconv(conv_flg, char_type, 
											 c0, c1, c2, c3, cchar);
		} else if ( ISZENKAKU(c0) ) {
			advanced_bytes = zenkakuconv(conv_flg, char_type, c0, c1, cchar);
		} else if ( ISG3(c0)) {
			advanced_bytes = g3conv(conv_flg, char_type, c0, c1, c2, cchar);
		} else {   /* ASCII */
			advanced_bytes = asciiconv(conv_flg, char_type, c0, cchar);
		}

		if        ( (conv_flg == 2) && (char_type & KATAKANA) ) {
			tokatakana(cchar);
		} else if ( (conv_flg == 3) && (char_type & HIRAGANA) ) {
			tohiragana(cchar);
		}
		inchar += advanced_bytes;
		if ( (conv_flg) && (!(cchar->out_type & char_type)) ) {
			ret = 1;
		} else {
			if ( max_len < (current_len + cchar->out_len)) {
				break;
			}
			current_len += cchar->out_len;
			for (i = 0; i < cchar->out_len; i++){
				*p++ = cchar->out_char[i];
			}
		}
		intype = intype | cchar->in_type;
	}
	*p++ = '\0';
	*ret_len = current_len;

	if ( conv_flg == 0 ) {
		if ( (intype | char_type) != char_type ){
			ret = 1;
		}
	}
	if ( intype >= GAIJI ) {
		ret = 2;
	}
	return ret;
}

/*
   for OpenCOBOL 
   arg {
       int len,
       int ret_val,
       int ret_len,
       int conv_flg,
       int char_type,
       int str_len,
       char org_str[str_len],
       char new_str[str_len]
   }
*/
extern int
kanaconv (char *args)
{
	int conv_flg, char_type;
	int *ret_val;
	size_t len, str_len;
	size_t *ret_len;
	char *org_str, *new_str;
	char *p;

	p = args;

	len = *(size_t *)(p);

	p += sizeof(int);
	ret_val = (int *)(p);

	p += sizeof(int);
	ret_len = (size_t *)(p);

	p += sizeof(int);
	conv_flg = *(int *)(p);

	p += sizeof(int);
	char_type = *(int *)(p);

	p += sizeof(int);
	str_len = *(size_t *)(p);

	p += sizeof(int);
	org_str = p;
	StringCobol2C(org_str, str_len);

	p += str_len;
	new_str = p;
	StringCobol2C(new_str, str_len);

	if ( str_len < len){
		len = str_len;
	}
	*ret_val = kana_euc_convert(conv_flg, char_type, len, ret_len,
							 org_str, new_str);

	StringC2Cobol(org_str, str_len);
	StringC2Cobol(new_str, str_len);

	return *ret_val;
}
