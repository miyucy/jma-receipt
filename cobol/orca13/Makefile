SRCS = ORCGQ01.CBL \
       ORCGQ02.CBL \
       ORCGQ98.CBL \
       ORCGQ99.CBL \
       ORCGQERR.CBL \
       ORCGQID1.CBL \
       ORCGQSUB01.CBL \
       ORCGQ97.CBL \
       ORCGQ100.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global
install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
