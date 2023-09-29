{utp/ut-api.i} // Faz o parser do parâmetro LONGCHAR de entrada e cria um objeto JsonObject chamado jsonInput.
{utp/ut-api-utils.i}
{utp/ut-api-action.i pi-find  GET /~*/~* } //Faz o roteamento do objecto jsonInput para uma procedure interna especificada pelo desenvolvedor.
{utp/ut-api-action.i pi-list  GET /~* }
{utp/ut-api-notfound.i} //Caso nenhuma procedure interna tenha sido encontrada, retorna uma mensagem "Method not found" com HTTP Status 400.

DEFINE VARIABLE h-exemplo-bo AS HANDLE NO-UNDO.

PROCEDURE pi-find:
    DEFINE INPUT  PARAMETER jsonInput  AS JsonObject NO-UNDO.
    DEFINE OUTPUT PARAMETER jsonOutput AS JsonObject NO-UNDO.
    DEFINE VARIABLE aJsonArray AS JsonArray NO-UNDO.

    RUN sec/api/v1/services/exemplo-bo.p PERSISTENT SET h-exemplo-bo.
    RUN pi-user IN h-exemplo-bo (INPUT jsonInput, 
                                 OUTPUT aJsonArray).

   
    ASSIGN jsonOutput = JsonAPIResponseBuilder:OK(aJsonArray, FALSE).
    
    IF VALID-HANDLE (h-exemplo-bo) THEN
        DELETE PROCEDURE h-exemplo-bo.

END PROCEDURE.

PROCEDURE pi-list:
    
    DEF INPUT PARAM jsonInput AS JsonObject NO-UNDO.
    DEF OUTPUT PARAM jsonOutput AS JsonObject NO-UNDO.
    DEFINE VARIABLE aJsonArray AS JsonArray NO-UNDO.

    RUN sec/api/v1/services/exemplo-bo.p PERSISTENT SET h-exemplo-bo.
    RUN pi-user-list IN h-exemplo-bo (OUTPUT aJsonArray).

   
    ASSIGN jsonOutput = JsonAPIResponseBuilder:OK(aJsonArray, FALSE).
    
    IF VALID-HANDLE (h-exemplo-bo) THEN
        DELETE PROCEDURE h-exemplo-bo.
   
END PROCEDURE.
