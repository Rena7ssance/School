#include "libc.h"

void notFound(char* cmd) {
  puts(cmd);
  puts(": command not found\n");
}

int length(char* string) {
  int len = 0;
  while(string[len]) {
    len++;
  }
  return len;
}

int isLarger(char* string1, char* string2) {
  //if string1 is larger than string2
  if(length(string1) > length(string2)) {
    for(int i = 0; i < length(string2); i++) {
      if(string1[i] > string2[i]) {
        return 1;
      }
      if(string1[i] < string2[i]) {
        return 0;
      }
    }
    return 1;
  }
  else if(length(string1) < length(string2)) {
    for(int i = 0; i < length(string1); i++) {
      if(string1[i] > string2[i]) {
        return 1;
      }
      if(string1[i] < string2[i]) {
        return 0;
      }
    }
    return 0;
  }
  else {
    for(int i = 0; i < length(string1); i++) {
      if(string1[i] > string2[i]) {
        return 1;
      }
      if(string1[i] < string2[i]) {
        return 0;
      }
    }
  }
  return 0;
}

int main(int argc, char** argv) {

      int a = 0;
      int l = 0;
      int r = 0;
      int p = 0;
      char* arg = "";

      for(int i = 1; i < argc; i++) {
        if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == 'a') {
          a = 1;
        }
        if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == '1') {
          l = 1;
        }
        if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == 'r') {
          r = 1;
        }
        if(argv[i] && argv[i][0] == '|') {
          p = 1;
          if(argv[i+1]) {
            arg = argv[i+1];
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
        }
      }

      if(a && !r && !p) {
        puts(".");
        if(l) {
          puts("\n");
        } else {
          puts("\t");
        }
        puts("..");
        if(l) {
          puts("\n");
        } else {
          puts("\t");
        }
      }

      long fd = open(".");
      if (fd < 0) {
          exit(fd);
      }
      int q = 0;
      long n = getlen(fd) / 16;
      char args[n][13];

      for (long i = 0; i<n; i++) {
          char buf[13];
          seek(fd,i*16);
          readFully(fd,buf,12);
          buf[12] = 0;
          if(r) {
            for(int j = 0; j < 13; j++) {
              args[q][j] = buf[j];
            }
            args[q][13] = 0;
            q++;
          } else {
            if(!p) {
              puts(buf);
              if(l) {
                puts("\n");
              }
              else {
                puts("\t");
              }
            }
          }
      }

      if(r && !p) {
        int done[n];
        for(int i = 0; i < n; i++) {
          done[i] = 0;
        }
        int count = 0;
        int place;
        while(count < n) {
          place = 0;
          char* largest = "";
          for(int i = 0; i < n; i++) {
            if((isLarger(args[i],largest)) && (!done[i])) {
              largest = args[i];
              place = i;
            }
          }

          puts(largest);
          done[place] = 1;
          if(l) {
            puts("\n");
          }
          else {
            puts("\t");
          }
          count++;
        }
      }
      if(p) {
        int fd = open(arg);
        if (fd < 0) {
          notFound(arg);
          goto done;
        }
        long id = fork();
        if(id == 0) {
          char* passArgs;
          if(a && r && l) {
            puts("all flags\n");
            passArgs = malloc(9);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'a';
            passArgs[4] = '-';
            passArgs[5] = 'r';
            passArgs[6] = '-';
            passArgs[7] = 'l';
            passArgs[8] = '\0';
          }
          else if(a && r && !l) {
            passArgs = malloc(7);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'a';
            passArgs[4] = '-';
            passArgs[5] = 'r';
            passArgs[6] = '\0';
          }
          else if(a && !r && l) {
            passArgs = malloc(7);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'a';
            passArgs[4] = '-';
            passArgs[5] = 'l';
            passArgs[6] = '\0';
          }
          else if(!a && r && l) {
            passArgs = malloc(7);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'r';
            passArgs[4] = '-';
            passArgs[5] = 'l';
            passArgs[6] = '\0';
          }
          else if(a && !r && !l) {
            passArgs = malloc(5);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'a';
            passArgs[4] = '\0';
          }
          else if(!a && r && !l) {
            passArgs = malloc(5);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'r';
            passArgs[4] = '\0';
          }
          else if(!a && !r && l) {
            passArgs = malloc(5);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '-';
            passArgs[3] = 'l';
            passArgs[4] = '\0';
          }
          else {
            passArgs = malloc(3);
            passArgs[0] = 'l';
            passArgs[1] = 's';
            passArgs[2] = '\0';
          }
          long rc = execv(arg,&passArgs);
          notFound(arg);
          exit(rc);
        } else {
          join(id);
        }
      }

      if(a && r && !p) {
        puts("..");
        if(l) {
          puts("\n");
        } else {
          puts("\t");
        }
        puts(".");
        if(l) {
          puts("\n");
        } else {
          puts("\t");
        }
      }

      if(!l && !p) {
        puts("\n");
      }
done:
    return 0;
}
