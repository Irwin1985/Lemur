module ast
import token

pub struct ReturnStatement {
	pub mut:
		token token.Token
		value Node
}

fn (r ReturnStatement) statement_node() {}

fn (r ReturnStatement) token_literal() string {
	return r.token.lexeme
}

pub fn (r ReturnStatement) to_string() string {
	return r.value.to_string()
}