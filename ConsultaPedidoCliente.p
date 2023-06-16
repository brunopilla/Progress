/* Procedure utilizando o banco de dados sports2000 para exemplificar
 alguns comandos básicos da linguagem: */
define variable cListaMes as character no-undo
    initial "JAN,FEV,MAR,ABR,MAI,JUN,JUL,AGO,SET,OUT,NOV,DEZ".
define variable iDias as integer no-undo.
/* Mostrando cada cliente de New Hampshire: */
for each Customer no-lock where Customer.State = "NH" by Customer.City:
    display 
        Customer.CustNum label "Cod.Cliente"
        Customer.name label "Nome"
        Customer.City label "Cidade" with centered.
/* Mostrando todos os Pedidos de cada Cliente:  */
    if Customer.CreditLimit < (2 * Customer.Balance) then
        display "Credit Ratio:" Customer.CreditLimit / Customer.Balance.
    else
    for each order of Customer no-lock:
        display
            Order.OrderNum label "Pedido"
            Order.OrderDate label "Data Pedido"
            Order.ShipDate label "Data Entrega" format "99/99/99" with centered.
/* Mostrando o mês em que a entrega foi efetuada: */
        if Order.ShipDate ne ? then
            display entry(month(Order.ShipDate), cListaMes) label "Mês Entrega".
/* Chamando a procedure calcularDias passando dois parametros de entrada: */
        run calcularDias (input Order.shipDate, Order.orderDate, output iDias).
        display iDias label "Dias" format "zzz9".
    end.
end.
/* Procedure interna para calcular os dias entre o pedido e a entrega: */
procedure calcularDias:
    define input  parameter pdaEntrega as date    no-undo.
    define input  parameter pdaPedido  as date    no-undo.
    define output parameter piDias     as integer no-undo.

    piDias = if pdaEntrega = ? then 0 else pdaEntrega - pdaPedido.
end procedure.
