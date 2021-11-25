module evaluator
import ast
import object

fn eval_if_expression(node ast.IfExpression, mut storage object.Storage) object.Object {
	cond := eval(node.condition, mut storage)
	if cond is object.RuntimeError {
		return cond
	}
	if cond is object.Boolean {
		if cond.value == true {
			return eval(node.consequence, mut storage)
		} else {
			return eval(node.alternative, mut storage)
		}
	}
	return object.RuntimeError{message: "the if condition must be evaluated to boolean"}
}