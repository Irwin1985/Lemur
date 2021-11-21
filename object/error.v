module object

pub struct RuntimeError {
	pub mut:
		message string
}

fn (mut e RuntimeError) @type() string {
	return obj_error
}

fn (mut e RuntimeError) inspect() string {
	return e.message
}