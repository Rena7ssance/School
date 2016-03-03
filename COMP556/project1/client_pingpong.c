#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

int main(int argc, char** argv) {

  /* Sanity Check */
  if(argc != 5) {
    printf("Client must provide five arguments.\n");
    return 0;
  }

  /* our client socket */
  int sock;

  /* address structure for identifying the server */
  struct sockaddr_in sin;

  /* convert server domain name to IP address */
  struct hostent *host = gethostbyname(argv[1]);
  unsigned int server_addr = *(unsigned int*)host->h_addr_list[0];

  /* server port number */
  unsigned short server_port = atoi(argv[2]);

  /* Set up parameters from command line */
  char* buffer;
  unsigned short size = atoi(argv[3]);
  int rep_count = atoi(argv[4]);

  /* Set up variables for network send/receive */
  int BUF_LEN = 65000;
  int count = 0;
  int total_rec = 0;

  /* allocate memory buffer */
  buffer = (char*)malloc(BUF_LEN);
  if(!buffer) {
    perror("Failed to allocate buffer");
    abort();
  }

  /* create socket */
  if((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
    perror("opening TCP socket");
    abort();
  }

  /* fill in the server's address */
  memset(&sin, 0, sizeof(sin));
  sin.sin_family = AF_INET;
  sin.sin_addr.s_addr = server_addr;
  sin.sin_port = htons(server_port);

  /* connect to the server */
  if(connect(sock, (struct sockaddr*)&sin, sizeof(sin)) < 0) {
    perror("connect to server failed");
    abort();
  }

  while(1) {
      struct timeval tv;
      struct timeval tv_rec;
      char* send_buffer = (char*)malloc(size);
      char* r_buffer = (char*)malloc(size);

        /* Minimum message size is ten */
        if(size < 10) {
          size = 10;
        }

        /* Set up total and initiate number of reps */
        unsigned int total = 0;
        int j = 0;
        while(j < rep_count) {
          //char* r_buffer = (char*)malloc(size);

          /* Size of message */
          memcpy(send_buffer,&size,2);

          /* Set up timestamp */
          gettimeofday(&tv, NULL);
          memcpy(send_buffer+2,&tv.tv_sec,4);
          memcpy(send_buffer+6,&tv.tv_usec,4);

          /* Null terminate the timestamp */
          /* No message in ping-pong mode, but we could add it here */
          send_buffer[size - 1] = '\0';

          /* ping-pong! */
          send(sock, send_buffer, size, 0);
          total_rec = 0;
          int need = size;
          while(total_rec < size) {
            count = recv(sock, (void*)((char*)r_buffer + count), need, 0);
            need = need - count;
            total_rec += count;
          }

          gettimeofday(&tv_rec, NULL);

          int diff;
          diff = tv_rec.tv_usec - tv.tv_usec;

          if(diff > 0) {
            total += diff;
            j++;
          }

        }

        printf("Average latency: %.3lf milliseconds\n", total / (1000.0 * rep_count));

        close(sock);

        break;
  }

  return 0;
}
