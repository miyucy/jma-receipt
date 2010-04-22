dnl Process this file with autoconf to produce a configure script.
AC_INIT
AC_CONFIG_SRCDIR([cobol/orca00/ORCGM01.CBL])

PACKAGE=jma-receipt
AC_SUBST(PACKAGE)
VERSION=`cat VERSION`
AC_SUBST(VERSION)

AC_PREFIX_DEFAULT(/usr/local/orca)

dnl --enable-debug
AC_ARG_ENABLE(debug, [  --enable-debug=[no/yes] turn on debugging [default=yes]],,enable_debug="yes")

if test "x$enable_debug" = "xyes"; then
  DEBUG="debug"
fi

dnl --enable-hosp
AC_ARG_ENABLE(hosp, [  --enable-hosp=[no/yes] support hosp [default=yes]],,enable_hosp="yes")

if test "x$enable_hosp" = "xyes"; then
  HOSP="hosp"
  CLINIC_BED_SET_TO_ZERO="
      *The number of beds is set to 0 with the clinic version start.
      *         MOVE    ZERO                TO  SPA-BEDSU
      *         MOVE    ZERO                TO  SPA-BEDSUIPN
      *The number of beds is set to 0 with the clinic version end."
else
  CLINIC_BED_SET_TO_ZERO="
      *The number of beds is set to 0 with the clinic version start.
               MOVE    ZERO                TO  SPA-BEDSU
               MOVE    ZERO                TO  SPA-BEDSUIPN
      *The number of beds is set to 0 with the clinic version end."
fi

AC_SUBST(DEBUG)
AC_SUBST(HOSP)
AC_SUBST(CLINIC_BED_SET_TO_ZERO)

dnl Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_MAKE_SET

AC_ARG_ENABLE(jconv,
	    [  --enable-jconv  Enable jconv extention [default=yes]],
    	    [if test "$enableval" = "yes"
		    then
		    	have_jconv=yes
		    else
			have_jconv=no
		    fi])

AC_CHECK_HEADERS(jconv.h)
AC_CHECK_LIB(jconv,convert_kanji_strict, 
	[have_jconv=yes JCONV_LIB="-ljconv"], 
	have_jconv=no)
AC_SUBST(have_jconv)
AC_SUBST(JCONV_LIB)

PKG_PROG_PKG_CONFIG
PKG_CHECK_MODULES(png, "libpng12")
PKG_CHECK_MODULES(xml2,
[
	libxml-2.0 >= 2.6.27
])

AC_PATH_PROG(PKG_CONFIG,pkg-config,no)
if test x$PKG_CONFIG = xno; then
	AC_MSG_ERROR(Couldn't find pkg-config)
fi

AC_CHECK_HEADERS(qrencode.h)
AC_CHECK_LIB(qrencode,QRcode_encodeString,
	[have_qrencode=yes QRENCODE_LIB="-lqrencode"],
 	[AC_MSG_ERROR([*** qrencode is not found.])], [-lpng12])
AC_SUBST(have_qrencode)
AC_SUBST(QRENCODE_LIB)

AC_ARG_WITH(patchdir,
	    [  --with-patchdir=DIR      patch libraries in DIR [PREFIX]],
            [patchdir=$withval],
            [patchdir='${prefix}'])

AC_ARG_WITH(patchlibdir,
	    [  --with-patchlibdir=DIR   patch cobol libraries in DIR [PREFIX/lib]],
            [patchlibdir=$withval],
            [patchlibdir='${prefix}/lib'])

AC_SUBST(patchdir)dnl
AC_SUBST(patchlibdir)dnl

AC_ARG_WITH(sitedir,
	    [  --with-sitedir=DIR      site libraries in DIR [PREFIX]],
            [sitedir=$withval],
            [sitedir='${prefix}'])

AC_ARG_WITH(sitesrcdir,
	    [  --with-sitesrcdir=DIR   site src libraries in DIR [PREFIX/site-src]],
            [sitesrcdir=$withval],
            [sitesrcdir='${prefix}/site-src'])

AC_ARG_WITH(sitelibdir,
	    [  --with-sitelibdir=DIR   site cobol libraries in DIR [PREFIX/lib]],
            [sitelibdir=$withval],
            [sitelibdir='${prefix}/lib'])

AC_SUBST(sitedir)dnl
AC_SUBST(sitesrcdir)dnl
AC_SUBST(sitelibdir)dnl

AC_MSG_CHECKING(OpenCOBOL compiler)
AC_ARG_WITH(open-cobol-prefix,
             [  --with-open-cobol-prefix=PFX   prefix where open-cobol is installed (optional)], 
  open_cobol_prefix="$withval", open_cobol_prefix="")

AC_ARG_WITH(open-cobol-exec-prefix,
             [  --with-open-cobol-exec-prefix=PFX Exec prefix where open-cobol is installed (optional)], 
  open_cobol_exec_prefix="$withval", open_cobol_exec_prefix="")

  if test x$open_cobol_exec_prefix != x ; then
    if test x${COBC+set} != xset; then
      COBC=$open_cobol_exec_prefix/bin/cobc08
      COB_CONFIG=$open_cobol_exec_prefix/bin/cob-config08
    fi
  fi
  if test x$open_cobol_prefix != x ; then
    if test x${COBC+set} != xset; then
      COBC=$open_cobol_prefix/bin/cobc08
      COB_CONFIG=$open_cobol_prefix/bin/cob-config08
    fi
  fi
  AC_PATH_PROG(COBC, cobc, no)
  AC_PATH_PROG(COB_CONFIG, cob-config, no)

  if test "$COBC" = "no" ; then
    no_cobc=yes
  else
    if test -x $COBC ; then
      no_cobc=""
    else
      no_cobc=yes
    fi
  fi
  if test "x$no_cobc" = x ; then
      AC_MSG_RESULT(yes)
      cobc_major_version=`$COB_CONFIG --version | \
	sed -n 's/\([[0-9]]*\)\.\([[0-9]]*\).*/\1/p'`
      cobc_minor_version=`$COB_CONFIG --version | \
	sed -n 's/\([[0-9]]*\)\.\([[0-9]]*\).*/\2/p'`
      if test "x${cobc_major_version}""${cobc_minor_version}" = x08; then
	COBOLFLAGS=" -m -dynamic -F "
	EXEC_COBOLFLAGS="-dynamic -F "
      elif test "x${cobc_major_version}" = x0  && \
        (expr "${cobc_minor_version}" \< "20") > /dev/null ; then
	  COBOLFLAGS="-m -dynamic -fixed "
  	  EXEC_COBOLFLAGS="-main -dynamic -fixed " 
      else
	  COBOLFLAGS="-m -dynamic -fixed -fimplicit-init -std=cobol85 -Wall "
  	  EXEC_COBOLFLAGS="-x -dynamic -fixed -std=cobol85 -Wall "
      fi	
  else
      AC_MSG_RESULT(no)
      AC_MSG_ERROR(OpenCOBOL compiler not found.)
  fi

AC_SUBST(COBC)
AC_SUBST(COBOLFLAGS)
AC_SUBST(EXEC_COBOLFLAGS)

AC_MSG_CHECKING(MONTSUQI(panda))
AC_ARG_WITH(panda-dir,
             [  --with-panda-dir=[=DIR]  where panda is installed (optional)], 
  panda_dir="$withval", panda_dir="")

if test x$panda_dir != x; then
  dir=$panda_dir
else
  dir="/usr/local"
fi

for d in $dir /usr /usr/local/panda /usr/lib/panda /usr/local
do
  if test -f $d/sbin/dbstub; then
    dbstub_command=$d/sbin/dbstub
    copygen_command=$d/bin/copygen
    fdw_command=$d/bin/fdw
    dbsync_command=$d/bin/dbsync
    break
  fi
done

if test x$dbstub_command != x; then
  AC_MSG_RESULT(yes)
  DBSTUB=$dbstub_command
  COPYGEN=$copygen_command
  FDW=$fdw_command
  DBSYNC=$dbsync_command
else
  AC_MSG_RESULT(no)
  AC_MSG_ERROR(MONTSUQI(panda) not found.)
fi

AC_SUBST(DBSTUB)
AC_SUBST(COPYGEN)
AC_SUBST(FDW)
AC_SUBST(DBSYNC)
dnl Checks for libraries.

dnl Checks for header files.
AC_HEADER_STDC

dnl Checks for typedefs, structures, and compiler characteristics.

dnl Checks for library functions.


AC_CONFIG_FILES([
cobol/Makefile
cobol/Makefile.global
cobol/cutils/Makefile
cobol/common/ORCSCOMMON.CBL
cobol/copy/Makefile
bin/Makefile
lib/Makefile
lddef/Makefile
record/Makefile
screen/Makefile
form/Makefile
scripts/Makefile
data/Makefile
doc/Makefile
etc/Makefile
init/Makefile
tools/Makefile
Makefile
Makefile.directories
etc/jma-receipt.env
])
AC_OUTPUT
