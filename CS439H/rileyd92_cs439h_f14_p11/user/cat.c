#include "libc.h"

int main(int argc, char** argv) {
    for(int i = 1; i < argc; i++) {
      long id = open(argv[i]);
      if(id < 0) {
        puts("cat: ");
        puts(argv[i]);
        puts(": ");
        puts("No such file or directory");
        puts("\n");
        break;
      }

      long len = getlen(id);
      char* buff = malloc(513);
        long i = 0;
        while(i < len) {
          long rd = read(id,buff,len-i);
          if(rd > 0) {
            buff[rd] = '\0';
            i += rd;
            puts(buff);
          }
        }

      free(buff);
    }
    //puts("\n");
    return 0;
}
