SRCS = ORCGP97.CBL \
       ORCGP97ERR.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global
install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
