module object 

pub struct None {

}

pub fn (mut n None) @type() string {
	return obj_none
}

pub fn (mut n None) inspect() string {
	return ""
}