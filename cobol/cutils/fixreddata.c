#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <libxml/xmlreader.h>

#include "euc.h"

static	char	*
Strndup(
	char	*s,
	size_t	len)
{
	char	*str;

	if (s != NULL){
		str = malloc(len+1);
		strncpy(str,s,len);
		str[len] = '\0';
	} else {
		str = NULL;
	}
	return	(str);
}

static int
CheckEuc213(
	char *p,
	int size)
{
	int i;
	int advanced_bytes;
	int count;
	int is213;
	int rc;
	char *buf;
	char *in;
	char out[4];

	rc = 1;
	in = buf = Strndup(p,size);
	count = 0;
	while(*in) {
		advanced_bytes = jis213_count(in, out, &is213);
		if (is213 == -1) {
			*(p+count) = ' ';
			*(buf+count) = ' ';
			rc = 0;
		}
		in += advanced_bytes;
		count += advanced_bytes;
	}
#if 0
printf("CheckEuc213 buf[%s]\n",buf);
#endif
	free(buf);
	return rc;
}

static xmlChar *
GetAttributeValue(
	xmlTextReaderPtr reader,
	const xmlChar *name)
{
	if (!xmlTextReaderMoveToAttribute(reader,name)) {
		return NULL;
	}	
	return xmlTextReaderValue(reader);
}

int
GetObjectSize(xmlTextReaderPtr reader)
{
	char *name;
	char *value;
	int size;
	int isString;
	
	size = 0;
	isString = 0;
	if ((name = xmlTextReaderName(reader)) != NULL) {
		if (!xmlStrcmp(name, "embed")) {
			if ((value = GetAttributeValue(reader, "object")) != NULL) {
				if (!xmlStrcmp(value, "string")) {
					isString = 1;
				}
				xmlFree(value);
			}
			if (isString) {
				if ((value = GetAttributeValue(reader, "length")) != NULL) {
					size = atoi(value);
					xmlFree(value);
				}
			}
		}
		xmlFree(name);
	}
	return size;
}

/*
	for OpenCOBOL 
	arg {
		int psize;
		int dsize;
		int result
		char path[psize],
		char data[dsize],
	}
*/
extern void
fixreddata (char *args)
{
	int psize;
	int dsize;
	int block_size;
	int done_size;
	int *rc;
	char *path;
	char *data;
	int status;
	char *p;
	char *q;
	xmlTextReaderPtr reader;

	p = args;

	psize = *(size_t *)(p);
    p += sizeof(int);

	dsize = *(size_t *)(p);
    p += sizeof(int);

	rc = (int *)(p);
	*rc = 0;
    p += sizeof(int);

	path = Strndup(p,psize);
	StringCobol2C(path, psize);
	p += psize;

	data = Strndup(p,dsize);
	StringCobol2C(data, dsize);
	p += dsize;

#if 0
printf("in fixreddata\n");
printf("psize[%d] dsize[%d] rc[%d]\n",psize,dsize,*rc);
printf("path[%s]\n",path);
printf("data[%s]\n",data);
#endif

	done_size = 0;
	reader = xmlNewTextReaderFilename(path);
	if (reader != NULL) {
		p = data;
		status = xmlTextReaderRead(reader);
		while(status == 1) {
			status = xmlTextReaderRead(reader);
			if ((block_size = GetObjectSize(reader)) > 0) {
#if 0
printf("block size[%d]\n",block_size);
#endif
				if (block_size + done_size > dsize) {
					printf("the size of data is insufficient.need [%d],but [%d]\n",block_size + done_size, dsize);
					*rc = 3;
					break;
				}
				if(!CheckEuc213(p,block_size)) {
					*rc = 1;
				}
				p += block_size;
				done_size += block_size;
			}
		}
		xmlFreeTextReader(reader);
	} else {
		printf("Unable to open %s\n",path);
		*rc = 2;
	}
#if 0
printf("%s\n",data);
printf("%d\n",*rc);
#endif
	memcpy(args + sizeof(int) * 3 + psize ,data, dsize);
	free(path);
	free(data);
}

int
main(
	int argc,
	char *argv[])
{
	struct _prefix{
		int psize;
		int dsize;
		int rc;
	};

	struct _prefix pre;
	struct _prefix *p;
	char *arg;
	char *path;
	char *data;

	if (argc < 3) {
		printf("./%s <red> <data>\n",argv[0]);
		exit(1);
	}

	pre.psize = strlen(argv[1]);
	pre.dsize = strlen(argv[2]);
	pre.rc = 0;
	
	arg = malloc(sizeof(struct _prefix) + pre.psize + pre.dsize);
	memcpy(arg, &pre, sizeof(struct _prefix));
	memcpy(arg + sizeof(struct _prefix), argv[1], pre.psize);
	memcpy(arg + sizeof(struct _prefix) + pre.psize, argv[2], pre.dsize);

	fixreddata(arg);
	p = (struct _prefix *)arg;
	path = Strndup(arg + sizeof(struct _prefix),p->psize);
	data = Strndup(arg + sizeof(struct _prefix) + p->psize,p->dsize);
printf("%s\n",data);
printf("%d\n",p->rc);

	return 0;
}
