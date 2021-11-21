module ast
import token

pub struct ExpressionStmt {
	pub mut:
		token token.Token
		expression Node
}

pub fn (e ExpressionStmt) to_string() string {
	return e.expression.to_string()
}