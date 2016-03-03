CC							= gcc
LD							= gcc
CFLAGS					= -Wall -g

LDFLAGS					=
DEFS						=

all : client_pingpong server_pingpong

client_pingpong: client_pingpong.c
	$(CC) $(DEFS) $(CFLAGS) $(LIB) -o client_pingpong client_pingpong.c

server_pingpong: server_pingpong.c
	$(CC) $(DEFS) $(CFLAGS) $(LIB) -o server_pingpong server_pingpong.c

clean:
				rm -f *.o
				rm -f *~
				rm -f core.*.*
				rm -f client_pingpong
				rm -f server_pingpong
				rm -f -r client_pingpong.dSYM
				rm -f -r server_pingpong.dSYM
