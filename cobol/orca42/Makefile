SRCS = ORCGR01.CBL \
       ORCGR02.CBL \
       ORCGR03.CBL \
       ORCGRERR.CBL \
       ORCGRID1.CBL \
       ORCGRID2.CBL \
       ORCGR99.CBL \
       ORCGR04.CBL \
       ORCGR98.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
