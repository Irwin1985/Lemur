module ast
import token

pub struct LetStatement {
	pub mut:
		token token.Token
		name Identifier
		value Node
}

pub fn (l LetStatement) to_string() string {
	return "let $l.name.to_string() = $l.value.to_string();"
}