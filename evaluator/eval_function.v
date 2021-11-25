module evaluator
import ast
import object

fn eval_function_literal(node ast.FunctionLiteral, mut storage object.Storage) object.Object {
	return object.Function{
			parameters: node.parameters,
			body: node.body,
		}
}

fn eval_function_call(node ast.FunctionCall, mut storage object.Storage) object.Object {
	mut function := eval(node.function, mut storage)
	if function is object.RuntimeError {
		return function
	}
	mut args := eval_expressions(node.arguments, mut storage)
	if args.len == 1 && args[0] is object.RuntimeError {
		return args[0]
	}
	return apply_function(function, args, mut storage)
}

fn apply_function(func object.Object, args []object.Object, mut storage object.Storage) object.Object {
	match func {
		object.Function {
			mut extended_env := extend_function_env(func, args, mut storage)
			// save the current environment
			mut current_env := storage.env
			// change environment
			storage.env = extended_env
			mut evaluated := eval(func.body, mut storage)
			// restore environment
			storage.env = current_env
			// return value
			/*
			if res is object.ReturnStatement {
				return res.value
			}
			*/
			return evaluated
		}
		else { return object.RuntimeError{message: "not a function"} }
	}
}

fn extend_function_env(func object.Function, args[]object.Object, mut storage object.Storage) &object.Environment {
	mut new_env := object.new_enclosed_environment(mut storage)
	// save the current environment
	mut current_env := storage.env	
	// change environment from storage.env
	storage.env = new_env
	// evaluate all arguments and save it in the new_env
	for param_idx, param in func.parameters {
		storage.set(param.value, args[param_idx])
	}
	// restore environment
	storage.env = current_env

	return new_env
}