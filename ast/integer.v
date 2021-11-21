module ast
import token

pub struct IntegerLiteral {
	pub mut:
		token token.Token
		value f64
}

pub fn (i IntegerLiteral) to_string() string {
	return i.value.str()
}