SRCS = ORCGC02.CBL \
       ORCGC03.CBL \
       ORCGC04.CBL \
       ORCGC05.CBL \
       ORCGC06.CBL \
       ORCGCERR.CBL \
       ORCGCID1.CBL \
       ORCGC07.CBL \
       ORCGC08.CBL \
       ORCGCID2.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
