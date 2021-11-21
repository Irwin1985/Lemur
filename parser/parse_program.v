module parser
import token { TokenType }
import ast

pub fn (mut p Parser) parse_program() &ast.Program {
	mut program := &ast.Program{}

	for !p.cur_token_is(.tt_eof) {
		program.statements << p.parse_statement()
	}

	if !p.cur_token_is(.tt_eof) {
		p.errors << "expected end of file."
	}

	return program
}