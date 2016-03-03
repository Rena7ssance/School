#include "libc.h"

//REFERENCES
//DISCUSSED PROJECT IMPLEMENTATIONS WITH SARAH MAGLIOCCA AND MARK LINDBERG

void notFound(char* cmd) {
    puts(cmd);
    puts(": command not found\n");
}

int length(char *string) {
  int i = 0;
  while(string[i]) {
    i++;
  }
  return i;
}

int main() {
    //long sem = semaphore(1);
    while (1) {
        puts("shell> ");
        char* in = gets();

        int spaces = 0;
        int i = 0;

        while(in[spaces] == ' ') {
          spaces++;
        }

        while(in[spaces+i] != ' ' && in[spaces+i] != '\0' && in[spaces+i] != '\r') {
          i++;
        }

        char *cmd = malloc(i - spaces);

        //puts("\n");
        for(int j = 0; j < i; j++) {
          cmd[j] = in[j+spaces];
        }
        cmd[i] = '\0';

        int cmdLen = length(cmd);
        long sem = semaphore(1);

        if(cmdLen == 2 && cmd[0] && cmd[1] && cmd[0] == 'l' && cmd[1] == 's') {
          char* a = '\0';
          long id = fork();
          if(id == 0) {
            execv("ls",&a);
          }
          else {
            join(id);
          }
        }
        else if(cmdLen == 4 && cmd[0] && cmd[1] && cmd[2] && cmd[3] && cmd[0] == 'e' && cmd[1] == 'c' && cmd[2] == 'h' && cmd[3] == 'o') {
          //echo
          int count = 0;
          int ind = 0;

          while(in[ind+i+spaces] != '\0') {
            if(in[ind+i+spaces-1] == ' ' && in[ind+i+spaces] != ' ') {
              count++;
            }
            ind++;
          }

          char** args = malloc(4*(count+1));
          args[0] = "echo";

          int argCount = 1;
          while(argCount < (count+1)) {
            int d = 0;
            while(in[d+i+spaces] == ' ') {
              spaces++;
            }
            while(in[d+i+spaces] != ' ' && in[d+i+spaces] != '\0' && in[spaces+i] != '\r') {
              d++;
            }

            char* arg1 = malloc(d);
            for(int h = 0; h < d; h++) {
              arg1[h] = in[h+i+spaces];
            }
            spaces += d;
            arg1[d] = '\0';
            args[argCount] = arg1;
            argCount++;
          }
          args[count+1] = '\0';

          long id = fork();
          if(id == 0) {
            up(sem);
            execv("echo",args);
          }
          else {
            down(sem);
            join(id);
          }
          free(args);
        }
        else if(cmdLen == 0) {
          continue;
        }
        else if(cmdLen == 3 && cmd[0] && cmd[1] && cmd[2] && cmd[0] == 'c' && cmd[1] == 'a' && cmd[2] == 't') {
          //cat
          int count = 0;
          int ind = 0;

          while(in[ind+i+spaces] != '\0') {
            if(in[ind+i+spaces-1] == ' ' && in[ind+i+spaces] != ' ') {
              count++;
            }
            ind++;
          }

          char** args = malloc(4*(count+1));
          args[0] = "cat";

          int argCount = 1;
          while(argCount < (count+1)) {
            int d = 0;
            while(in[d+i+spaces] == ' ') {
              spaces++;
            }
            while(in[d+i+spaces] != ' ' && in[d+i+spaces] != '\0' && in[spaces+i] != '\r') {
              d++;
            }

            char* arg1 = malloc(d);
            for(int h = 0; h < d; h++) {
              arg1[h] = in[h+i+spaces];
            }
            spaces += d;
            arg1[d] = '\0';
            args[argCount] = arg1;
            argCount++;
          }
          args[count+1] = '\0';

          long id = fork();
          if(id == 0) {
            up(sem);
            execv("cat",args);
          }
          else {
            down(sem);
            join(id);
          }
          free(args);
        }

        else if(cmdLen == 8 && cmd[0] && cmd[1] && cmd[2] && cmd[3] && cmd[4] && cmd[5] && cmd[6] && cmd[7] && cmd[0] == 's' && cmd[1] == 'h' && cmd[2] == 'u' && cmd[3] == 't' && cmd[4] == 'd' && cmd[5] == 'o' && cmd[6] == 'w' && cmd[7] == 'n') {
          char* a = '\0';
          execv("shutdown",&a);
          puts("\n");
        }
        else if(cmdLen >= 4 && cmd[cmdLen-4] == '.' && cmd[cmdLen-3] == 't' && cmd[cmdLen-2] == 'x' && cmd[cmdLen-1] == 't') {
          //executable
          char ** args = malloc(12);
          args[0] = "cat";
          args[1] = cmd;
          args[2] = '\0';
          long id = fork();
          if(id == 0) {
            up(sem);
            execv("cat",args);
          }
          else {
            down(sem);
            join(id);
          }
          free(args);
        }
        else if(cmdLen == 5 && cmd[0] == 's' && cmd[1] == 'h' && cmd[2] == 'e' && cmd[3] == 'l' && cmd[4] == 'l') {
          continue;
        }
        else if(cmdLen == 5 && cmd[0] == 'p' && cmd[1] == 'a' && cmd[2] == 'n' && cmd[3] == 'i' && cmd[4] == 'c') {
          char ** args = malloc(12);
          args[0] = "cat";
          args[1] = cmd;
          args[2] = '\0';
          long id = fork();
          if(id == 0) {
            up(sem);
            execv("cat",args);
          }
          else {
            down(sem);
            join(id);
          }
          free(args);
        }
        else {
          //not found
          notFound(cmd);
        }
        //puts("\n");
        if (in) free(in);
    }
    return 0;
}
