module object

pub struct Environment {
	pub mut:
		store map[string]Object
		outer int // puntero al environment alojado en EnvStack
}

// Crea un environment sin parent
pub fn new_environment() &Environment {
	return &Environment{
		store: map[string]Object,
		outer: 0,
	}
}
// Crea un environment y le agrega de padre 
// al environment contenido en Storage.env
pub fn new_enclosed_environment(mut s Storage) &Environment {
	mut new_env := new_environment()
	new_env.outer = s.stack.set_env(s.env)

	return new_env
}