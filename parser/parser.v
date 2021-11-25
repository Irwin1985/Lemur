module parser

import token { TokenType }
import lexer
import ast

type UnaryFn = fn (mut p Parser) &ast.Node

type BinaryFn = fn (mut p Parser, left ast.Node) &ast.Node

const (
	lowest     = 1
	equals     = 2
	comparison = 3
	term       = 4
	factor     = 5
	unary      = 6
	call       = 7
	index      = 8
)

pub struct Parser {
mut:
	l           lexer.Lexer
	cur_token   token.Token
	peek_token  token.Token
	precedences map[TokenType]int
	unary_fns   map[TokenType]UnaryFn
	binary_fns  map[TokenType]BinaryFn
	errors 		[]string
}

pub fn new(l lexer.Lexer) &Parser {
	mut p := &Parser{
		l: l,
		errors: []string{},
	}

	// fill precedence table
	p.precedences[.tt_eq] = parser.equals
	p.precedences[.tt_lt] = parser.comparison
	p.precedences[.tt_gt] = parser.comparison
	p.precedences[.tt_plus] = parser.term
	p.precedences[.tt_minus] = parser.term
	p.precedences[.tt_asterisk] = parser.factor
	p.precedences[.tt_slash] = parser.factor
	p.precedences[.tt_lparen] = parser.call
	p.precedences[.tt_lbracket] = parser.index

	// register unary function tokens (prefix)
	p.register_unary_functions()
	// register binary functions tokens (infix)
	p.register_binary_functions()

	// Read two tokens
	p.next_token()
	p.next_token()
	return p
}

fn (mut p Parser) register_unary_functions() {
	p.unary_fns[.tt_ident] = parse_identifier 	// IDENTIFIERS => foo, bar
	p.unary_fns[.tt_int] = parse_integer		// INTEGERS => 1, 35
	p.unary_fns[.tt_true] = parse_boolean		// BOOLEAN => true
	p.unary_fns[.tt_false] = parse_boolean		// BOOLEAN => false
	p.unary_fns[.tt_string] = parse_string		// STRING => "foo"
	p.unary_fns[.tt_lparen] = parse_grouped_exp // LPAREN exp RPAREN
	p.unary_fns[.tt_function] = parse_function_literal // fun(x, y)
	p.unary_fns[.tt_if] = parse_if_expression // if () else ()
}

fn (mut p Parser) register_binary_functions() {
	p.binary_fns[.tt_plus] = parse_binary
	p.binary_fns[.tt_minus] = parse_binary
	p.binary_fns[.tt_asterisk] = parse_binary
	p.binary_fns[.tt_slash] = parse_binary
	p.binary_fns[.tt_eq] = parse_binary
	p.binary_fns[.tt_not_eq] = parse_binary
	p.binary_fns[.tt_lt] = parse_binary
	p.binary_fns[.tt_gt] = parse_binary
	p.binary_fns[.tt_lparen] = parse_function_call
}

fn (mut p Parser) next_token() {
	p.cur_token = p.peek_token
	p.peek_token = p.l.next_token()
}

fn (mut p Parser) cur_token_is(cat TokenType) bool {
	return p.cur_token.category == cat
}

fn (mut p Parser) cur_precedence() int {
	return p.precedences[p.cur_token.category] or { return lowest }
}

fn (mut p Parser) expect(cat TokenType, msg string) {
	if p.cur_token.category == cat {
		p.next_token()
	} else {
		p.errors << msg
	}
}

pub fn (mut p Parser) get_errors() []string {
	return p.errors
}

fn (mut p Parser) parse_statement() &ast.Node {
	match p.cur_token.category {
		.tt_let { return p.parse_let_statement() }
		.tt_return { return p.parse_return_statement() }
		else { return p.parse_expression_stmt() }
	}
}

fn (mut p Parser) parse_expression(precedence int) &ast.Node {
	prefix := p.unary_fns[p.cur_token.category] or {
		msg := "no prefix parse function for $p.cur_token.category found."
		p.errors << msg
		// advance the ofending token
		p.next_token()
		return ast.None{}
	}

	mut left_exp := prefix(mut p)

	for precedence < p.cur_precedence() {
		infix := p.binary_fns[p.cur_token.category] or {
			return left_exp
		}
		left_exp = infix(mut p, left_exp)
	}

	return left_exp
}

fn (mut p Parser) parse_expression_list(end token.TokenType) []ast.Node {
	mut list := []ast.Node{}
	
	if p.cur_token_is(end) {
		p.next_token()
		return list
	}
	
	list << p.parse_expression(lowest)

	for p.cur_token_is(.tt_comma) {
		p.next_token() // advance comma
		list << p.parse_expression(lowest)
	}
	
	p.expect(end, "expected closing delimiter.")
	return list
}


