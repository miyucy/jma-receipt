#include <ctype.h>
#include <stdlib.h>

#include "kanaconv.h"

#define ISZENKAKU(c)    	(((c) >= 0xa1) && ((c) <= 0xfe))
#define ISJIS208(c)     	(((c) >= 0xa1) && ((c) <= 0xf4))
#define ISHANKAKUKANA(c)	(((c)&0xff) == 0x8e)
#define ISDAKU(c)			(((c)&0xff) == 0xde)
#define ISHANDAKU(c)		(((c)&0xff) == 0xdf)
#define MAYBEDAKU(c)		((c)-0xb6u < 15 || (c)-0xcau < 5)
#define MAYBEHANDAKU(c)		((c)-0xcau < 5)
#define ISHANKAKU(c)		(((c)&0xff) <= 0x7e)
#define ISLF(c)         	(((c)&0xff) == 0x0a)
#define ISG3(c)         	(((c)&0xff) == 0x8f)
#define ISSPACEONLY(c)     	(((c)&0xff) == 0x20)

const unsigned char henkan_funou[] = { 0xa2, 0xa3 };

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
	char	*p,
	size_t	size)
{
	int i;
	int fEnd;

	fEnd = 0;
	for	( i = 0 ; i < size ; i ++, p ++ ) {
		if		(  *p  ==  0  )	{
			fEnd = 1;
		}
		if		(  fEnd  ) {
			*p = ' ';
		}
	}
}

void
tokatakana (char *org_str,
			char *new_str)
{
	unsigned char c;
	
	while(c = *org_str++){
		if ( ((c)&0xff) == 0xa4) {
			*new_str++ = ++c;
			*new_str++ = *org_str++;
		} else {
			*new_str++ = c;			
		}
	}
	*new_str++ = 0;
}

void
tohiragana (char *org_str,
			char *new_str)
{
	unsigned char c;
	
	while(c = *org_str++){
		if ( ((c)&0xff) == 0xa5) {
			*new_str++ = --c;
			*new_str++ = *org_str++;
		} else {
			*new_str++ = c;			
		}
	}
	*new_str++ = 0;
}

int 
search_ascii_zenkaku(unsigned char d0, unsigned char d1)
{
	int i;
	unsigned char c0, c1;
	
	i = 0;
	while ( c0 = ascii_table[i][0], c1 = ascii_table[i][1]){
		if ( d0 == c0 && d1 == c1){
			return (0x20+i);
		}
		i++;
	}
	return 0;
}

extern void
tohankaku (int    syori_flg,
		   size_t size,
		   char   *org_str,
		   char   *new_str)
{
	int ret = 0, i;
	size_t new_len = 0;
	unsigned char c, d0, d1;

	while ( d0 = *org_str++ ){
		d1 = *org_str;
		if (c = search_ascii_zenkaku(d0, d1)) {
			*new_str++ = c;
			org_str++;
		} else {
			*new_str++ = d0;
		}
	}
	*new_str++ = 0;
}

int
hankakukanaconv(unsigned char c1,
				struct COBString *org,
				struct COBString *new )
{
	new->ptr += 2;
	if ( new->ptr > new->len) {
		return -1;
	}
	*new->body++ = (char )kana_table[(c1 - 0xa1)][0];
	*new->body++ = (char )kana_table[(c1 - 0xa1)][1];
	if ( *(org->body) != '\0' ){
		if (MAYBEDAKU(c1) && ISDAKU(*(org->body+1))) {
			new->body[-1]++;     org->body += 2; 
		}
		if (MAYBEHANDAKU(c1) && ISHANDAKU(*(org->body+1))) {
			new->body[-1] += 2;  org->body += 2; 
		}
	}

	return 0;
}

int
zenkakuconv(int syori_flg,
			unsigned char c0,
			unsigned char c1,
			struct COBString *new )
{
	unsigned char c;
	
	if (    (syori_flg == TOHANKAKU) 
		 && (c0 == 0xa3)
		 && (c = search_ascii_zenkaku(c0, c1)) ) {
		new->ptr++;
		if ( new->ptr > new->len) {
			return -1;
		}
		*new->body++ = c;
	} else {
		new->ptr += 2;
		if ( new->ptr > new->len) {
			return -1;
		}
		if ( ISZENKAKU(c1)){
			if ( ISJIS208(c0) ){
				*new->body++ = c0;
				*new->body++ = c1;
			} else { /* GAIJI*/
				*new->body++ = henkan_funou[0];
				*new->body++ = henkan_funou[1];
			}
		} else { /* invalid char */ 
			*new->body++ = henkan_funou[0];
			*new->body++ = henkan_funou[1];
		}
	}
	return 0;
}

int
g3conv(unsigned char c0,
	   unsigned char c1,
	   unsigned char c2,
	   struct COBString *new )
{
	new->ptr += 2;
	if ( new->ptr > new->len) {
		return -1;
	}
	*new->body++ = henkan_funou[0];
	*new->body++ = henkan_funou[1];

	return 0;
}

int
asciiconv(int syori_flg,
		  unsigned char c0,
		  struct COBString *new )
{
	if ( isgraph(c0) || ISSPACEONLY(c0) ) {
		if (syori_flg == TOZENKAKU){
			new->ptr += 2;
			if ( new->ptr > new->len) {
				return -1;
			}
			*new->body++ = ascii_table[(c0 - 0x20)][0];
			*new->body++ = ascii_table[(c0 - 0x20)][1];
		} else {
			new->ptr++;
			if ( new->ptr > new->len) {
				return -1;
			}
			*new->body++ = c0;
		}
	} else if ( ISLF(c0) ){
		new->ptr++;
		if ( new->ptr > new->len) {
			return -1;
		}
		*new->body++ = c0;
	} else {
		/* do nothing */
	}
	
	return 0;
}

extern int
tozenkaku (int    syori_flg,
		   struct COBString *org,
		   struct COBString *new )
{
	int ret = 0;
	size_t new_len = 0;
	char *org_str, *new_str;
	unsigned char c0, c1, c2;

	org_str = org->body;
	new_str = new->body;

	while( (c0 = *org->body++) && (ret >= 0)){
		if ( ISHANKAKUKANA(c0) ){
			c1 = *org->body++;
			ret = hankakukanaconv(c1, org, new);
		} else if ( ISZENKAKU(c0) ) {
			c1 = *org->body++;
			ret = zenkakuconv(syori_flg, c0, c1, new );
		} else if ( ISG3(c0) ) { 
			c1 = *org->body++;	c2 = *org->body++;
			ret = g3conv(c0, c1, c2, new);
		} else {
			ret = asciiconv(syori_flg, c0, new);
		}
	}
	*new->body++ = 0;
	org->body = org_str;
	new->body = new_str;
	return ret;
}

/*
   for OpenCOBOL 
   arg {
       int len,
       int ret_val,
       int syori_flg,
       int str_len,
       char org_str[str_len],
       char new_str[str_len]
   }
*/
extern int
kanaconv (char *args)
{
	int len, str_len, syori_flg;
	int *ret_val;
	char *org_str, *new_str;
	char *p;
	struct COBString *org, *new;

	org = New(struct COBString);
	new = New(struct COBString);
	
	p = args;

	len = *(int *)(p);
	p += sizeof(int);
	
	ret_val = (int *)(p);
	p += sizeof(int);

	syori_flg = *(int *)(p);
	p += sizeof(int);
	
	str_len = *(int *)(p);
	p += sizeof(int);

	org->body = p;
	org->len = str_len;
	org->ptr = 0;

	StringCobol2C(org->body, str_len);
	p += str_len;

	new->body = p;
	new->len = len;
	new->ptr = 0;
	
	*ret_val = tozenkaku(syori_flg, org, new);
	StringC2Cobol(org->body, str_len);
	StringC2Cobol(new->body, str_len);
	return *ret_val;
}
