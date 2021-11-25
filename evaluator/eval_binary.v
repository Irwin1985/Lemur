module evaluator
import object
import ast

fn eval_binary(node ast.Binary, mut storage object.Storage) object.Object {
	left := eval(node.left, mut storage)
	if left is object.RuntimeError {
		return left
	}
	right := eval(node.right, mut storage)
	if right is object.RuntimeError {
		return right
	}
	
	if left is object.Integer && right is object.Integer {
		match node.op {
			"+" { return object.Integer{value: left.value + right.value} }
			"-" { return object.Integer{value: left.value - right.value} }
			"*" { return object.Integer{value: left.value * right.value} }
			"/" {
				if right.value == 0 {
					return object.RuntimeError{message: "division by zero."}
				}
				return object.Integer{value: left.value / right.value}
			}
			"==" { return object.Boolean{value: left.value == right.value} }
			"!=" { return object.Boolean{value: left.value != right.value} }
			"<"  { return object.Boolean{value: left.value < right.value}  }
			">"  { return object.Boolean{value: left.value > right.value}  }
			else {
				return object.RuntimeError{message: "invalid operand $node.op"}
			}
		}
	} else {
		return object.RuntimeError{message: "invalid operands."}
	}
}