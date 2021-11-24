module ast
import token
import strings

pub struct BlockStatement {
	pub mut:
		token token.Token
		statements []Node
}

pub fn (b BlockStatement) to_string() string {
	mut out := strings.new_builder(3)
	
	out.write_string("\n{\n")
	mut blocks := []string{}
	for s in b.statements {
		blocks << s.to_string() + "\n"
	}
	out.write_string(blocks.join(", "))
	out.write_string("}")

	return out.str()
}