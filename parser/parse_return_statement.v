module parser
import ast

fn (mut p Parser) parse_return_statement() &ast.ReturnStatement {
	mut stmt := &ast.ReturnStatement {
			token: p.cur_token,
			value: ast.None{},
		}

	p.expect(.tt_return, "expect RETURN keyword.")
	stmt.value = p.parse_expression(lowest)

	return stmt
}