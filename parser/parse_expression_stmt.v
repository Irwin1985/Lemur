module parser
import ast

fn (mut p Parser) parse_expression_stmt() &ast.ExpressionStmt {

	stmt := &ast.ExpressionStmt{
			token: p.cur_token,
			expression: p.parse_expression(lowest),
		}
	if p.cur_token_is(.tt_semicolon) {
		p.next_token()
	}

	return stmt
}