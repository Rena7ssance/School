#include <stdio.h>

extern int syntax_error;
extern FILE *yyin;

int yyparse();

int main(int argc, char **argv) {

  int run = 1;

  if(argc == 3) {
    if((argv[1][0] == '-') && (argv[1][1] == 'h')) {
      printf("demo [-h] [filename]\n");
      run = 0;
    }
    else if((argv[1][0] == '-') && (argv[1][1] != 'h')) {
      printf("demo: unrecognized option '-%c'\n",argv[1][1]);
      run = 0;
    }
    else {
      FILE *file = fopen(argv[2], "r");
      if(!file) {
        printf("%s not found\n",argv[2]);
        run = 0;
      }
      yyin = file;
    }
  }
  else if(argc == 2) {
    if((argv[1][0] == '-') && (argv[1][1] == 'h')) {
      printf("demo [-h] [filename]\n");
      run = 0;
    }
    else if((argv[1][0] == '-') && (argv[1][1] != 'h')) {
      printf("demo: unrecognized option '-%c'\n",argv[1][1]);
      run = 0;
    }
    else {
      FILE *file = fopen(argv[1], "r");
      if(!file) {
        printf("%s not found\n",argv[1]);
        run = 0;
      }
      yyin = file;
    }
  }

  if(run) {
    yyparse();

    if(syntax_error == 0) {
      printf("Parser succeeds.\n");
    }
    else {
      printf("\n");
      if(syntax_error == 1) {
        printf("Parser fails with 1 error message.\n");
      }
      else {
        printf("Parser fails with %d error messages.\n",syntax_error);
      }
      printf("Execution halts.\n");
    }
  }
  return 0;
}
