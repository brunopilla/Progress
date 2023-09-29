USING PROGRESS.json.*.
USING PROGRESS.json.objectModel.*.

PROCEDURE pi-user:
    DEFINE INPUT parameter jsonInput AS JsonObject NO-UNDO.
    DEFINE OUTPUT PARAMETER jsonOutput AS JsonArray NO-UNDO.
    DEFINE VARIABLE pathParams AS CHARACTER NO-UNDO.
    DEFINE VARIABLE oJsonObject AS JsonObject NO-UNDO.

    ASSIGN pathParams = JsonInput:GetJsonArray("pathParams"):GetCharacter(1).
    ASSIGN jsonOutput = NEW JSONArray().

    FIND FIRST cst_veiculos
        WHERE cst_veiculos.placa = pathParams NO-LOCK.

    IF AVAIL cst_veiculos THEN DO:
        oJsonObject = NEW JSONObject().
        oJsonObject:ADD("placa", cst_veiculos.placa).
        oJsonObject:ADD("modelo", cst_veiculos.modelo).
        oJsonObject:ADD("ano", cst_veiculos.ano).
        oJsonObject:ADD("cor", cst_veiculos.cor).
        oJsonObject:ADD("renavam", cst_veiculos.renavam).
        oJsonObject:ADD("km", cst_veiculos.km).
        jsonOutput:ADD(oJsonObject).
    end.

END PROCEDURE.

PROCEDURE pi-user-list:
    DEFINE OUTPUT PARAMETER jsonOutput AS JsonArray NO-UNDO.
    DEFINE VARIABLE oJsonObject AS JsonObject NO-UNDO.

    ASSIGN jsonOutput = NEW JSONArray().

    for each cst_veiculos NO-LOCK:
        oJsonObject = NEW JSONObject().
        oJsonObject:ADD("placa", cst_veiculos.placa).
        oJsonObject:ADD("modelo", cst_veiculos.modelo).
        oJsonObject:ADD("ano", cst_veiculos.ano).
        oJsonObject:ADD("cor", cst_veiculos.cor).
        oJsonObject:ADD("renavam", cst_veiculos.renavam).
        oJsonObject:ADD("km", cst_veiculos.km).
        jsonOutput:ADD(oJsonObject).
    end.

END PROCEDURE.
