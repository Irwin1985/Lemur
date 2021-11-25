module evaluator
import ast
import object

fn eval_return_statement(node ast.ReturnStatement, mut storage object.Storage) object.Object {
	return object.ReturnStatement {
			value: eval(node.value, mut storage)
		}
}