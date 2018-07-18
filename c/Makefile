PROG=	smoke
SRCS=	smoke.c server.c client.c sio.c blowfish.c
NOMAN=
CFLAGS+=
COPTS+=	-Wall -Wstrict-prototypes -Wmissing-prototypes -Wpointer-arith -Wundef
LDADD+=	-lsndio -lpthread -ltls
.include <bsd.prog.mk>
