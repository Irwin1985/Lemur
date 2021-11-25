module parser
import ast

fn parse_function_call(mut p Parser, function ast.Node) &ast.Node {
	return p.parse_function_call(function)
}

fn (mut p Parser) parse_function_call(function ast.Node) &ast.Node {
	mut exp := &ast.FunctionCall{token: p.cur_token, function: function}
	p.expect(.tt_lparen, "expect '(' token")
	exp.arguments = p.parse_expression_list(.tt_rparen)
	
	return exp
}