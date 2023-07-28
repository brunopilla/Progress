/*FOR EACH Customer NO-LOCK WHERE customer.state EQ "MA":
    DISPLAY Customer.NAME
            Customer.State.
END.*/

/*
EQ        =
NE        <>
GT        >
LT        <
GE        >=
LE        <=
BEGINS
MATCHES

*/




/*FOR EACH Customer NO-LOCK WHERE customer.state EQ "MA":
    DISPLAY Customer.NAME
            Customer.State.
    FOR EACH Order OF Customer NO-LOCK:
        DISPLAY Order.Ordernum Order.OrderDate Order.OrderStatus Order.PromiseDate Order.ShipDate.
    END.
END.*/

CURRENT-WINDOW:WIDTH = 100.
FOR EACH Customer NO-LOCK WHERE customer.state EQ 'MA':
    DISPLAY Customer.NAME  LABEL "Nome Cliente"
            Customer.State LABEL "Estado" WITH CENTERED.
    FOR EACH Order WHERE Order.CustNum EQ Customer.CustNum NO-LOCK:
        DISPLAY Order.Ordernum    LABEL "No. Pedido" 
                Order.OrderDate   LABEL "Data Pedido"      FORMAT "99/99/9999"
                Order.OrderStatus LABEL "Status Pedido" 
                Order.PromiseDate LABEL "Previsão Entrega" FORMAT "99/99/9999"
                Order.ShipDate    LABEL "Data Entrega"     FORMAT "99/99/9999" WITH CENTERED WIDTH 100.
    END.
END.

