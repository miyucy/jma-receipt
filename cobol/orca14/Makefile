SRCS = ORCGY01.CBL \
       ORCGY03.CBL \
       ORCGY04.CBL \
       ORCGYERR.CBL \
       ORCHC14.CBL \
       ORCHC15.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
