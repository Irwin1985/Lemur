module object

// Controla tanto el environment actual como la pila de environments padres.
pub struct Storage {
	pub mut:
		stack EnvStack
		env Environment
}

pub fn new_storage() &Storage {
	return &Storage{
		stack: EnvStack{},
		env: new_environment(),
	}
}

// Agrega un objeto al environment
pub fn(mut s Storage) set(name string, value Object) Object {
	s.env.store[name] = value
	return value
}

pub fn(mut s Storage) get(name string) Object {
	if result := s.env.store[name] {
		return result
	} else {
		if s.env.outer != 0 { // hay una referencia a un padre?
			mut root := s.env
			s.env = s.stack.get_env(s.env.outer)
			result := s.get(name)
			s.env = root
			return result
		} else {
			return None{}
		}
	}
}