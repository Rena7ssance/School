#include "libc.h"

void notFound(char* cmd) {
  puts(cmd);
  puts(": command not found\n");
}

int main(int argc, char** argv) {
    char *sep = "";

    int n = 0;
    int j = 1;
    char* arg = "";

    for(int i = 1; i < argc; i++) {
      if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == 'n') {
        n = 1;
        j++;
      }
      if(argv[i] && argv[i][0] == '|') {
        if(argv[i+1]) {
          arg = argv[i+1];
        }
        if(arg[0] && arg[1] && arg[0] == 'l' && arg[1] == 's') {
          char *a = '\0';
          long id = fork();
          if(id == 0) {
            long rc = execv("ls",&a);
            exit(rc);
          } else {
            join(id);
          }
          return 1;
        }
        if(arg[0] && arg[1] && arg[2] && arg[3] && arg[0] == 'e' && arg[1] == 'c' && arg[2] == 'h' && arg[3] == 'o') {
          int count = 0;
          while(argv[i+2+count]) {
            count++;
          }
          char** arguments = malloc(4*(count+2));
          arguments[0] = "echo";
          for(int j = 0; j < count; j++) {
            arguments[j+1] = argv[i+2+j];
          }
          arguments[count+1] = '\0';
          long id = fork();
          if(id == 0) {
            long rc = execv("echo",arguments);
            exit(rc);
          } else {
            join(id);
          }
          return 1;
        }
        if(arg[0] && arg[1] && arg[2] && arg[0] == 'c' && arg[1] == 'a' && arg[2] == 't') {
          if(argv[i+2]) {
            long fd = open(argv[i+2]);
            if(fd < 0) {
              notFound(argv[i+2]);
              return 0;
            }
            char** arguments = malloc(12);
            arguments[0] = "cat";
            arguments[1] = argv[i+2];
            arguments[2] = '\0';
            long id = fork();
            if(id == 0) {
              long rc = execv("cat",arguments);
              exit(rc);
            } else {
              join(id);
            }
          }
          else {
            char* tee = malloc(3);
            tee[0] = 'l';
            tee[1] = 's';
            tee[2] = '\0';
            long id = fork();
            if(id == 0) {
              long rc = execv("sort",&tee);
              exit(rc);
            } else {
              join(id);
            }
          }
          return 1;
        }
      }
    }

    while(j < argc) {
        puts(sep);
        sep = " ";
        puts(argv[j]);
        j++;
    }
    if(!n) {
      puts("\n");
    }
    return 0;
}
