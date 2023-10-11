using Progress.Json.ObjectModel.*.
using Progress.Json.ObjectModel.ObjectModelParser.
using Progress.Json.ObjectModel.JsonArray.
using Progress.Json.ObjectModel.JsonObject.
using progress.Lang.error.
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

/*****************************************************************************
                          PESQUISAR AGENDAMENTO 
******************************************************************************/
procedure pi-find:
    define input  param oReq     as JsonObject           no-undo.
    define output param oRes     as JsonObject           no-undo. 
    define variable aJsonArray   as JsonArray            no-undo.
    define variable cPathParams  as character            no-undo.
//  define variable oQueryParams as JsonObject           no-undo.
    define variable oMsg         as JsonObject           no-undo.
    define variable aMsgArray    as JsonArray            no-undo.
    define variable cFieldList   as character            no-undo.
    define variable i            as integer              no-undo.
    define variable aArrayList   as JsonArray            no-undo.
    define variable iId          as integer              no-undo.
    DEFINE VARIABLE vAux AS CHARACTER NO-UNDO.
  
    assign
        cPathParams  = oReq:getJsonArray("pathParams"):GetCharacter(1)
       // oQueryParams = new JsonObject()
       // oQueryParams = oReq:getJsonObject("queryParams")
        iId          = integer(cPathParams) 
        aArrayList   = new JsonArray().
        
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.

  /*  if oQueryParams:has("fields") then do:
        assign aArrayList = oQueryParams:GetJsonArray("fields").
        do i = 1 to aArrayList:length:
            if i > 1 then cFieldList = cFieldList + " ".
            cFieldList = cFieldList + aArrayList:GetJsonText(i).
        end.
        run setQueryFieldList in boHandler (input cFieldList).
        run openQueryDynamic  in boHandler.
       end.
    else do:  */
        run openQueryStatic in boHandler (input "Main":U).
   // end.
    
    run emptyRowErrors in boHandler.
    run getRowErrors   in boHandler (output table RowErrors append).
    run goToKey        in boHandler (input iId).

    if upper(return-value) = "OK":U then do:
        run getRecord in boHandler (output table ttAgendamento).
        assign 
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttAgendamento:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, false).
    end.
    else do:
        assign
            aMsgArray = new JsonArray()
            oMsg      = new JsonObject().
        
        oMsg:add("ErrorHelp", "Agendamento " + string(cPathParams) + " nÆo encontrado na base de dados!").
        oMsg:add("ErrorNumber", 1).
        oMsg:add("ErrorDescription", "Agendamento nÆo encontrado!").
        oMsg:add("ErrorSubType", "error").
        aMsgArray:Add(oMsg).
        assign oRes = JsonApiResponseBuilder:asError(aMsgArray, 404).
        
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

/*****************************************************************************
                             LISTAR AGENDAMENTOS 
******************************************************************************/
procedure pi-list:
    define input  param oReq      as JsonObject           no-undo.
    define output param oRes      as JsonObject           no-undo.
    define variable aJsonArray    as JsonArray            no-undo.
    define variable rId           as rowid                no-undo.
    define variable iReturnedRows as integer              no-undo.
    define variable iStartRow     as integer              no-undo.
    define variable iPageSize     as integer              no-undo.
    define variable iPage         as integer              no-undo.    
    define variable oRequest      as JsonAPIRequestParser no-undo.
    define variable iQtd          as integer              no-undo.
    define variable iContIni      as integer              no-undo.
    define variable iContFin      as integer              no-undo.
    define variable hasNext       as logical initial true no-undo.
    define variable hasFirst      as logical initial true no-undo.
   
    assign
        orequest     = new JsonAPIRequestParser(oReq)
        iStartRow    = oRequest:getStartRow()
        iPageSize    = oRequest:getPageSize()
        iPage        = oRequest:getPage().
        
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run getFirst        in boHandler.

    if iStartRow > 1 then do:
        assign iContFin = iStartRow - 1.
        do iContIni = 1 to iContFin:
            run getNext in boHandler.
            if return-value = "NOK":U then do:
                run emptyRowErrors in boHandler.
                assign hasNext  = false.
                if  iStartRow > iContIni then
                    assign hasFirst = false.
                leave.
            end.
        end.
    end.
    
    if hasFirst then do:
        run getRowid in boHandler (output rId).
        run getBatchRecords in boHandler( 
            input  rId, //parƒmetro de entrada, que indica o rowid a ser reposicionado para o in¡cio da leitura
            input  no, //parƒmetro de entrada, que indica se a leitura deve ser feita a partir do pr¢ximo registro
            input  iPageSize, //parƒmetro de entrada, que indica o n£mero de registros a serem retornados;
            output iReturnedRows, //parƒmetro de sa¡da, que indica o n£mero de registros retornados
            output table ttAgendamento //parƒmetro de entrada, que cont‚m o handle da temp-table onde serÆo retornados os registros
        ).
        
        if iReturnedRows < iPageSize then do:
            assign hasNext = false.
        end.
        else do:
            run getFirst in boHandler.
            do iContIni = 1 to (iPage * ipageSize):
                run getNext in boHandler.
                if return-value = "NOK":U then do:
                    run emptyRowErrors in boHandler.
                    assign hasNext = false.
                    leave.
                end.
            end.
        end.
    end.
   
    run getRowErrors in boHandler (output table RowErrors append).
    
    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do:
        assign
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttAgendamento:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, hasNext).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch. 
    
    finally: delete procedure boHandler no-error. end finally. 

end procedure.

/*****************************************************************************
                             CADASTRAR AGENDAMENTO 
******************************************************************************/
procedure pi-create:
    define input  param oReq as JsonObject            no-undo.
    define output param oRes as JsonObject            no-undo.
    define variable oRequest as JsonAPIRequestParser  no-undo.
    define variable oPayload as JsonObject            no-undo.
    define variable oMsg     as JsonObject            no-undo.
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
        oMsg = new JSONObject().
        oMsg:add("code", 2).
        oMsg:add("message", "Agendamento Cadastrado!").
        oMsg:add("detailedMessage", "Agendamento " + string(ttAgendamento.agendamento_id)  + " cadastrado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(oMsg, 201).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
    
end procedure.
 
/*****************************************************************************
                            ATUALIZAR AGENDAMENTO 
******************************************************************************/
procedure pi-update:
    define input  param oReq    as JsonObject            no-undo.                                                                   
    define output param oRes    as JsonObject            no-undo.                                                                   
    define variable oRequest    as JsonAPIRequestParser  no-undo.                                                                   
    define variable oPayload    as JsonObject            no-undo.                                                                   
    define variable oMsg        as JsonObject            no-undo.
    define variable aMsgArray   as JsonArray             no-undo.
    define variable pType       as char initial "Update" no-undo.                                                                   
    define variable cPathParams as character             no-undo.                                                                   
                                                                                                                                  
    assign 
        oRequest  = new JsonAPIRequestParser(oReq)                                                                            
        oPayload  = oRequest:getPayload()                                                                                     
        cPathParams = oRequest:getPathParams():GetCharacter(1).                                                          
                                                                                                                                  
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.                                                                
    
    run openQueryStatic in boHandler (input "Main":U).                                                                        
    run emptyRowErrors  in boHandler.                                                                                              
    run goToKey         in boHandler (input cPathParams).                                                                                   
                                                                                                                                  
    if return-value = "NOK" then do:
        assign
            aMsgArray = new JsonArray()
            oMsg      = new JsonObject().
        
        oMsg:add("ErrorHelp", "Agendamento " + cPathParams  + " nÆo encontrado na base de dados!").
        oMsg:add("ErrorNumber", 1).
        oMsg:add("ErrorDescription", "Agendamento nÆo encontrado!").
        oMsg:add("ErrorSubType", "error").
        aMsgArray:Add(oMsg).
        assign oRes = JsonApiResponseBuilder:asError(aMsgArray, 404).
        
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
        oMsg = new JSONObject().
        oMsg:add("code", 3).
        oMsg:add("message", "Agendamento Atualizado!").
        oMsg:add("detailedMessage", "Agendamento " + string(ttAgendamento.agendamento_id)  + " atualizado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(oMsg, 200). 
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
end procedure.

/*****************************************************************************
                             ELIMINAR AGENDAMENTO 
******************************************************************************/
procedure pi-delete:
    define input  param oReq    as JsonObject           no-undo.
    define output param oRes    as JsonObject           no-undo.
    define variable aJsonArray  as JsonArray            no-undo.
    define variable cPathParams as character            no-undo.
    define variable oMsg        as JsonObject           no-undo.
    define variable aMsgArray   as JsonArray            no-undo.
    define variable oRequest    as JsonAPIRequestParser no-undo.
    
    assign 
        oRequest  = new JsonAPIRequestParser(oReq)
        cPathParams = oRequest:getPathParams():GetCharacter(1).

    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0197.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run goToKey         in boHandler (input cPathParams).
    
    if return-value = "OK" then do:
        run deleteRecord in boHandler.
        run getRowErrors in boHandler (output table RowErrors append).   
    end.
    else do:
        assign
            aMsgArray = new JsonArray()
            oMsg      = new JsonObject().
        
        oMsg:add("ErrorHelp", "Agendamento " + cPathParams  + " nÆo encontrado na base de dados!").
        oMsg:add("ErrorNumber", 1).
        oMsg:add("ErrorDescription", "Agendamento nÆo encontrado!").
        oMsg:add("ErrorSubType", "error").
        aMsgArray:Add(oMsg).
        assign oRes = JsonApiResponseBuilder:asError(aMsgArray, 404).
        
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

