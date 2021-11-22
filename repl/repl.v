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
	mut children := object.new_enclosed_environment(mut storage)

	// 
	num1 := object.Integer{value: 10}
	num2 := object.Integer{value: 20}
	num3 := object.Integer{value: 30}
	num4 := object.Integer{value: 40}

	storage.set("a", num1)
	storage.set("b", num2)

	storage.env = children

	storage.set("c", num3)
	storage.set("d", num4)
	// 
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