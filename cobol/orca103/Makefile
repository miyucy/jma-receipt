SRCS = ORCGX01.CBL \
       ORCGX02.CBL \
       ORCGX98.CBL \
       ORCGXERR.CBL \
       ORCGXID1.CBL \
       ORCHXLST.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
