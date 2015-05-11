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
	verbose     = flag.Bool("verbose", false, "verbose output")
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

	go func() {
		for _, fn := range flag.Args() {
			f, err := os.Open(fn)
			if err != nil {
				fmt.Fprintln(os.Stderr, err)
				os.Exit(-1)
			}
			lex.Add(f)
		}

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
	} else if *printLLVMIR {
		EmitIR(nodesForExec)
	} else if *outputObj == "" {
		Exec(nodesForExec)
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
