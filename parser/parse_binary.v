module parser
import ast


fn parse_binary(mut p Parser, left ast.Node) &ast.Node {
	return p.parse_binary(left)
}

fn (mut p Parser) parse_binary(left ast.Node) &ast.Node {
	mut exp := &ast.Binary {
		token: p.cur_token,
		op: p.cur_token.lexeme,
		left: left,
		right: ast.None{},
	}

	// first we need to determine the precedence order for the current token.
	order := p.cur_precedence()
	// then is safe to advance the token
	p.next_token()

	exp.right = p.parse_expression(order)

	return exp
}