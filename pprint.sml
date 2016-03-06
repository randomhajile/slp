structure PrintAbsyn :
          sig val print : TextIO.outstream * Absyn.stm -> unit end =
struct

structure A = Absyn

fun print (outstream, stm0) =
    let
        fun say s = TextIO.output (outstream, s)
        fun sayln s =(
            say s;
            say "\n"
        )
        fun indent 0 = ()
          | indent i = (
              say " ";
              indent (i-1)
          )
        fun opname A.PLUS   = "PlusOp"
          | opname A.MINUS  = "MinusOp"
          | opname A.TIMES  = "TimesOp"
          | opname A.DIVIDE = "DivideOp"
        fun var (s, d) = (
            indent d;
            say "Var(";
            say s;
            say ")"
        )
        fun num (n, d) = (
            say "Num(";
            say (Int.toString n);
            say ")"
        )
        fun stm (A.AssignStm (v, e), d) = (
            indent d;
            sayln "AssignStm(";
            var (v, d+1);
            sayln ",";
            exp (e, d+1);
            say ")"
        )
          | stm (A.PrintStm [], d) = (
              indent d;
              say "PrintStm()"
          )
          | stm (A.PrintStm es, d) = (
              indent d;
              sayln "PrintStm(";
              exps (es, d+1);
              say ")"
          )
          | stm (A.CompoundStm (s1, s2), d) = (
              indent d;
              sayln "Compound(";
              stm (s1, d+1);
              sayln ",";
              stm (s2, d+1);
              say ")"
          )
        and exps ([e], d) = exp (e, d)
          | exps (e::es, d) = (
              exp (e, d);
              sayln ",";
              exps (es, d)
          )
        and exp (A.IdExp (s), d) = (
            indent d;
            say "IdExp(";
            say s;
            say ")"
        )
          | exp (A.NumExp (s), d) = (
              indent d;
              say "NumExp(";
              say (Int.toString s);
              say ")"
          )
          | exp (A.OpExp (e1, bop, e2), d) = (
              indent d;
              sayln "OpExp(";
              indent (d+1);
              say (opname bop);
              sayln ",";
              exp (e1, d+1);
              sayln ",";
              exp (e2, d+1);
              say ")"
          )
          | exp (A.EseqExp (s, e), d) = (
              indent d;
              sayln "EseqExp(";
              stm (s, d+1);
              sayln ",";
              exp (e, d+1);
              say ")"
          )
    in
        stm (stm0, 0);
        sayln "";
        TextIO.flushOut outstream
    end
end
