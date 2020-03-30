%{
    #include <stdio.h>
    #include <stdlib.h>
    extern FILE *yyin;
    extern int yylineno;
    
%}
%locations
%token NL ID NUM REAL RELOP FOR KEY_END KEY_BEGIN INCOP DECOP OP EQ INT FLOAT CHAR
%%
functions: functions NL function
    | function
    ;
function: type ID '(' args ')' NL KEY_BEGIN NL statements NL KEY_END
    ;
args: args ',' arg 
    | arg
    |
    ;
arg: type ID
    ;
statements:  statements NL statement
    | statement
    ;
type: INT 
    | FLOAT 
    | CHAR
    ;

statement: for_statement 
    | declaration_statement ';'
    | assignment_statement ';'
    | ';'
    |
    ;
for_statement: FOR '(' assignment_statement ';' ID binop ID ';' inc_dec_stm ')' NL KEY_BEGIN NL statements NL KEY_END
    ;
declaration_statement: type varlist
    ;
varlist: var ',' varlist 
    | var
    ;
var: ID 
    | assignment_statement
    ;
assignment_statement: ID EQ expression
    ;
binop: RELOP 
    | OP
    ;
inc_dec_stm: ID INCOP 
    | INCOP ID 
    | ID DECOP 
    | DECOP ID
    ;
expression: ID binop ID
    | inc_dec_stm
    | ID 
    | NUM 
    | REAL
    ;
%%  
int yyerror(char *s) {
    fprintf(stderr, "line %d: %s\n", yylineno, s);
    exit(0);
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
    puts("Program compiled successfully");
    return 0;
}