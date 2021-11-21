module ast
import token

pub struct StringLiteral {
	pub mut:
		token token.Token
		value string
}

pub fn (s StringLiteral) to_string() string {
	return '"$s.value"'
}