/*
CURRENT-WINDOW:WIDTH = 300.

FOR EACH Customer NO-LOCK:
    DISPLAY Customer EXCEPT customer.comments custome.fax customer.email 
        WITH WIDTH 350 STREAM-IO
        //WITH STREAM-IO
        //WITH 1 COLUMN
        .
END.
*/




/*
FOR EACH Customer NO-LOCK:
    DISPLAY Customer.NAME Customer.state.
END.

*/



FOR EACH Customer NO-LOCK:
    MESSAGE Custome.NAME SKIP
            Customer.state
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
