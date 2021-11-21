module evaluator
import object

struct Result {
	mut:
		value object.Object
}

fn new_result(value object.Object) &Result {
	return &Result {
		value: value,
	}
}