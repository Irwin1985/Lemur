module parser
import ast

fn parse_function_literal(mut p Parser) &ast.Node {
	return p.parse_function_literal()
}

fn (mut p Parser) parse_function_literal() &ast.Node {
	
	mut lit := &ast.FunctionLiteral{token: p.cur_token}
	p.next_token() // advance 'fn'
	p.expect(.tt_lparen, "expect '(' before function name.")
	lit.parameters = p.parse_function_parameters()
	lit.body = p.parse_block_statement()

	return lit
}

fn (mut p Parser) parse_function_parameters() []ast.Identifier {
	mut params := []ast.Identifier{}

	if p.cur_token_is(.tt_rparen) {
		p.next_token()
		return params
	}
	
	params << ast.Identifier{token: p.cur_token, value: p.cur_token.lexeme}
	p.next_token() // advance identifier
	for p.cur_token_is(.tt_comma) {
		p.next_token() // advance comma
		params << ast.Identifier{token: p.cur_token, value: p.cur_token.lexeme}
		p.next_token() // advance identifier
	}
	p.expect(.tt_rparen, "expect ')' after parameters declaration.")

	return params
}