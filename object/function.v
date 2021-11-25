module object
import ast

pub struct Function {
	pub mut:
		parameters []ast.Identifier
		env Storage
		body ast.BlockStatement
}

fn (f Function) @type() string {
	return obj_function
}

fn (f Function) inspect() string {
	return "function ok"
}