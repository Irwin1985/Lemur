module evaluator
import ast
import object

fn eval_let_stmt(node ast.LetStatement, mut storage object.Storage) object.Object {
	val := eval(node.value, mut storage)
	if val is object.RuntimeError {
		return val
	}
	return storage.set(node.name.value, val)
}