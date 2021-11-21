module ast
import token

pub struct StringLiteral {
	pub mut:
		token token.Token
		value string
}

fn (s StringLiteral) expression_node() {}

fn (s StringLiteral) token_literal() string {
	return s.token.lexeme
}

pub fn (s StringLiteral) to_string() string {
	return '"$s.value"'
}