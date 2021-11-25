module ast
import token
import strings

pub struct IfExpression {
	pub mut:
		token token.Token
		condition Node
		consequence Node
		alternative Node
}

pub fn (i IfExpression) to_string() string {
	mut out := strings.new_builder(6)
	out.write_string("if (")
	out.write_string(i.condition.to_string())
	out.write_string(")")
	out.write_string(i.consequence.to_string())
	if i.alternative is BlockStatement {
		out.write_string("\nelse\n")
		out.write_string(i.alternative.to_string())
	}
	return out.str()
}