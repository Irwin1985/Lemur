module object

pub struct Null {
	
}

pub fn (n Null) @type() string {
	return obj_null
}

pub fn (n Null) inspect() string {
	return "null"
}