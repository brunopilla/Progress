using progress.Lang.error.
using progress.json.*.
using progress.json.objectModel.*.
using com.totvs.framework.api.*.

{utp/ut-api.i} 
{utp/ut-api-action.i pi-find get /~*/~* }
{utp/ut-api-action.i pi-list get /~* }
{utp/ut-api-action.i pi-create post /~* } 
{utp/ut-api-action.i pi-update put /~*/~* } 
{utp/ut-api-action.i pi-delete delete /~*/~* } 
{utp/ut-api-notfound.i}
{method/dbotterr.i}
{cstp/api/v1/services/bocst0197.i ttAgendamento}

define variable boHandler as handle no-undo.

/*
ASSIGN queryParams = jsonInput:GetJsonObject("queryParams")
           codEmitente = INT(queryParams:GetJsonArray("codEmitente"):getCharacter(1)).
           
           if oQueryParams:has("cidade")
           oQueryParams:GetJsonArray("cidade")
           
        queryParams ex:   {"codUser":["cod01","cod02","cod03"]}
*/
  
/*********************************** PESQUISAR AGENDAMENTO ***********************************************/
procedure pi-find:
    define input  param oReq    as JsonObject           no-undo.
    define output param oRes    as JsonObject           no-undo.
    define variable aJsonArray  as JsonArray            no-undo.
    define variable oPathParam  as integer              no-undo.
    define variable oQueryParam as JsonObject           no-undo.
    define variable msg         as JsonObject           no-undo.
    define variable msgArray    as JsonArray            no-undo.
    define variable oRequest    as JsonAPIRequestParser no-undo.
    define variable cFieldList  as character            no-undo.
    define variable i           as integer              no-undo.
    define variable aArrayList  as JsonArray            no-undo.
    
    assign 
        oRequest    = new JsonAPIRequestParser(oReq)
        oPathParam  = integer(oRequest:getPathParams():GetCharacter(1))
        oQueryParam = new JsonObject()
        oQueryParam = oRequest:getQueryParams()
        aArrayList  = new JsonArray().
        
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.
   
    if oQueryParam:has("fields") then do:

        msg      = new JsonObject().
        msg:add("ErrorHelp", "N«O FAI‚!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "HAS FIELDS!").
        msg:add("ErrorSubType", "error").
       
        assign oRes = JsonApiResponseBuilder:ok(msg, 404).
        return.




        aArrayList = oQueryParam:GetJsonArray("fields").
        do i = 1 to length(aArrayList):
            if i > 1 then cFieldList = cFieldList + " ".
            cFieldList = cFieldList + aArrayList:GetJsonText(i).
        end.

        run setQueryFieldList in boHandler (input cFieldList).
        run openQueryDynamic  in boHandler.
    end.
    else do:

       
        assign oRes = JsonApiResponseBuilder:ok(oQueryParam, 200).
        return.

        run openQueryStatic in boHandler (input "Main":U).
    end.
    
    run emptyRowErrors  in boHandler.
    run getRowErrors    in boHandler (output table RowErrors append).
    run goToKey         in boHandler (input oPathParam).

    if upper(return-value) = "OK":U then do:
        run getRecord in boHandler (output table ttAgendamento).
        assign 
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttAgendamento:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, false).
        return.
    end.
    else do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Agendamento " + string(oPathParam) + " n∆o encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Agendamento n∆o encontrado!").
        msg:add("ErrorSubType", "error").
        msgArray:Add(msg).
        assign oRes = JsonApiResponseBuilder:asError(msgArray, 404).
        
        if valid-handle(boHandler) then
            run destroy in boHandler.
        return.
    end.

    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        assign 
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttAgendamento:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, false).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally.
end procedure.

/************************************* LISTAR AGENDAMENTOS ************************************************/
procedure pi-list:
    define input  param oReq      as JsonObject           no-undo.
    define output param oRes      as JsonObject           no-undo.
    define variable aJsonArray    as JsonArray            no-undo.
    define variable rId           as rowid                no-undo.
    define variable iReturnedRows as integer              no-undo.
    define variable oQueryParam   as JsonObject           no-undo.
    define variable iStartRow     as integer              no-undo.
    define variable iPageSize     as integer              no-undo.
    define variable oRequest      as JsonAPIRequestParser no-undo.
    

    assign
        iStartRow   = oRequest:getStartRow()
        iPageSize   = oRequest:getPageSize()
        oQueryParam = oRequest:getQueryParams().



    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run getRowid        in boHandler (output rId).
   
    run getBatchRecords in boHandler( 
        input  rId, //parÉmetro de entrada, que indica o rowid a ser reposicionado para o in°cio da leitura
        input  no, //parÉmetro de entrada, que indica se a leitura deve ser feita a partir do pr¢ximo registro
        input  iPageSize, //parÉmetro de entrada, que indica o n£mero de registros a serem retornados;
        output iReturnedRows, //parÉmetro de sa°da, que indica o n£mero de registros retornados
        output table ttAgendamento //parÉmetro de entrada, que contÇm o handle da temp-table onde ser∆o retornados os registros
        ). 
     
    run getRowErrors in boHandler (output table RowErrors append).

    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        assign
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttAgendamento:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, false).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 

end procedure.

/*********************************** CADASTRAR AGENDAMENTO ***********************************************/
procedure pi-create:
    define input  param oReq as JsonObject            no-undo.
    define output param oRes as JsonObject            no-undo.

    define variable oRequest as JsonAPIRequestParser  no-undo.
    define variable oPayload as JsonObject            no-undo.
    define variable msg      as JsonObject            no-undo.
    define variable pType    as char initial "Create" no-undo.
    
    assign 
        oRequest = new JsonAPIRequestParser(oReq)
        oPayload = oRequest:getPayload().
    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    
    create ttAgendamento.

    ttAgendamento.agendamento_id = next-value(seq_agendam_veic).
    
    find first ttAgendamento no-lock no-error.
    
    if oPayload:has('placa':U) then do:
        ttAgendamento.placa = oPayload:getCharacter('placa').
    end.
    if oPayload:has('condutor':U) then do:
        ttAgendamento.condutor = oPayload:getInteger('condutor').
    end.
    if oPayload:has('prev_data_inic':U) then do:
        ttAgendamento.prev_data_inic = oPayload:getDate('prev_data_inic').
    end.
    if oPayload:has('prev_hora_inic':U) then do:
        ttAgendamento.prev_hora_inic = oPayload:getCharacter('prev_hora_inic').
    end.
    if oPayload:has('prev_data_fin':U) then do:
        ttAgendamento.prev_data_fin = oPayload:getDate('prev_data_fin').
    end.
    if oPayload:has('prev_hora_fin':U) then do:
        ttAgendamento.prev_hora_fin = oPayload:getCharacter('prev_hora_fin').
    end.
    if oPayload:has('destino':U) then do:
        ttAgendamento.destino = oPayload:getCharacter('destino').
    end.
    if oPayload:has('motivo':U) then do:
        ttAgendamento.motivo = oPayload:getCharacter('motivo').
    end.
    
    run setRecord      in boHandler (input table ttAgendamento).
    run validateRecord in boHandler (input pType).
    run createRecord   in boHandler.
    run getRowErrors   in boHandler (output table RowErrors append).

    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        msg = new JSONObject().
        msg:add("code", 2).
        msg:add("message", "Agendamento Cadastrado!").
        msg:add("detailedMessage", "Agendamento " + string(ttAgendamento.agendamento_id)  + " cadastrado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(msg, 201).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
    
end procedure.
 
/*********************************** ATUALIZAR AGENDAMENTO ***********************************************/
procedure pi-update:
    define input  param oReq  as JsonObject            no-undo.                                                                   
    define output param oRes  as JsonObject            no-undo.                                                                   
                                                                                                                                  
    define variable oRequest  as JsonAPIRequestParser  no-undo.                                                                   
    define variable oPayload  as JsonObject            no-undo.                                                                   
    define variable msg       as JsonObject            no-undo.
    define variable msgArray  as JsonArray             no-undo.
    define variable pType     as char initial "Update" no-undo.                                                                   
    define variable oPathParam as character             no-undo.                                                                   
                                                                                                                                  
    assign 
        oRequest  = new JsonAPIRequestParser(oReq)                                                                            
        oPayload  = oRequest:getPayload()                                                                                     
        oPathParam = oRequest:getPathParams():GetCharacter(1).                                                          
                                                                                                                                  
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.                                                                
    
    run openQueryStatic in boHandler (input "Main":U).                                                                        
    run emptyRowErrors  in boHandler.                                                                                              
    run goToKey         in boHandler (input oPathParam).                                                                                   
                                                                                                                                  
    if return-value = "NOK" then do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Agendamento " + oPathParam  + " n∆o encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Agendamento n∆o encontrado!").
        msg:add("ErrorSubType", "error").
        msgArray:Add(msg).
        assign oRes = JsonApiResponseBuilder:asError(msgArray, 404).
        
        if valid-handle(boHandler) then
            run destroy in boHandler.
        return.                                                                                                               
    end.                                                                                                                          
                                                                                                                                  
    run getRecord in boHandler (output table ttAgendamento).

    find first ttAgendamento no-lock no-error.

    if oPayload:has('placa':U) then do:
        ttAgendamento.placa = oPayload:getCharacter('placa').
    end.
    if oPayload:has('condutor':U) then do:
        ttAgendamento.condutor = oPayload:getInteger('condutor').
    end.
    if oPayload:has('prev_data_inic':U) then do:
        ttAgendamento.prev_data_inic = oPayload:getDate('prev_data_inic').
    end.
    if oPayload:has('prev_hora_inic':U) then do:
        ttAgendamento.prev_hora_inic = oPayload:getCharacter('prev_hora_inic').
    end.
    if oPayload:has('prev_data_fin':U) then do:
        ttAgendamento.prev_data_fin = oPayload:getDate('prev_data_fin').
    end.
    if oPayload:has('prev_hora_fin':U) then do:
        ttAgendamento.prev_hora_fin = oPayload:getCharacter('prev_hora_fin').
    end.
    if oPayload:has('destino':U) then do:
        ttAgendamento.destino = oPayload:getCharacter('destino').
    end.
    if oPayload:has('motivo':U) then do:
        ttAgendamento.motivo = oPayload:getCharacter('motivo').
    end.
    
    run setRecord      in boHandler (input table ttAgendamento).
    run validateRecord in boHandler (input pType).
    run updateRecord   in boHandler.
    run getRowErrors   in boHandler (output table RowErrors append).

    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        msg = new JSONObject().
        msg:add("code", 3).
        msg:add("message", "Agendamento Atualizado!").
        msg:add("detailedMessage", "Agendamento " + string(ttAgendamento.agendamento_id)  + " atualizado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(msg, 200). 
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
end procedure.

/*********************************** ELIMINAR AGENDAMENTO ***********************************************/
procedure pi-delete:
    define input  param oReq   as JsonObject           no-undo.
    define output param oRes   as JsonObject           no-undo.
    define variable aJsonArray as JsonArray            no-undo.
    define variable oPathParam  as character            no-undo.
    define variable msg        as JsonObject           no-undo.
    define variable msgArray   as JsonArray            no-undo.
    define variable oRequest   as JsonAPIRequestParser no-undo.
    
    assign 
        oRequest  = new JsonAPIRequestParser(oReq)
        oPathParam = oRequest:getPathParams():GetCharacter(1).

    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run goToKey         in boHandler (input oPathParam).
    
    if return-value = "OK" then do:
        run deleteRecord in boHandler.
        run getRowErrors in boHandler (output table RowErrors append).   
    end.
    else do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Agendamento " + oPathParam  + " n∆o encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Agendamento n∆o encontrado!").
        msg:add("ErrorSubType", "error").
        msgArray:Add(msg).
        assign oRes = JsonApiResponseBuilder:asError(msgArray, 404).
        
        if valid-handle(boHandler) then
            run destroy in boHandler.
        return.
    end.
    
    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        assign oRes = JsonApiResponseBuilder:empty(204).   
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally.
end procedure.

