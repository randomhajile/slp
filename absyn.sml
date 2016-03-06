structure Absyn =
struct
datatype binop = PLUS | MINUS | TIMES | DIVIDE
     and stm = AssignStm   of string * exp
             | PrintStm    of exp list
             | CompoundStm of stm * stm
     and exp = IdExp   of string
             | NumExp  of int
             | OpExp   of exp * binop * exp
             | EseqExp of stm * exp
end;
