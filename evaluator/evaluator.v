module evaluator
import object
import ast

pub fn eval(node ast.Node, mut storage object.Storage) object.Object {
	match node {
		ast.ExpressionStmt { return eval(node.expression, mut storage) }
		ast.LetStatement { return eval_let_stmt(node, mut storage) }
		ast.IntegerLiteral { return object.Integer{value: node.value }}
		ast.StringLiteral { return object.String{value: node.value }}
		ast.Identifier { return eval_identifier(node, mut storage) }
		ast.Boolean { return object.Boolean{value: node.value} }
		ast.Binary { return eval_binary(node, mut storage) }
		else {
			return object.None{}
		}
	}
}

pub fn eval_program(node ast.Program, mut storage object.Storage) object.Object {
	mut result := new_result(object.None{})
	for _, stmt in node.statements {
		result.value = eval(stmt, mut storage)
	}
	return result.value
}