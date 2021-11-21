module object

const (
	obj_int = "INTEGER"
	obj_str = "STRING"
	obj_bool = "BOOLEAN"
	obj_none = "NONE"
	obj_null = "NULL"
	obj_error = "ERROR"
)

pub interface Object {
	mut:
		@type() string
		inspect() string
}