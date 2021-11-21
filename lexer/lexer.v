module lexer

import token { TokenType }

pub struct Lexer {
	debug bool
	input string
	mut:
		position int
		read_position int
		ch byte
}

pub fn new(input string, debug bool) &Lexer {
	mut l := &Lexer {
			input: input,
			debug: debug,
		}
	l.position = 0
	l.read_position = 0
	l.read_char()
	return l
}

pub fn (mut l Lexer) next_token() token.Token {
	mut tok := token.Token{}

	l.skip_whitespace()

	match l.ch {
		`=` {
			if l.peek_char() == `=` {
				ch := l.ch
				l.read_char()
				lexeme := ch.ascii_str() + l.ch.ascii_str()
				tok = token.Token{ category: TokenType.tt_eq, lexeme: lexeme }
			} else {
				tok = new_token(TokenType.tt_assign, l.ch)
			}
		}
		`+` { tok = new_token(TokenType.tt_plus, l.ch) }
		`-` { tok = new_token(TokenType.tt_minus, l.ch) }
		`!` {
			if l.peek_char() == `=` {
				ch := l.ch
				l.read_char()
				lexeme := ch.ascii_str() + l.ch.ascii_str()
				tok = token.Token{ category: TokenType.tt_not_eq, lexeme: lexeme }
			} else {
				tok = new_token(TokenType.tt_assign, l.ch)
			}
		}
		`/` { tok = new_token(TokenType.tt_slash, l.ch) }
		`*` { tok = new_token(TokenType.tt_asterisk, l.ch) }
		`<` { tok = new_token(TokenType.tt_lt, l.ch) }
		`>` { tok = new_token(TokenType.tt_gt, l.ch) }
		`;` { tok = new_token(TokenType.tt_semicolon, l.ch) }
		`:` { tok = new_token(TokenType.tt_colon, l.ch) }
		`,` { tok = new_token(TokenType.tt_comma, l.ch) }
		`{` { tok = new_token(TokenType.tt_lbrace, l.ch) }
		`}` { tok = new_token(TokenType.tt_rbrace, l.ch) }
		`(` { tok = new_token(TokenType.tt_lparen, l.ch) }
		`)` { tok = new_token(TokenType.tt_rparen, l.ch) }
		`"` {
			tok.category = TokenType.tt_string
			tok.lexeme = l.read_string()
		}
		`[` { tok = new_token(TokenType.tt_lbracket, l.ch) }
		`]` { tok = new_token(TokenType.tt_rbracket, l.ch) }
		0 {
			tok.category = TokenType.tt_eof
			tok.lexeme = ""
		}
		else {
			if is_letter(l.ch) {
				tok.lexeme = l.read_identifier()
				tok.category = token.lookup_ident(tok.lexeme)
				l.debug(tok)
				return tok
			} else if is_digit(l.ch) {
				tok.category = TokenType.tt_int
				tok.lexeme = l.read_number()
				l.debug(tok)
				return tok
			} else {
				tok =  new_token(TokenType.tt_illegal, l.ch)
			}
		}
	}
	l.read_char()
	l.debug(tok)
	return tok
}

fn (mut l Lexer) debug(tok token.Token) {
	if l.debug {
		println(tok.to_string())
	}
}

fn (mut l Lexer) skip_whitespace() {
	for is_space(l.ch) {
		l.read_char()
	}
}

fn (mut l Lexer) read_char() {
	if l.read_position >= l.input.len {
		l.ch = 0
	} else {
		l.ch = l.input[l.read_position]
	}
	l.position = l.read_position
	l.read_position += 1
}

fn (mut l Lexer) peek_char() byte {
	if l.read_position >= l.input.len {
		return 0
	}
	return l.input[l.read_position]
}

fn (mut l Lexer) read_identifier() string {
	position := l.position
	for is_letter(l.ch) || is_digit(l.ch) {
		l.read_char()
	}
	return l.input[position..l.position]
}

fn (mut l Lexer) read_number() string {
	position := l.position
	for is_digit(l.ch) {
		l.read_char()
	}
	return l.input[position..l.position]
}

fn (mut l Lexer) read_string() string {
	position := l.position + 1 // +1 para saltarnos el símbolo "
	for {
		l.read_char()
		if l.ch == `"` || l.ch == 0 {
			break
		}
	}
	return l.input[position..l.position]
}

fn is_letter(ch byte) bool {
	return (`a` <= ch && ch <= `z`) || (`A` <= ch && ch <= `Z`) || ch == `_`
}

fn is_digit(ch byte) bool {
	return ch in [`0`,`1`,`2`,`3`,`4`,`5`,`6`,`7`,`8`,`9`]
}

fn is_space(ch byte) bool {
	return ch in [` `, `\t`, `\r`, `\n`]
}

fn new_token(cat TokenType, ch byte) token.Token {
	return token.Token {
		category: cat,
		lexeme: ch.ascii_str(),
	}
}