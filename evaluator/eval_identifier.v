module evaluator
import ast
import object 

fn eval_identifier(node ast.Identifier, mut storage object.Storage) object.Object {
	mut name := node.value
	
	result := storage.get(name)
	if result is object.None {
		return object.RuntimeError {message: "$name not found."}
	}
	return result

}