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

	mut storage := object.new_storage()
	for {
		print(prompt)
		input := os.get_line()
		
		if input.len == 0 { continue}
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

		mut result := evaluator.eval_program(program, mut storage)
		println(result.inspect())
	}
}