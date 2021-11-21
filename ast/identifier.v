module ast
import token

pub struct Identifier {
	pub mut:
		token token.Token // the token.TokenType.tt_ident token
		value string
}

pub fn (i Identifier) to_string() string {
	return i.value
}