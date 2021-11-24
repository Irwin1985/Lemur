module ast
import token
import strings

pub struct FunctionLiteral {
	pub mut:
		token token.Token
		parameters []Identifier
		body BlockStatement
}

pub fn (f FunctionLiteral) to_string() string {
	mut out := strings.new_builder(4)
	mut params := []string{}
	for p in f.parameters {
		params << p.to_string()
	}
	out.write_string("fn(")
	out.write_string(params.join(", "))
	out.write_string(")")
	out.write_string(f.body.to_string())

	return out.str()
}