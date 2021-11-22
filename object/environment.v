module object

pub struct Empty {}
pub struct Env {
	pub mut:
		store map[string]Object
		outer Environment
}

type Environment = Env | Empty

pub fn new_environment() &Env {
	return &Env{
		store: map[string]Object,
		outer: Empty{},
	}
}

pub fn new_enclosed_environment(mut outer Env) &Env {
	return &Env {
		store: map[string]Object,
		outer: outer,
	}
}

pub fn set(mut e Env, name string, value Object) Object {
	e.store[name] = value
	return value
}

pub fn get(mut e Env, name string) Object {
	if obj := e.store[name] {
		return obj
	} else {
		match e.outer {
			Empty{ return None{} }
			Env { 
				result := get(mut e, name) 
				return result
			}
		}
	}
}