module evaluator
import object
import ast

pub fn eval(node ast.Node, mut storage object.Storage) object.Object {
	match node {
		ast.ExpressionStmt { return eval(node.expression, mut storage) }
		ast.ReturnStatement { return eval_return_statement(node, mut storage) }
		ast.BlockStatement { return eval_block_statement(node, mut storage) }
		ast.LetStatement { return eval_let_stmt(node, mut storage) }
		ast.IntegerLiteral { return object.Integer{value: node.value }}
		ast.StringLiteral { return object.String{value: node.value }}
		ast.Identifier { return eval_identifier(node, mut storage) }
		ast.Boolean { return object.Boolean{value: node.value} }
		ast.Binary { return eval_binary(node, mut storage) }
		ast.FunctionLiteral { return eval_function_literal(node, mut storage) }
		ast.FunctionCall { return eval_function_call(node, mut storage) }
		ast.IfExpression { return eval_if_expression(node, mut storage) }
		else {
			return object.None{}
		}
	}
}

pub fn eval_program(node ast.Program, mut storage object.Storage) object.Object {
	mut result := new_result(object.None{})
	for _, stmt in node.statements {
		result.value = eval(stmt, mut storage)
		/*
		match result.value {
			object.ReturnStatement { return result.value.value }
			object.RuntimeError { return result.value }
			else { return result.value }
		}
		*/
	}
	return result.value
}

fn eval_expressions(exps []ast.Node, mut storage object.Storage) []object.Object {
	mut result := []object.Object{}
	for exp in exps {
		mut evaluated := eval(exp, mut storage)
		result << evaluated
		if evaluated is object.RuntimeError {
			return result
		}
	}
	return result
}