package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"

	"llvm.org/llvm/bindings/go/llvm"
)

var (
	batch       = flag.Bool("b", false, "batch (non-interactive) mode")
	optimized   = flag.Bool("opt", true, "add some optimization passes")
	printTokens = flag.Bool("tok", false, "print tokens")
	printAst    = flag.Bool("ast", false, "print abstract syntax tree")
	printLLVMIR = flag.Bool("llvm", false, "print LLVM generated code")
	outputObj   = flag.String("obj", "", "output obj")
)

func main() {
	flag.Parse()

	initExecutionEngine()
	if *optimized {
		Optimize()
	}

	lex := Lex()
	tokens := lex.Tokens()
	if *printTokens {
		tokens = DumpTokens(lex.Tokens())
	}

	// add files for the lexer to lex
	go func() {
		// command line filenames
		for _, fn := range flag.Args() {
			f, err := os.Open(fn)
			if err != nil {
				fmt.Fprintln(os.Stderr, err)
				os.Exit(-1)
			}
			lex.Add(f)
		}

		// stdin
		if !*batch {
			fmt.Printf("ready> ")
			lex.Add(os.Stdin)
		}

		lex.Done()
	}()

	nodes := Parse(tokens)
	nodesForExec := nodes
	if *printAst {
		nodesForExec = DumpTree(nodes)
	}

	if *outputObj == "" {
		Exec(nodesForExec, *printLLVMIR)
	} else {
		buffer, err := machine.EmitToMemoryBuffer(rootModule, llvm.ObjectFile)
		if err != nil {
			fmt.Fprintln(os.Stderr, "Cannot emit object file to memory buffer:")
			fmt.Fprintln(os.Stderr, err)
		}

		fmt.Fprintln(os.Stderr, *outputObj)
		ioutil.WriteFile(*outputObj, buffer.Bytes(), 0644)
	}
}
