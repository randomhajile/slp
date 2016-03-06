structure Eval =
struct
  structure SlpLrVals = SlpLrValsFun(structure Token = LrParser.Token)
  structure Lex = SlpLexFun(structure Tokens = SlpLrVals.Tokens)
  structure SlpP = Join(structure ParserData = SlpLrVals.ParserData
			structure Lex=Lex
			structure LrParser = LrParser)
  fun eval filename =
      let val _ = (ErrorMsg.reset(); ErrorMsg.fileName := filename)
	  val file = TextIO.openIn filename
	  fun get _ = TextIO.input file
	  fun parseerror(s,p1,p2) = ErrorMsg.error p1 s
	  val lexer = LrParser.Stream.streamify (Lex.makeLexer get)
	  val (absyn, _) = SlpP.parse(30,lexer,parseerror,())
       in TextIO.closeIn file;
	   absyn
      end handle LrParser.ParseError => raise ErrorMsg.Error

end
