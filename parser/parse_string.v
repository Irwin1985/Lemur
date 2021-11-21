module parser
import ast

fn parse_string(mut p Parser) &ast.Node {
	return p.parse_string()
}

fn (mut p Parser) parse_string() &ast.Node {
	exp := &ast.StringLiteral {
		token: p.cur_token,
		value: p.cur_token.lexeme
	}
	p.next_token()

	return exp
}