SRCS = ORCGW01.CBL \
       ORCGW02.CBL \
       ORCGW03.CBL \
       ORCGW04.CBL \
       ORCGW05.CBL \
       ORCGW06.CBL \
       ORCGW07.CBL \
       ORCGW08.CBL \
       ORCGW09.CBL \
       ORCGW10.CBL \
       ORCGW11.CBL \
       ORCGW12.CBL \
       ORCGWERR.CBL \
       ORCGWID1.CBL \
       ORCGW13.CBL \
       ORCGW14.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global
install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
