SRCS = ORCGL01.CBL \
       ORCGL99.CBL \
       ORCGLERR.CBL \
       ORCGLID1.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global
install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
