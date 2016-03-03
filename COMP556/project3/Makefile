
CC = g++
CFLAGS = -Wall -c -g
LFLAGS =
Libs = -lz

RECV = recvfile
SEND = sendfile
RECV_SRC = recvfile.cpp sockwall.cpp sockwindow.cpp
SEND_SRC = sendfile.cpp sockwall.cpp sockwindow.cpp
RECV_OBJ = recvfile.o sockwall.o sockwindow.o
SEND_OBJ = sendfile.o sockwall.o sockwindow.o

%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

all :  $(RECV) $(SEND)

$(RECV) : $(RECV_OBJ)
	$(CC) $(LFLAGS) $(Libs) -o $(RECV) $(RECV_OBJ)

$(SEND) : $(SEND_OBJ)
	$(CC) $(LFLAGS) $(Libs) -o $(SEND) $(SEND_OBJ)

$(SEND_OBJS): global.h

$(RECV_OBJS): global.h

recvfile.o :  sockwindow.h sockwall.h
sendfile.o :  sockwindow.h sockwall.h
sockwall.o : sockwindow.h sockwall.h
sockwindow.o : sockwindow.h

clean:
	rm -f *.o recvfile sendfile
