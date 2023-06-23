define variable iContador as integer no-undo.
define variable iTotal    as integer NO-UNDO INITIAL 1.

do  iContador = iTotal to 5:
    iTotal = iTotal + iContador.
end.
display iTotal label "Total".
