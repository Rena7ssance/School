#include "libc.h"

int main() {
    puts("INSIDE LS\n");
    long fd = open(".");
    long len = getlen(fd);
    char* buff = malloc(len);
    read(fd,buff,len);

    int i = 0;
    while(i < len){
      puts(buff+i);
      puts("\n");
      i += 16;
    }

    free(buff);

    return 0;
}
