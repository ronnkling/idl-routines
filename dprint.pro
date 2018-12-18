; docformat = 'rst'

;+
; Prints out debugging information for a variable, and
; what scope it is in. 
;
; :Examples:
;    For example, try::
;
;          IDL> a=1
;          IDL> dprint,a
;          $MAIN$       A =        1 
;
; :Params:
;    vars : in, required, type=any
;       variables to print information about
;
; :Keywords:
;    traceback = displays a full traceback
;    blankLine = adds a blank line at the end for the print
;    time = prepends the time to the output string, useful if you have a lot of events coming in and need to tell the order of arrival
;-

pro dprint, p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, $
            p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, $
            p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, $
            p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, $
            traceBack=traceBack, blankLine=blankLine, time=time
            
compile_opt idl2

levels = scope_traceback(/struct)
if keyword_set(time) then print, systime(), ' ', format='(2A,$)' ;added 6-15-2018
if keyword_set(traceback) then begin
  ; print, (levels[0:-2]).routine ;did this first, but
  ;using the out keyword allows us to click in the output log to move to that section of code
  help, /traceback, out=outs
  print, outs[1:-1], /implied
endif else begin
  print, (levels[-2]).routine, ' ', format='(2A,$)'
endelse
for i=0, n_params()-1 do begin
  varname = 'p' + strtrim(i,2)
  ;using implied messed up the output so that it was on separate lines
  print, (scope_varname(scope_varfetch('p' + strtrim(i,2),/enter), level=-1))[0], $
         ' = ', scope_varfetch('p' + strtrim(i,2),/enter);, ' ';, implied=0, format='(4A,$)'
;1-31-2017 added [0] to first param and got rid of the format to that objects could be dprinted
endfor
;2-9-2018 added blankLine
if keyword_set(blankLine) then print,' '

return & end

;{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|

function test::init, input

b=1
;old way
print,'test::init',' b = ',b,' input = ', input
;new way
dprint, b, input

return,1
end

;{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|

pro test__define
void = {test, value:0}
return & end

;{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|{{:|

pro test

a=1
dprint,a
oTest = obj_new('test',!pi)

return & end

            
