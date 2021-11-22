module object

// Array de environments donde uno es el padre de otro.
pub struct EnvStack {
	mut:
		data []Environment
}

pub fn new_env_stack() &EnvStack {
	return &EnvStack{}
}

// Agrega un environment en el array y devuelve su índice
pub fn (mut es EnvStack) set_env(env Environment) int {
	i := es.data.len + 1
	es.data << env
	return i
}

// Devuelve el environment según su índice.
pub fn (mut es EnvStack) get_env(i int) Environment {
	return es.data[i-1]
}