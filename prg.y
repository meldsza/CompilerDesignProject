%{
    #include <stdio.h>
    #include <stdlib.h>
    extern FILE *yyin;
    extern int yylineno;
%}

%token NL ID NUM REAL RELOP FOR KEY_END KEY_BEGIN INCOP DECOP OP EQ INT FLOAT CHAR
%%
functions: function NL functions
    | function
    ;
function: type ID '(' args ')' NL KEY_BEGIN NL statements NL KEY_END 
    | type ID '(' ')' NL KEY_BEGIN NL statements NL KEY_END
    ;
type: INT 
    | FLOAT 
    | CHAR
    ;
args: arg ',' args 
    | 
    arg
    ;
arg: type ID
    ;
statements: statement NL statements
    | statement
    ;
statement: for_statement 
    | declaration_statement 
    | assignment_statement
    ;
for_statement: FOR '(' assignment_statement ',' expression ',' expression ')' NL KEY_BEGIN NL statements NL KEY_END NL
    ;
declaration_statement: type varlist
    ;
varlist: var ',' varlist 
    | var
    ;
var: ID 
    | assignment_statement
    ;
assignment_statement: ID '=' expression
    ;
binop: RELOP 
    | OP
    ;
inc_dec_stm: ID INCOP 
    | INCOP ID 
    | ID DECOP 
    | DECOP ID
    ;
expression: expression binop expression 
    | inc_dec_stm
    | ID 
    | NUM 
    | REAL
    ;
%%  
int yyerror(char *s) {
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}

int main(int argc, char* argv[])
{
    if(argc != 2)
    {
        puts("Invalid arguments provided");
        return 1;
    }
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);  
    return 0;
}