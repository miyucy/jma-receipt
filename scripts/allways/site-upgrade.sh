#!/bin/sh

prefix=/usr/local/orca
srcdir=${prefix}/site-src

# compile COBOL programs
for f in `ls ${srcdir}/cobol`; do
  if test "x`echo -n $f | grep 'CBL$'`" != "x"; then
    m=`echo $f | sed 's/CBL$/so/'`
    echo -n "Building ${m}..."
    cobc -m -o ${prefix}/lib/${m} -I ${prefix}/cobol/copy -I ${srcdir}/cobol/copy \
      ${srcdir}/cobol/${f}
    echo "done"
  fi
done

# copy data files
echo -n "Copying data files..."
for d in data doc etc form init lddef record screen scripts/allways \
         scripts/daily scripts/kaisei scripts/monthly scripts/kentan; do
  if test -d "${srcdir}/${d}"; then
    mkdir -p "${prefix}/${d}"
    chown orca.orca "${prefix}/${d}"
    for f in `ls ${srcdir}/${d}`; do 
      cp "${srcdir}/${d}/${f}" "${prefix}/${d}"
    done
  fi
done
echo "done"
