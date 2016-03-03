# Makefile

OBJS			= bison.o lex.o main.o

CC 				= gcc
CFLAGS		= -g -Wall -ansi -pedantic

rundemo:			$(OBJS)
							$(CC) $(CFLAGS)	$(OBJS) -o demo -lfl

lex.o:				lex.c
							$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c:				demo.lex
							flex demo.lex
							cp lex.yy.c lex.c

bison.o:			bison.c
							$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c:			demo.y
							bison -d -v demo.y
							cp demo.tab.c bison.c

main.o:				main.c
							$(CC) $(CFLAGS) -c main.c -o main.o

clean:
				rm -f *.o *~ lex.c lex.yy.c bison.c tok.h demo.tab.c demo.tab.h demo.output demo
