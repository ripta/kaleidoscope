
define double @"binary:"(double %x, double %y) {
entry:
  ret double %y
}


define double @"binary>"(double %LHS, double %RHS) {
entry:
  %cmptmp = fcmp olt double %RHS, %LHS
  %booltmp = uitofp i1 %cmptmp to double
  ret double %booltmp
}


define double @"binary|"(double %LHS, double %RHS) {
entry:
  %ifcond = fcmp ueq double %LHS, 0.000000e+00
  br i1 %ifcond, label %else, label %merge

else:                                             ; preds = %entry
  %ifcond5 = fcmp ueq double %RHS, 0.000000e+00
  %. = select i1 %ifcond5, double 0.000000e+00, double 1.000000e+00
  br label %merge

merge:                                            ; preds = %entry, %else
  %iftmp9 = phi double [ %., %else ], [ 1.000000e+00, %entry ]
  ret double %iftmp9
}


define double @unary-(double %v) {
entry:
  %subtmp = fsub double 0.000000e+00, %v
  ret double %subtmp
}


declare double @putchard(double)


define double @printdensity(double %d) {
entry:
  %binop = call double @"binary>"(double %d, double 8.000000e+00)
  %ifcond = fcmp ueq double %binop, 0.000000e+00
  br i1 %ifcond, label %else, label %then

then:                                             ; preds = %entry
  %calltmp = call double @putchard(double 3.200000e+01)
  br label %merge

else:                                             ; preds = %entry
  %binop4 = call double @"binary>"(double %d, double 4.000000e+00)
  %ifcond5 = fcmp ueq double %binop4, 0.000000e+00
  br i1 %ifcond5, label %else7, label %then6

merge:                                            ; preds = %then13, %else14, %then6, %then
  %iftmp19 = phi double [ %calltmp, %then ], [ %calltmp9, %then6 ], [ %calltmp16, %then13 ], [ %calltmp17, %else14 ]
  ret double %iftmp19

then6:                                            ; preds = %else
  %calltmp9 = call double @putchard(double 4.600000e+01)
  br label %merge

else7:                                            ; preds = %else
  %binop11 = call double @"binary>"(double %d, double 2.000000e+00)
  %ifcond12 = fcmp ueq double %binop11, 0.000000e+00
  br i1 %ifcond12, label %else14, label %then13

then13:                                           ; preds = %else7
  %calltmp16 = call double @putchard(double 4.300000e+01)
  br label %merge

else14:                                           ; preds = %else7
  %calltmp17 = call double @putchard(double 4.200000e+01)
  br label %merge
}


define double @mandleconverger(double %real, double %imag, double %iters, double %creal, double %cimag) {
entry:
  %binop = call double @"binary>"(double %iters, double 2.550000e+02)
  %multmp = fmul double %real, %real
  %multmp11 = fmul double %imag, %imag
  %addtmp = fadd double %multmp, %multmp11
  %binop12 = call double @"binary>"(double %addtmp, double 4.000000e+00)
  %binop13 = call double @"binary|"(double %binop, double %binop12)
  %ifcond = fcmp ueq double %binop13, 0.000000e+00
  br i1 %ifcond, label %else, label %merge

else:                                             ; preds = %entry
  %subtmp = fsub double %multmp, %multmp11
  %addtmp22 = fadd double %subtmp, %creal
  %multmp24 = fmul double %real, 2.000000e+00
  %multmp26 = fmul double %multmp24, %imag
  %addtmp28 = fadd double %multmp26, %cimag
  %addtmp30 = fadd double %iters, 1.000000e+00
  %calltmp = call double @mandleconverger(double %addtmp22, double %addtmp28, double %addtmp30, double %creal, double %cimag)
  br label %merge

merge:                                            ; preds = %entry, %else
  %iftmp = phi double [ %calltmp, %else ], [ %iters, %entry ]
  ret double %iftmp
}


define double @mandleconverge(double %real, double %imag) {
entry:
  %calltmp = call double @mandleconverger(double %real, double %imag, double 0.000000e+00, double %real, double %imag)
  ret double %calltmp
}


define double @mandelhelp(double %xmin, double %xmax, double %xstep, double %ymin, double %ymax, double %ystep) {
entry:
  br label %loop

loop:                                             ; preds = %afterloop, %entry
  %y.0 = phi double [ %ymin, %entry ], [ %nextvar24, %afterloop ]
  br label %loop9

loop9:                                            ; preds = %loop9, %loop
  %x.0 = phi double [ %xmin, %loop ], [ %nextvar, %loop9 ]
  %calltmp = call double @mandleconverge(double %x.0, double %y.0)
  %calltmp12 = call double @printdensity(double %calltmp)
  %cmptmp = fcmp olt double %x.0, %xmax
  %nextvar = fadd double %xstep, %x.0
  br i1 %cmptmp, label %loop9, label %afterloop

afterloop:                                        ; preds = %loop9
  %calltmp17 = call double @putchard(double 1.000000e+01)
  %binop = call double @"binary:"(double 0.000000e+00, double %calltmp17)
  %cmptmp21 = fcmp olt double %y.0, %ymax
  %nextvar24 = fadd double %ystep, %y.0
  br i1 %cmptmp21, label %loop, label %afterloop26

afterloop26:                                      ; preds = %afterloop
  ret double 0.000000e+00
}


define double @mandel(double %realstart, double %imagstart, double %realmag, double %imagmag) {
entry:
  %multmp = fmul double %realmag, 7.800000e+01
  %addtmp = fadd double %realstart, %multmp
  %multmp12 = fmul double %imagmag, 4.000000e+01
  %addtmp13 = fadd double %imagstart, %multmp12
  %calltmp = call double @mandelhelp(double %realstart, double %addtmp, double %realmag, double %imagstart, double %addtmp13, double %imagmag)
  ret double %calltmp
}


define double @0() {
entry:
  %unop = call double @unary-(double 2.300000e+00)
  %unop1 = call double @unary-(double 1.300000e+00)
  %calltmp = call double @mandel(double %unop, double %unop1, double 5.000000e-02, double 7.000000e-02)
  ret double %calltmp
}

