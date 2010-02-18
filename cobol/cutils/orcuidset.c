/*
 orca
      uid set proc by using uuidgen command
      gcc -fPIC -shared orcuidset.c -o liborcuidset.so
*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>

/* 窓口関数 */
extern void orcuidset(int hWnd, char *arg) ;

/* 窓口関数で使用する形の構造体形式  */
struct str_chardata_contact
{
	char	retcd[2] ;
	char	str_uid[36] ;
};

void orcuidset(int hWhd, char *arg)
{
	char buf[256] ;
	struct str_chardata_contact	*lt_contact ;

	FILE* pipe = popen("uuidgen -t", "r") ;
	fgets(buf, sizeof(buf), pipe ) ; 
	pclose(pipe) ;

	lt_contact = (struct str_chardata_contact *)arg ;
	if(buf[0] == ' '){
		lt_contact->retcd[0] = '-' ;
		lt_contact->retcd[1] = '1' ;
		return ;
	}
	strncpy(lt_contact->str_uid, buf, 36) ;
	lt_contact->retcd[0] = '0' ;
	lt_contact->retcd[1] = '0' ;
	return ;
}
/*
int main(void)
{
	char	lt_contact[256] ;
	uidset( 0, lt_contact) ;
	printf("ret = %s\n",lt_contact);
}
*/
