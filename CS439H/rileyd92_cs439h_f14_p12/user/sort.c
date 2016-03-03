#include "libc.h"

int length(char* string) {
  int len = 0;
  while(string[len]) {
    len++;
  }
  return len;
}

int isSmaller(char* string2, char* string1) {
  if(length(string1) < length(string2)) {
    for(int i = 0; i < length(string1); i++) {
      if(string1[i] < string2[i]) {
        return 1;
      }
      if(string1[i] > string2[i]) {
        return 0;
      }
    }
    return 1;
  }
  else if(length(string1) > length(string2)) {
    for(int i = 0; i < length(string2); i++) {
      if(string1[i] < string2[i]) {
        return 1;
      }
      if(string1[i] > string2[i]) {
        return 0;
      }
    }
    return 0;
  }
  else {
    for(int i = 0; i < length(string1); i++) {
      if(string1[i] < string2[i]) {
        return 1;
      }
      if(string1[i] > string2[i]) {
        return 0;
      }
    }
  }
  return 0;
}

int main(int argc, char** argv) {

  if(argv[0][0] && argv[0][1] && argv[0][0] == 'l' && argv[0][1] == 's') {
    int a = 0;
    int i = 0;
    while(argv[0][i]) {
      if(argv[0][i] == '-' && argv[0][i+1] && argv[0][i+1] == 'a') {
        a = 1;
      }
      i++;
    }
    if(a) {
      puts(".");
      puts("\n");
      puts("..");
      puts("\n");
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
      for(int j = 0; j < 13; j++) {
        args[q][j] = buf[j];
      }
      args[q][13] = 0;
      q++;
    }
    int done[n];
    for(int i = 0; i < n; i++) {
      done[i] = 0;
    }
    int count = 0;
    int place;
    while(count < n) {
      place = 0;
      char* smallest = "zzzzzzzzzzzzzzz";
      for(int i = 0; i < n; i++) {
        if((isSmaller(smallest,args[i])) && (!done[i])) {
          smallest = args[i];
          place = i;
        }
      }
      puts(smallest);
      done[place] = 1;
      count++;
      puts("\n");
    }
    return 0;
  }

  return 0;
}
