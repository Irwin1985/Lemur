module object


pub struct Boolean {
	mut:
		value bool
}

pub fn (b Boolean) @type() string {
	return obj_bool
}

pub fn (b Boolean) inspect() string {
	return b.value.str()
}