
define double @testfunc(double %x, double %y) {
entry:
  %multmp = fmul double %y, 2.000000e+00
  %addtmp = fadd double %x, %multmp
  ret double %addtmp
}

define double @0() {
entry:
  %calltmp = call double @testfunc(double 4.000000e+00, double 1.000000e+01)
  ret double %calltmp
}


declare i32 @puts(i8* nocapture) nounwind

define i32 @main() {
  call double @0()
  ret i32 0
}
