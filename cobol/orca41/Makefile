SRCS = ORCGD01.CBL \
       ORCGD02.CBL \
       ORCGD03.CBL \
       ORCGD04.CBL \
       ORCGDERR.CBL \
       ORCGDID2.CBL \
       ORCGDID1.CBL \
       ORCGD99.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global

install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
