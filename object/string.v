module object

pub struct String {
	mut:
		value string
}

pub fn (s String) @type() string {
	return obj_str
}

pub fn (s String) inspect() string {
	return s.value
}