Kaleidoscope
============

Go port of [LLVM's Kaleidoscope Tutorial](http://llvm.org/docs/tutorial/LangImpl1.html) using the [go-llvm/llvm](http://github.com/go-llvm/llvm) <sup>[doc](http://godoc.org/github.com/go-llvm/llvm)</sup> bindings.

This is a fully functional clone of the completed tutorial. Currently, I'm refactoring the finished code into ideomatic Go. The lexer and parser are now pretty good. The codegen code, error handling and maybe test integration are what's left. After the refactoring is complete, I will break it back up into chapters and port the text of the tutorial as well.

Other Resources
===============

* [LLVM's Official C++ Kaleidoscope Tutorial](http://llvm.org/docs/tutorial/LangImpl1.html)

* [Rob Pike's *Lexical Scanning in Go*](http://www.youtube.com/watch?v=HxaD_trXwRE) — our lexer is based on the design outlined in this talk.

-- export CGO_CFLAGS="`llvm-config --cflags`"
-- export CGO_CPPFLAGS="`llvm-config --cflags`"
-- export CGO_LDFLAGS="`llvm-config --ldflags` -Wl,-L`llvm-config --libdir` -lLLVM-`llvm-config --version`"

export LLVM_LDFLAGS="-L/usr/local/opt/llvm/lib"
export LLVM_CFLAGS="-I/usr/local/opt/llvm/include"
export LLVM_CPPFLAGS="-I/usr/local/opt/llvm/include"

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CFLAGS="-I/usr/local/opt/llvm/include"
export CPPFLAGS="-I/usr/local/opt/llvm/include -std=c++11"

-- export PATH="/usr/local/Cellar/llvm36/3.6.0/bin:$PATH"



export PATH="/usr/local/Cellar/llvm36/3.6.0/lib/llvm-3.6/bin:$PATH"
export CGO_CPPFLAGS="`llvm-config --cppflags`"
export CGO_CXXFLAGS=-std=c++11
export CGO_LDFLAGS="`llvm-config --ldflags --libs --system-libs all`"
go build -tags byollvm
