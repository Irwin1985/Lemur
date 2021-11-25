module object

pub struct ReturnStatement {
	pub mut:
		value Object
}

pub fn (mut r ReturnStatement) @type() string {
	return obj_return
}

pub fn (mut r ReturnStatement) inspect() string {
	return r.value.inspect()
}