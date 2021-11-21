module ast
import token

pub struct Binary {
	token token.Token
	pub mut:
		left Node
		op string
		right Node
}

fn (b Binary) to_string() string {
	return "$b.left.to_string() $b.op $b.right.to_string()"
}