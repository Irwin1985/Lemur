module object

const (
	obj_int = "INTEGER"
	obj_str = "STRING"
	obj_bool = "BOOLEAN"
	obj_none = "NONE"
	obj_null = "NULL"
	obj_error = "ERROR"
	obj_function = "FUNCTION"
	obj_return = "RETURN"
)

pub interface Object {
	mut:
		@type() string
		inspect() string
}