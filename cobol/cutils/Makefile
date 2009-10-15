CSRCS = \
	orcfiledel.c \
	orcfileio.c \
	cobabort.c \
	coblog.c \
	cobsleep.c

CJSRCS = orcsjistoeuc.c

CJQSRCS = orcqrencode.c

CJKANJIOBJS = kanaconv.so orcsstring.so

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

.SUFFIXIES: .c .o
.c.o:
	$(CC) -fPIC -c  $<

kanaconv.so: kanaconv.o euc.o
	$(CC) -shared -Wl,-soname,kanaconv.so -o $@ $?

orcsstring.so: orcsstring.o euc.o
	$(CC) -shared -Wl,-soname,orcsstring.so -o $@ $?

