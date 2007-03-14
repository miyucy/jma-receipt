#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include <jconv.h>

//�Ϥ���Ƥ����ǡ������ɤ߼���Ѵ���¹Ԥ���᥽�å�
//���ϡ����֤ˡ�������ʸ��MAX������ʸ�����Ѵ���ʸ�����Ѵ�ʸ��MAX���Ѵ���ΥХ��ȿ����꥿���󥳡��ɡס�ʸ���󷿡�
//���ϡ����֤ˡ����Ѵ����ʸ�����Ѵ���ΥХ��ȿ����꥿���󥳡��ɡס�ʸ���󷿡�
extern int orcsjistoeuc(char *args){
        int inlen, outlen;
        int *maxlen;
        char *indata;char *outdata;int *ret;
int count = 0;
unsigned char ret_data[2009];

inlen = *((int *)(args + count));
count += sizeof(int *);

indata = (args + count);
count += 1000;

outdata = (args + count);
count += 2000;

outlen = *((int *)(args + count));
count += sizeof(int *);

maxlen = ((int *)(args + count));
count += sizeof(int *);

ret = ((int *)(args + count));

        sjis_to_euc(inlen, indata, outdata, outlen, maxlen, ret);


count = 0;

memcpy(((char *)(ret_data + count)), outdata, 2000);
count += 2000;

*((int *)(ret_data + count)) = *maxlen;
count += sizeof(int);

*((int *)(ret_data + count)) = *ret;

return *ret_data;
}

//SJIS�����ɤǽ񤫤줿ʸ�����EUC�����ɤ��Ѵ�����᥽�å�
//���ϡ���������֤ˡ�inlen(����ʸ��MAX),indata(����ʸ��),outdata(�Ѵ����ʸ��),outlen(�Ѵ�ʸ��MAX),maxlen(�Ѵ���ΥХ��ȿ�),ret(�꥿���󥳡���)��
int sjis_to_euc(int inlen, char *indata, char *outdata,
         int outlen, int *maxlen,int *ret){
 char *euc_data;
 int count = 0;
 int count2 = 0;
 int i = 0;
 int ret_flag = 0;
 int str_len;
 unsigned char str1,str2;
 unsigned char *str;
 unsigned char tr_str[4];
 unsigned char str_data[2000];
 char strdata[3];
 unsigned char *pnt_str1,*pnt_str2;  
 
   StringCobol2C(indata, inlen);
         *maxlen = strlen(indata);
 while(i <= *maxlen){
 str1 = *(indata + count);
 str2 = *(indata + count + 1);
 if(((0x00 < str1) && (str1 <= 0x7F)) || ((0xA0 <= str1) && (str1 <= 0xDF))){
count += 1;
 }else if(((str1 >= 0x80) && (str1 <= 0x9F)) || ((str1 >= 0xE0) && (str1 <= 0xFC))){
count += 2;
ret_flag = 1;
break;
}else{
str1 = 0x20;
count += 2;
}
i++;
 }
         euc_data = convert_kanji_strict(indata, "EUCJP", "SJIS");
 if((!strcmp(euc_data,indata)) && (ret_flag == 1)){
 *ret = 1;
 count = 0;
 count2 = 0;
 while(count <= *maxlen){
 ret_flag = 0;
  count2 = count;
  str1 = *(indata + count);
 str2 = *(indata + count + 1);
 if(((0x00 < str1) && (str1 <= 0x7F)) || ((0xA0 <= str1) && (str1 <= 0xDF))){
 count += 1;
 }else if(((0x80 <= str1) && (str1 <= 0x9F)) || ((0xE0 <= str1) && (str1 <= 0xFC))){
if((str1 == 0x87) && ((0x40 <= str2) && (str2 <= 0x9C))){
str1 = 0x20;
str2 = 0x20;
}
strdata[0] = str1;
strdata[1] = str2;
strdata[2] = '\0';
ret_flag = 1;
 count += 2;
 }else{
 str1 = 0x20;
 count += 2;
 }
 if(ret_flag == 0){
 str = convert_kanji_strict(&str1, "EUCJP", "SJIS");
 }else{
 str = convert_kanji_strict(&strdata[0], "EUCJP", "SJIS");
 }
 str_len = strlen(str);
 memcpy((char *)(str_data + count2), str, str_len);
 free(str);
 }
 printf("%c\n",str_data[3]);
 strcpy(outdata, str_data);
 }else{
 *ret = 0;
 strcpy(outdata, euc_data);
 }
 free(euc_data);
// StringC2Cobol(outdata, outlen);
*maxlen = StringC2Cobol(outdata, outlen);
}


//COBOL������ʸ����ǡ�����C�������Ѵ�����᥽�å�
//���ϡ���������֤ˡ�str(�Ѵ�����ʸ����),size(ʸ����MAX)��
int StringCobol2C(char *str, size_t size){
         char *p;
         for( p = str + size - 1 ; p >= str ; p -- ) {
                   if (  *p  ==  ' '  ) {
                            *p = 0;
                   } else if (  *p  ==  0  ) {
                            /*      */
                   } else {
                            break;
                   }
         }
 return 0;
}


//C������ʸ����ǡ�����C�������Ѵ�����᥽�å�
////���ϡ���������֤ˡ�str(�Ѵ�����ʸ����),size(ʸ����MAX)��
int StringC2Cobol(char *str, size_t size){
	int i;
	int cnt;
	int fEnd;
	fEnd = 0;
	cnt = 0;
	for( i = 0 ; i < size ; i ++, str ++ ) {
		if( fEnd ) {
			*str = ' ';
		} else if(*str == 0) {
			fEnd = 1;
		} else {
			cnt++ ;
			}
	}
	return cnt;
}

