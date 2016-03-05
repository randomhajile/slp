type pos = int

type svalue = Tokens.svalue
type ('a,'b) token = ('a, 'b) Tokens.token
type lexresult  = (svalue, pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos

fun err (p1, p2) = ErrorMsg.error p1
fun extractInt(SOME(i)) = i;
fun eof () =
    let
        val pos = hd (!linePos)
    in
        Tokens.EOF (pos, pos)
    end

%%
whitespace = [ \t\n];
%header (functor SlpLexFun(structure Tokens: Slp_TOKENS));

%%
"("                  => (Tokens.LPAREN (yypos, yypos + 1));
")"                  => (Tokens.RPAREN (yypos, yypos + 1));
","                  => (Tokens.COMMA (yypos, yypos + 1));
";"                  => (Tokens.SEMICOLON (yypos, yypos + 1));
"+"                  => (Tokens.PLUS (yypos, yypos + 1));
"-"                  => (Tokens.MINUS (yypos, yypos + 1));
"*"                  => (Tokens.TIMES (yypos, yypos + 1));
"/"                  => (Tokens.DIVIDE (yypos, yypos + 1));
":="                 => (Tokens.ASSIGN (yypos, yypos + 2));
"print"              => (Tokens.PRINT (yypos, yypos + 5));
[a-zA-Z][a-zA-Z0-9]* => (Tokens.ID(yytext, yypos, yypos + size yytext));
([1-9][0-9]*|0)      => (Tokens.INT(extractInt(Int.fromString yytext), yypos, yypos + size yytext));
\n                   => (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
{whitespace}         => (continue());
.                    => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());
