module parser
import ast

fn parse_boolean(mut p Parser) &ast.Node {
	return p.parse_boolean()
}

fn (mut p Parser) parse_boolean() &ast.Node {
	exp := &ast.Boolean{
		token: p.cur_token,
		value: if p.cur_token.category == .tt_true { true } else { false },
	}
	p.next_token()

	return exp
}