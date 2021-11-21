module evaluator
import ast
import object

fn eval_let_stmt(node ast.LetStatement, mut env object.Environment) object.Object {
	val := eval(node.value, mut env)
	if val is object.RuntimeError {
		return val
	}
	return env.set(node.name.value, val)
}