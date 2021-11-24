module ast
import token
import strings

pub struct FunctionCall {
	pub mut:
		token token.Token
		function Node
		arguments []Node
}

pub fn(f FunctionCall) to_string() string {
	mut out := strings.new_builder(4)
	out.write_string(f.function.to_string())
	out.write_string("(")

	mut args := []string{}
	for a in f.arguments {
		args << a.to_string()
	}
	out.write_string(args.join(", "))
	out.write_string(")")

	return out.str()
}