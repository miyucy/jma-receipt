SRCS = ORCGM00.CBL \
       ORCGM01.CBL \
       ORCGM02.CBL \
       ORCGM95.CBL \
       ORCGMID1.CBL \
       ORCGMERR.CBL \
       ORCGMVER.CBL \
       ORCGM96.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
