/*
 *  demo.y
 */

%{
#include <stdio.h>

#define YYERROR_VERBOSE

int yylineno;
int syntax_error = 0;
char *yytext;
int yylex();
int yyerror();
%}

/* declare tokens */
%token NAME
%token NUMBER
%token CHARCONST
%token AND
%token BY
%token CHAR
%token ELSE
%token FOR
%token IF
%token INT
%token NOT
%token OR
%token PROCEDURE
%token READ
%token THEN
%token TO
%token WHILE
%token WRITE
%token COLON
%token SEMICOLON
%token COMMA
%token EQUALS
%token LBRACKET
%token RBRACKET
%token LBRACE
%token RBRACE
%token LPAREN
%token RPAREN
%token PLUS
%token MINUS
%token MULT
%token DIV
%token LT
%token LE
%token EQ
%token NE
%token GT
%token GE
%token ENDOFFILE 0

%start Grammar
%%
Grammar   : Procedure;

Procedure : PROCEDURE NAME LBRACKET Decls Stmts RBRACKET;

Decls     : Decls Decl SEMICOLON
          | Decl SEMICOLON;

Decl      : Type SpecList;

Type      : INT
          | CHAR;

SpecList  : SpecList COMMA Spec
          | Spec;

Spec      : NAME
          | NAME LBRACE Bounds RBRACE;

Bounds    : Bounds COMMA Bound
          | Bound;

Bound     : NUMBER COLON NUMBER;

Stmts     : Stmts Stmt
          | Stmt;

Stmt      : Reference EQUALS Expr SEMICOLON
          | LBRACKET Stmts RBRACKET
          | LBRACKET RBRACKET { yyerror("Empty statement list"); }
          | WHILE LPAREN Bool RPAREN LBRACKET Stmts RBRACKET
          | FOR NAME EQUALS Expr TO Expr BY Expr LBRACKET Stmts RBRACKET
          | IF LPAREN Bool RPAREN THEN Stmt
          | IF LPAREN Bool RPAREN THEN Stmt ELSE Stmt
          | READ Reference SEMICOLON
          | WRITE Expr SEMICOLON;
          | error { yyclearin; } ;

Bool      : NOT OrTerm
          | OrTerm;

OrTerm    : OrTerm OR AndTerm
          | AndTerm;

AndTerm   : AndTerm AND RelExpr
          | RelExpr;

RelExpr   : RelExpr LT Expr
          | RelExpr LE Expr
          | RelExpr EQ Expr
          | RelExpr NE Expr
          | RelExpr GE Expr
          | RelExpr GT Expr
          | Expr;

Expr      : Expr PLUS Term
          | Expr MINUS Term
          | Term;

Term      : Term MULT Factor
          | Term DIV Factor
          | Factor;

Factor    : LPAREN Expr RPAREN
          | Reference
          | NUMBER
          | CHARCONST;
          | error { yyclearin; }

Reference : NAME
          | NAME LBRACE Exprs RBRACE;

Exprs     : Expr COMMA Exprs
          | Expr;
%%

int yywrap() { return 1; }

int yyerror(char *s) {
  syntax_error += 1;
  fprintf(stderr, "Line %d: %s\n", yylineno, s);
  return 0;
}
