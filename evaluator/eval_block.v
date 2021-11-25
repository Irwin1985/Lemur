module evaluator
import ast
import object

fn eval_block_statement(node ast.BlockStatement, mut storage object.Storage) object.Object {
	mut result := new_result(object.None{})
	for _, stmt in node.statements {
		result.value = eval(stmt, mut storage)
		match result.value {
			object.ReturnStatement { return result.value }
			object.RuntimeError { return result.value }
			else { return result.value }
		}
	}
	return result.value
}