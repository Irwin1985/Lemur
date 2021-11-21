module ast
import strings

pub struct Program {
	pub mut:
		statements []Node
}

pub fn (p Program) to_string() string {
	mut out := strings.new_builder(p.statements.len)
	for _, s in p.statements {
		out.write_string(s.to_string())
	}
	return out.str()
}