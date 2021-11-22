module repl
import os
import lexer
import parser
import evaluator
import object

const prompt = ">> "

pub fn start() {
	// DEBUGING PURPOSE
	debug := false
	// DEBUGING PURPOSE

	/*
	mut env := &object.Env{
		store: map[string]object.Object,
		outer: object.Empty{},
	}
	*/
	mut env := object.new_environment()
	for {
		print(prompt)
		input := os.get_line()
		if input == "exit" { break }
		l := lexer.new(input, debug)
		mut p := parser.new(l)
		program := p.parse_program()
		if p.get_errors().len > 0 {
			print("Parser error: ")
			for _, msg in p.get_errors() {
				println(msg)
			}
			continue
		}

		mut result := evaluator.eval_program(program, mut env)
		println(result.inspect())
	}
}