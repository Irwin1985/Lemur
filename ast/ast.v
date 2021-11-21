module ast

const (
	node_type_statement = 1
	node_type_expression = 2
	node_type_ast = 3
)

pub interface Node {
	to_string() string
}