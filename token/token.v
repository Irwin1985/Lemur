module token

pub enum TokenType {
	tt_illegal
	tt_eof
	tt_ident
	tt_int
	tt_string
	tt_assign
	tt_plus
	tt_minus
	tt_bang
	tt_asterisk
	tt_slash
	tt_lt
	tt_gt
	tt_eq
	tt_not_eq
	tt_comma
	tt_semicolon
	tt_colon
	tt_lparen
	tt_rparen
	tt_lbrace
	tt_rbrace
	tt_lbracket
	tt_rbracket
	tt_function
	tt_let
	tt_true
	tt_false
	tt_if
	tt_else
	tt_return
}

pub struct Token {
	pub mut:
		category TokenType
		lexeme string
}

pub fn(t Token) to_string() string {
	return "<$t.category, '$t.lexeme'>"
}

pub fn lookup_ident(ident string) TokenType {
	mut keywords := map[string]TokenType{}
	keywords['fn'] = .tt_function
	keywords['let'] = .tt_let
	keywords['true'] = .tt_true
	keywords['false'] = .tt_false
	keywords['return'] = .tt_return

	return keywords[ident] or { TokenType.tt_ident }
}