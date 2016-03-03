#include "libc.h"

int length(char* string) {
  int len = 0;
  while(string[len]) {
    len++;
  }
  return len;
}

int isEqual(char* string1, char* string2) {
  if(length(string1) != length(string2)) {
    return 0;
  }

  for(int i = 0; i < length(string1); i++) {
    if(string1[i] != string2[i]) {
      return 0;
    }
  }
  return 1;
}

void notFound(char* cmd) {
  puts(cmd);
  puts(": command not found\n");
}

int main(int argc, char** argv) {
    int n = 0;
    int e = 0;
    int b = 0;
    int j = 1;
    int t = 1;
    int num = 0;
    //char* arg =  "";

    for(int i = 1; i < argc; i++) {
      if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == 'n') {
        n = 1;
        j++;
      }
      if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == 'b') {
        b = 1;
        j++;
      }
      if(argv[i] && argv[i][0] == '-' && argv[i][1] && argv[i][1] == 'e') {
        e = 1;
        j++;
      }
      if(argv[i] && argv[i][0] == '|') {
        if(argv[i+1][0] && argv[i+1][1] && argv[i+1][0] == 'l' && argv[i+1][1] == 's') {
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
        if(argv[i+1][0] && argv[i+1][1] && argv[i+1][2] && argv[i+1][0] == 'c' && argv[i+1][1] == 'a' && argv[i+1][2] == 't') {
          long test = open(argv[i-1]);
          if(test >= 0 && !isEqual(argv[i-1],"cat")) {
            goto process;
          }
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
        if(argv[i+1][0] && argv[i+1][1] && argv[i+1][2] && argv[i+1][3] && argv[i+1][0] == 'e' && argv[i+1][1] == 'c' && argv[i+1][2] == 'h' && argv[i+1][3] == 'o') {
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
        } /*
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
      */}
    }

process:
    while(j < argc) {
        if(argv[j][0] == '|') {
          return 0;
        }
        int fd = open(argv[j]);
        if (fd < 0) {
            puts(argv[0]); puts(": ");
            puts(argv[j]); puts(": No such file or directory\n");
        } else {
            char buf[100];
            while(1) {
                long rd = read(fd,buf,100);
                if (rd == 0) break;
                if (rd < 0) {
                    puts("error reading : "); puts(argv[j]); puts("\n");
                    break;
                }
                if(n && t) {
                  puts("    ");
                  if(num > 9) {
                    putdec(num);
                  }
                  else {
                    puts(" ");
                    putdec(num);
                  }
                  puts("  ");
                  num++;
                  t = 0;
                }
                if(b && t) {
                  puts("    ");
                  if(num > 9) {
                    putdec(num);
                  }
                  else {
                    puts(" ");
                    putdec(num);
                  }
                  puts("  ");
                  num++;
                  t = 0;
                }
                for (int k = 0; k < rd; k++) {
                    if(e && buf[k] && buf[k]=='\n') {
                      putchar('$');
                    }
                    putchar(buf[k]);
                    if(b && buf[k] == '\n' && (k+1)<rd) {
                      int e = k+1;
                      int test = 0;
                      while(buf[e] && buf[e] != '\n') {
                        if(buf[e] && buf[e] != '\t' && buf[e] != ' ') {
                          test = 1;
                          break;
                        }
                        e++;
                      }
                      if(test) {
                        puts("    ");
                        if(num > 9) {
                          putdec(num);
                        }
                        else {
                          puts(" ");
                          putdec(num);
                        }
                        puts("  ");
                        num++;
                      }
                    }
                    if(n && buf[k] == '\n' && (k+1)<rd) {
                      puts("    ");
                      if(num > 9) {
                        putdec(num);
                      }
                      else {
                        puts(" ");
                        putdec(num);
                      }
                      puts("  ");
                      num++;
                    }
                }
            }
        }
        close(fd);
        j++;
    }
    return 0;
}
