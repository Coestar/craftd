#!/bin/sh

CRAFTDDIR=$(pwd)/craftd
SRCDIR=$CRAFTDDIR/src
LIBDIR=$CRAFTDDIR/lib
DATADIR=$CRAFTDDIR/data
EXAMPLESDIR=$CRAFTDDIR/examples
LIBEVENT2VER=libevent-2.0.10-stable
LIBEVENT2DIR=$SRCDIR/$LIBEVENT2VER


echo "Creating directories..."
mkdir -p $SRCDIR $LIBDIR $DATADIR $EXAMPLESDIR|| exit 1

echo "Downloading libevent2..."
cd $SRCDIR
wget http://monkey.org/~provos/$LIBEVENT2VER.tar.gz || exit 1
tar xvzf $LIBEVENT2VER.tar.gz || exit 1

echo "Building libevent2..."
cd $LIBEVENT2DIR
./configure || exit 1
make || exit 1
cp .libs/*.so* $LIBDIR/ || exit 1

echo "Cloning craftd Git repository..."
cd $SRCDIR 
git clone git://github.com/kev009/craftd.git || exit 1

echo "Building craftd..."
cd craftd
autoreconf -i || exit 1
export libevent2_pthreads_LIBS="-levent -levent_pthreads -L$LIBDIR" 
export libevent2_pthreads_CFLAGS="-I$LIBEVENT2DIR/include" 
./configure --prefix=$CRAFTDDIR --bindir=$CRAFTDDIR --sysconfdir=$EXAMPLESDIR --datarootdir=$DATADIR || exit 1
make || exit 1
make install || exit 1

echo "Creating config..."
cp $EXAMPLESDIR/craftd/craftd.conf.dist $CRAFTDDIR/craftd.conf

echo "Done"
echo
echo "--------------------------------------------------"
echo "Start craftd with: LD_LIBRARY_PATH=lib ./craftd"
echo "--------------------------------------------------"
