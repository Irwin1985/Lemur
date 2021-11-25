module parser
import ast

fn parse_if_expression(mut p Parser) &ast.Node {
	return p.parse_if_expression()
}

fn (mut p Parser) parse_if_expression() &ast.Node {
	mut exp := &ast.IfExpression {
		token: p.cur_token,
		condition: ast.None{},
		consequence: ast.None{},
		alternative: ast.None{},
	}

	p.next_token() // skip 'if'
	p.expect(.tt_lparen, "expect '(' before condition")
	exp.condition = p.parse_expression(lowest)

	p.expect(.tt_rparen, "expect ')' before condition")
	exp.consequence = p.parse_block_statement()

	if p.cur_token_is(.tt_else) {
		p.next_token() // eat 'else' keyword
		exp.alternative = p.parse_block_statement()
	}

	return exp
}