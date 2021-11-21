module parser
import ast
// letStmt ::= 'let' '=' expression (';')
fn (mut p Parser) parse_let_statement() &ast.LetStatement {
	mut stmt := &ast.LetStatement {
					token: p.cur_token,
					name: ast.Identifier{},
					value: ast.None{},
				}

	p.next_token() // skip 'let' keyword
	stmt.name = ast.Identifier{token: p.cur_token, value: p.cur_token.lexeme}
	p.next_token()

	p.expect(.tt_assign, "expected '=' symbol.")
	stmt.value = p.parse_expression(lowest)

	return stmt
}