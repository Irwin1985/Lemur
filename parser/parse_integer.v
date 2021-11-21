module parser
import ast
import strconv

fn parse_integer(mut p Parser) &ast.Node {
	return p.parse_integer()
}

fn (mut p Parser) parse_integer() &ast.Node {
	exp := &ast.IntegerLiteral {
		token: p.cur_token,
		value: strconv.atof64(p.cur_token.lexeme)
	}
	p.next_token()

	return exp
}

