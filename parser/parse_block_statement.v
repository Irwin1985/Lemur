module parser
import ast

fn (mut p Parser) parse_block_statement() &ast.BlockStatement {
	mut block := &ast.BlockStatement{token: p.cur_token}
	mut stmts := []ast.Node{}
	p.expect(.tt_lbrace, "expect '{' before block")
	for !p.cur_token_is(.tt_rbrace) {
		stmts << p.parse_statement()
	}
	block.statements = stmts
	p.expect(.tt_rbrace, "expect '}' after block")	
	return block
}