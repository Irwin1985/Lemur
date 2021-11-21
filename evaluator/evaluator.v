module evaluator
import object
import ast

pub fn eval(node ast.Node, mut env object.Environment) object.Object {
	match node {
		ast.ExpressionStmt { return eval(node.expression, mut env) }
		ast.LetStatement { return eval_let_stmt(node, mut env) }
		ast.IntegerLiteral { return object.Integer{value: node.value }}
		ast.StringLiteral { return object.String{value: node.value }}
		ast.Identifier { return eval_identifier(node, mut env) }
		ast.Boolean { return object.Boolean{value: node.value} }
		ast.Binary { return eval_binary(node, mut env) }
		else {
			return object.None{}
		}
	}
}

pub fn eval_program(node ast.Program, mut env object.Environment) object.Object {
	mut result := new_result(object.None{})
	for _, stmt in node.statements {
		result.value = eval(stmt, mut env)
	}
	return result.value
}