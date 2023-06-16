
define variable texto as character.
assign texto = "Powered by Progress".

display substring(texto, 1, 50) format "x(50)".
pause.
assign substring(texto, 12) = "Aprendendo Progress 4GL".
display substring(texto, 1, 50) format "x(50)".
pause.
