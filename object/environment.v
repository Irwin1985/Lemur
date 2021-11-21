module object

pub struct Environment {
	pub mut:
		store map[string]Object
}

pub fn (mut e Environment) set(name string, value Object) Object {
	e.store[name] = value
	return value
}

pub fn (mut e Environment) get(name string) Object {
	if obj := e.store[name] {
		return obj
	} else {
		return None{}
	}
}