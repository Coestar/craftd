AM_CPPFLAGS = $(libevent2_pthreads_CFLAGS) $(PTHREAD_CFLAGS)

bin_PROGRAMS = craftd
craftd_SOURCES = craftd.c craftd.h
craftd_SOURCES += craftd-config.c craftd-config.h
craftd_SOURCES += packets.h version.c
craftd_SOURCES += util.c util.h
craftd_SOURCES += javaendian.c javaendian.h
craftd_SOURCES += mapchunk.c mapchunk.h
craftd_SOURCES += httpd.c httpd.h
craftd_LDADD = $(libevent2_pthreads_LIBS) $(PTHREAD_LIBS)