module ast
import token

pub struct ReturnStatement {
	pub mut:
		token token.Token
		value Node
}

pub fn (r ReturnStatement) to_string() string {
	return r.value.to_string()
}