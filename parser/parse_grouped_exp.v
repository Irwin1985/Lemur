module parser
import ast

fn parse_grouped_exp(mut p Parser) &ast.Node {
	return p.parse_grouped_exp()
}

fn (mut p Parser) parse_grouped_exp() &ast.Node {
	// advance the lparen '('
	p.next_token()
	// catch the expression between
	exp := p.parse_expression(lowest)
	// advance the rparen
	p.expect(.tt_rparen, "expect ')' after grouped expression.")

	return exp
}