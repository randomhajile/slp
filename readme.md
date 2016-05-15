# SLP #
SLP (Straight Line Programming Language) is a simple running example from Appel's [Modern Compiler Implementation in ML](https://www.cs.princeton.edu/~appel/modern/),
given by the grammar:
```
stm     ::= <stm>;<stm> | <id>:=<exp> | print(<expList>)
exp     ::= <id> | <num> | <exp> <binOp> <exp> | (<stm>, <exp>)
expList ::= <exp>,<expList> | <exp>
binOp   ::= + | - | * | /
```
This interpreter was mostly written so I could familiarize myself with smlnj's build system.

## Usage ##
To evaluate a source file, simply run `Eval.eval "/path/to/file"`. Print statements will be printed to stdout.
To generate an AST, run `Parse.parse "/path/to/file"`.
