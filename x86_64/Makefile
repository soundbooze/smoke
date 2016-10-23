PROG=smoke
SRCS=smoke.s server.s client.s blowfish.s sio.s 
NOMAN=
CFLAGS+=
COPTS+=	-Wall -Wstrict-prototypes -Wmissing-prototypes -Wpointer-arith -Wundef
LDADD+=	-lsndio -lpthread -ltls
.include <bsd.prog.mk>
