SRCS = ORCBD001.CBL \
       ORCBD002.CBL \
       ORCBM001.CBL \
       ORCBM002.CBL \
       ORCBM003.CBL \
       ORCBM004.CBL \
       ORCBM006.CBL \
       ORCBM007.CBL \
       ORCBM008.CBL \
       ORCBM009.CBL \
       ORCBM010.CBL \
       ORCBM011.CBL \
       ORCR0010.CBL \
       ORCR0020.CBL \
       ORCR0025.CBL \
       ORCR0030.CBL \
       ORCR0035.CBL \
       ORCR0050.CBL \
       ORCR0055.CBL \
       ORCR0090.CBL \
       ORCR0091.CBL \
       ORCR0100.CBL \
       ORCR0101.CBL \
       ORCR0102.CBL \
       ORCMUP0000.CBL \
       ORCMUP0001.CBL \
       ORCMUP0011.CBL \
       ORCXRMST1.CBL \
       ORCXRMST2.CBL \
       ORCR0200.CBL \
       ORCR0210.CBL \
       ORCR0300.CBL \
       ORCBM005.CBL \
       ORCBM020.CBL \
       ORCBM021.CBL \
       ORCMUP0021.CBL \
       ORCBM012.CBL \
       ORCMUP0041.CBL \
       ORCR0030_200203.CBL \
       ORCR0090_200203.CBL \
       ORCR0100_200203.CBL \
       ORCBPRT.CBL \
       ORCR0040.CBL \
       ORHCML01.CBL \
       ORHCML02.CBL \
       ORHCML03.CBL \
       ORHCML06.CBL \
       ORHCML07.CBL \
       ORHCML08.CBL \
       ORHCML09.CBL \
       ORCBQ01.CBL \
       ORCR0400.CBL \
       ORCR0410.CBL \
       ORCR0420.CBL \
       ORCR0430.CBL \
       ORCR0435.CBL \
       ORCR0440.CBL \
       ORCR0450.CBL \
       ORCR0460.CBL \
       ORCR0465.CBL \
       ORCR0470.CBL \
       ORCR0475.CBL \
       ORCR0480.CBL \
       ORCR0481.CBL \
       ORCR0490.CBL \
       ORCR0500.CBL \
       ORCR0466.CBL \
       ORCR0482.CBL \
       ORCBD003.CBL \
       ORCR0405.CBL \
       ORCR0467.CBL \
       ORCR0485.CBL \
       ORCR0103.CBL

EXEC_SRCS =  ORCXSMST1.CBL

top_builddir = ../..
include $(top_builddir)/cobol/Makefile.global
install: all
	-@if [ ! -d $(libdir) ]; then \
	  $(MKDIR) $(libdir); \
	fi
	for f in $(OBJS) $(EXEC); do \
	  $(INSTALL) -m 555 $${f} $(libdir) ; done
