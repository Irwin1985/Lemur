module ast
import token

pub struct Boolean {
	pub mut:
		token token.Token
		value bool
}

pub fn (b Boolean) to_string() string {
	return if b.value { "true" } else { "false" }
}