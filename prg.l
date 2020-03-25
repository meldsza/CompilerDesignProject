%{
	#include "y.tab.h"
%}

%%
"for" {return FOR;}
"KEY_BEGIN" {return KEY_BEGIN;}
"KEY_END" {return KEY_END;}
"int" {return INT;}
"char" {return CHAR;}
"float" {return FLOAT;}
[a-zA-Z][a-zA-Z0-9]* {return ID;}
[0-9]+ {return NUM;}
[0-9]+\.[0-9]+ {return REAL;}
">"|"<"|">="|"<="|"=="|"!=" {return RELOP;}
"+"|"-"|"*"|"/" {return OP;}
"=" {return EQ;}
"++" {return INCOP;}
"--" {return DECOP;}
\n {return NL;}
" " {}
. {return yytext[0];}
%%

int yywrap()
{
	return 1;
}