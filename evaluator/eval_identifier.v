module evaluator
import ast
import object 

fn eval_identifier(node ast.Identifier, mut env object.Env) object.Object {
	mut name := node.value
	
	result := object.get(mut env, name)
	if result is object.None {
		return object.RuntimeError {message: "$name not found."}
	}
	return result

}