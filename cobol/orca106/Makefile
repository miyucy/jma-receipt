SRCS = ORCGN11.CBL \
       ORCGN11ERR.CBL \
       ORCGN11ID1.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global
install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
