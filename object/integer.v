module object

pub struct Integer {
	pub mut:
		value f64
}

pub fn (i Integer) @type() string {
	return obj_int
}

pub fn (i Integer) inspect() string {
	return i.value.str()
}