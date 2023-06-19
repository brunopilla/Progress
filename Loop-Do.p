define variable iContador as integer no-undo.
define variable iTotal    as integer no-undo.

do  iContador = 1 to 5:
    iTotal = iTotal + iContador.
end.
display iTotal label "Total".
