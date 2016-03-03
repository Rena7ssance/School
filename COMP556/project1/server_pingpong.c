#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>

struct node {
  int socket;
  struct sockaddr_in client_addr;
  int pending_data; /* flag to indicate whether there is more data to send */
  struct node *next;
};

void dump(struct node *head, int socket){
  struct node *current, *temp;

  current = head;

  while(current->next) {
    if(current->next->socket == socket) {
      /* remove */
      temp = current->next;
      current->next = temp->next;
      free(temp);
      return;
    }
    else {
      current = current->next;
    }
  }
}

void add(struct node *head, int socket, struct sockaddr_in addr) {
  struct node *new_node;

  new_node = (struct node*)malloc(sizeof(struct node));
  new_node->socket = socket;
  new_node->client_addr = addr;
  new_node->pending_data = 0;
  new_node->next = head->next;
  head->next = new_node;
}

int main(int argc, char** argv) {

  /* socket and option variables */
  int sock, new_sock, max;
  int optval = 1;
  int mode;
  char* root;

  if((argv[2]) && (argc == 4) && (strncmp(argv[2], "www", 3) == 0)) {
    mode = 2;
    root = argv[3];
  }
  else {
    mode = 1;
  }

  /* server socket address variables */
  struct sockaddr_in sin, addr;
  unsigned short server_port = atoi(argv[1]);

  /* socket address variables for a connected client */
  socklen_t addr_len = sizeof(struct sockaddr_in);

  /* maximum number of pending connection requests */
  int BACKLOG = 5;

  /* variables for select */
  fd_set read_set, write_set;
  struct timeval time_out;
  int select_retval;
  int total_sent = 0;

  /* message for client */
  //char *message = "Welcome!\n";

  /* Number of bytes received */
  int count;

  /* Number of bytes received total */
  int total_count = 0;

  /* linked list for keeping track of connected sockets */
  struct node head;
  struct node *current, *next;

  /* Size variable for the message header */
  unsigned short size;
  int size_found = 0;
  int else_found = 0;

  /* Test to make sure everything is working */
  int test = 1;

  /* timestamp variables */
  unsigned int sec;
  unsigned int usec;

  /* a buffer to read data */
  char *buf;
  int BUF_LEN = 1000;

  char* send_buffer;

  buf = (char*)malloc(BUF_LEN);

  /* initialize dummy head node of linked list */
  head.socket = -1;
  head.next = 0;

  /* create a server socket to listen for TCP connection requests */
  if((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
    perror("opening TCP socket");
    abort();
  }

  /* set option so we can reuse the port number quickly after restart */
  if(setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval)) < 0) {
    perror("setting TCP socket option");
    abort();
  }

  /* fill in the address of the server socket */
  memset(&sin, 0, sizeof(sin));
  sin.sin_family = AF_INET;
  sin.sin_addr.s_addr = INADDR_ANY;
  sin.sin_port = htons(server_port);

  /* bind server socket to the address */
  if(bind(sock, (struct sockaddr*)&sin, sizeof(sin)) < 0) {
    perror("binding socket to address");
    abort();
  }

  /* put the server socket in listen mode */
  if(listen(sock, BACKLOG) < 0) {
    perror("listen on socket failed");
    abort();
  }

  while(1) {
    /* set up the file descriptor bit map that select should be watching */
    FD_ZERO(&read_set);
    FD_ZERO(&write_set);

    FD_SET(sock, &read_set);
    max = sock;

    /* put connected sockets into the read and write sets to monitor them */
    for(current = head.next; current; current = current->next) {
      FD_SET(current->socket, &read_set);

      if(current->pending_data) {
        FD_SET(current->socket, &write_set);
      }

      if(current->socket > max) {
        max = current->socket;
      }
    }

    time_out.tv_usec = 100000;
    time_out.tv_sec = 0;

    /* invoke select */
    select_retval = select(max+1, &read_set, &write_set, NULL, &time_out);
    if(select_retval < 0) {
      perror("select failed");
      abort();
    }

    if(select_retval == 0) {
      /*no descriptor ready */
      continue;
    }

    if(select_retval > 0) { /* at least onefile descriptor is ready */
      if(FD_ISSET(sock, &read_set)) {
        /* there is an incoming connection, try to accept it */
        new_sock = accept(sock, (struct sockaddr*)&addr, &addr_len);

        if(new_sock < 0) {
          perror("error accepting connection");
          abort();
        }

        /* make the socket non-blocking */
        if(fcntl(new_sock, F_SETFL, O_NONBLOCK) < 0) {
          perror("making socket non-blocking");
          abort();
        }

        /* connection is established */
        printf("Accepted connection. Client IP address is: %s\n", inet_ntoa(addr.sin_addr));

        /* remember this client connection in the linked list */
        add(&head, new_sock, addr);
      }

      /* check other connected sockets */
      for(current = head.next; current; current = next) {
        next = current->next;

        if(FD_ISSET(current->socket, &write_set)) {
          /* socket is now ready to take more data */
          count = send(current->socket, buf, BUF_LEN, MSG_DONTWAIT);
          if(count < 0) {
            if(errno == EAGAIN) {
              /* trying to dump too much data down the socket */
            }
            else {
              /* something else is wrong */
            }
          }
        /* import to check count for exactly how many bytes were actually sent */
        }

        if(FD_ISSET(current->socket, &read_set)) {
          /* we have data from the client */
          count  = recv(current->socket, buf, BUF_LEN, 0);
          if(count <= 0) {
            /* something is wrong */
            if(count == 0) {
              printf("Client closed connection. Client IP address is: %s\n", inet_ntoa(current->client_addr.sin_addr));
              size_found = 0;
              else_found = 0;
              total_count = 0;
              total_sent = 0;
            }
            else {
              perror("error receiving from a client");
            }

            /* connection is closed */
            close(current->socket);
            dump(&head, current->socket);
          }
          else {
            /* we got count bytes of data from the client */
            if(buf[count - 1] != 0) {
              printf("Message incomplete, something is still being transmitted\n");
              return 0;
            }
            else {

              if(size_found == 0) {
                /* found size for the first time */
                size = (buf[1] << 8) | (buf[0] & 0x000000ff);
                size_found = 1;
                send_buffer = (char*)malloc(size);
              }
              if(else_found == 0) {
                /* set up response header for the first time */
                sec = (((buf[5] << 24) & 0xff000000) | ((buf[4] << 16) & 0x00ff0000) | ((buf[3] << 8) & 0x0000ff00) | (buf[2] & 0x000000ff));
                usec = (((buf[9] << 24) & 0xff000000) | ((buf[8] << 16) & 0x00ff0000) | ((buf[7] << 8) & 0x0000ff00) | (buf[6] & 0x000000ff));
                else_found = 1;
              }

              total_count += count;

              if(mode == 1) {
                /* ping-pong mode */

                if(total_count >= size) {

                  total_count = 0;
                  memcpy(send_buffer,&size,2);
                  memcpy(send_buffer+2,&sec,4);
                  memcpy(send_buffer+6,&usec,4);

                  int need = size;
                  int y = 0;
                  /* send if there is more data to send */
                  while(total_sent < size) {
                    y = send(current->socket, (void*)((char*)send_buffer + total_sent), need, 0);
                    if(y > 0) {
                      total_sent += y;
                      need = need - y;
                    }
                  }
                  /* re-set */
                  if(total_sent >= size) {
                    else_found = 0;
                    total_sent = 0;
                    total_count = 0;
                  }
                }
              }

              if(mode == 2) {
                /* web server mode */
                char* message = (char*)malloc(size-10);
                struct timeval tv;

                /* isolate the request message */
                int i = 0;
                while(buf[i+10]) {
                  message[i] = buf[i+10];
                  i++;
                }
                message[i] = '\0';

                /* pre-constructed responses */
                char* message200 = "HTTP/1.1 200 OK\r\n";
                char* message400 = "HTTP/1.1 400 Bad Request\r\n";
                char* message404 = "HTTP/1.1 404 Not Found\r\n";
                char* message500 = "HTTP/1.1 500 Internal Server Error\r\n";
                char* contentMessage = "Content-Type: text/html\r\n";

                /* if proper GET message */
                if(message[0] == 'G' && message[1] == 'E' && message[2] == 'T') {
                  /* checks proper request syntax */
                  if(message[4] == '/') {
                    FILE *fp;

                    /* finds length of page */
                    int pageIndex = 0;
                    int httpIndex = 0;
                    while(message[pageIndex+5] && message[pageIndex+5] != ' ') {
                      pageIndex++;
                    }

                    /* finds index of the end of the http */
                    while(message[httpIndex+pageIndex+6] && message[httpIndex+pageIndex+6] != ' ') {
                      httpIndex++;
                    }

                    char* page = (char*)malloc(pageIndex+1+strlen(root));
                    char* http = (char*)malloc(9);

                    int messageIndex = 0;
                    int httpPlacement = 0;
                    int rootIndex = 0;

                    /* adds root directory to file path */
                    while(rootIndex < strlen(root)) {
                      page[rootIndex] = root[rootIndex];
                      rootIndex++;
                    }

                    /* appends file name to end of the path */
                    for(messageIndex = 0; messageIndex < pageIndex; messageIndex++) {
                      page[messageIndex+rootIndex] = message[messageIndex+5];
                    }
                    page[messageIndex+rootIndex] = '\0';

                    /* check to prevent /../ in page path */
                    int pageSearch;
                    for(pageSearch = rootIndex; pageSearch < (messageIndex+rootIndex);pageSearch++) {
                      if((page[pageSearch] == '.') && (page[pageSearch+1]) && (page[pageSearch+1] == '.')) {
                        test = 0;
                        send(current->socket,message400,strlen(message400)+1,0);
                      }
                    }

                    /* adds http encoding */
                    for(httpPlacement = 0; httpPlacement < httpIndex; httpPlacement++) {
                      http[httpPlacement] = message[messageIndex+httpPlacement+6];
                    }
                    http[httpPlacement] = '\0';

                    /* opens page */
                    fp = fopen(page, "r");
                    if(fp == NULL) {
                      /* page not found */
                      send(current->socket,message404,strlen(message404)+1,0);
                    }
                    else {
                      /* page found */
                      if(http[0] != 'H' || http[1] != 'T' || http[2] != 'T' || http[3] != 'P' || strlen(http) != 8) {
                        send(current->socket,message400,strlen(message400)+1,0);
                      }
                      else {
                        /* page found and good http request */
                        long bufsize;
                        char* source = NULL;
                        send(current->socket,message200,strlen(message200)+1,0);
                        /* found end of the file */
                        if(fseek(fp, 0L, SEEK_END) == 0) {
                          /* found file size */
                          bufsize = ftell(fp);
                          if(bufsize == -1) {
                            /* Error Occurred */
                            send(current->socket,message500,strlen(message500)+1,0);
                            test = 0;
                          }

                          /* file sized buffer */
                          source = malloc(sizeof(char) * (bufsize + 1));

                          if(fseek(fp, 0L, SEEK_SET) != 0) {
                            /* Error Occurred */
                            send(current->socket,message500,strlen(message500)+1,0);
                            test = 0;
                          }

                          size_t newLen = fread(source, sizeof(char), bufsize, fp);
                          if(newLen == 0) {

                          }
                          else {
                            source[++newLen] = '\0';
                          }
                        }

                        /* buffer for the response, including content type */
                        char* sendBuf = (char*)malloc(bufsize+38);
                        int contentIndex = 0;
                        int sourceIndex = 0;

                        /* copy content message and file contents to send buffer */
                        while(contentMessage[contentIndex]) {
                          sendBuf[contentIndex+10] = contentMessage[contentIndex];
                          contentIndex++;
                        }
                        sendBuf[10+contentIndex++] = '\r';
                        sendBuf[10+contentIndex++] = '\n';
                        while(source[sourceIndex]) {
                          sendBuf[10+contentIndex++] = source[sourceIndex++];
                        }
                        sendBuf[10+contentIndex] = '\0';

                        size = contentIndex+11;

                        /* size and timestamp */
                        memcpy(sendBuf,&size,2);
                        memcpy(sendBuf+2,&tv.tv_sec,4);
                        memcpy(sendBuf+6,&tv.tv_usec,4);

                        if(test == 1) {
                          /* send only if no internal error, to prevent deadlocking */
                          send(current->socket,sendBuf,size,0);
                        }
                        fclose(fp);
                        free(source);
                        free(sendBuf);
                      }
                    }
                  }
                  else {
                    send(current->socket,message400,strlen(message400)+1,0);
                  }
                }
                else {
                  send(current->socket,message400,strlen(message400)+1,0);
                }
              }

            }
          }
        }
      }
    }
  }
}
