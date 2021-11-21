module parser
import ast

fn parse_identifier(mut p Parser) &ast.Node {
	return p.parse_identifier()
}

fn (mut p Parser) parse_identifier() &ast.Node {
	exp := &ast.Identifier{
		token: p.cur_token,
		value: p.cur_token.lexeme,
	}
	p.next_token()
	return exp
}