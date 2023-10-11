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
{cstp/api/v1/services/bocst0200.i ttChecklist}

define variable boHandler as handle no-undo.
  
/*****************************************************************************
                            PESQUISAR CHECKLIST
******************************************************************************/
procedure pi-find:
    define input  param oReq     as JsonObject           no-undo.
    define output param oRes     as JsonObject           no-undo.
    define variable aJsonArray   as JsonArray            no-undo.
    define variable cAgendamento as integer              no-undo.
    define variable cTipo        as integer              no-undo.
    define variable msg          as JsonObject           no-undo.
    define variable msgArray     as JsonArray            no-undo.
    define variable oRequest     as JsonAPIRequestParser no-undo.
    
    assign
        oRequest     = new JsonAPIRequestParser(oReq)
        cAgendamento = integer(oRequest:getPathParams():GetCharacter(1))
        cTipo        = integer(oRequest:getPathParams():GetCharacter(2)).
    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0200.p persistent set boHandler.
    end.
   
    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run getRowErrors    in boHandler (output table RowErrors append).
    run goToKey         in boHandler (input cAgendamento, input cTipo).

    if upper(return-value) = "OK":U then do:
        run getRecord in boHandler (output table ttChecklist).
        assign 
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttChecklist:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, false).
        return.
    end.
    else do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Checklist nÆo encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Checklist nÆo encontrado!").
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
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttChecklist:handle)
            oRes = JsonApiResponseBuilder:ok(aJsonArray, false).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally.
end procedure.

/*****************************************************************************
                            LISTAR CHECKLISTS
******************************************************************************/
procedure pi-list:
    define input  param oReq      as JsonObject           no-undo.
    define output param oRes      as JsonObject           no-undo.
    define variable aJsonArray    as JsonArray            no-undo.
    define variable rId           as rowid                no-undo.
    define variable iReturnedRows as integer              no-undo.
    define variable iStartRow     as integer              no-undo.
    define variable iContIni      as integer              no-undo.
    define variable iContFin      as integer              no-undo.
    define variable hasNext       as logical initial true no-undo.
    define variable hasFirst      as logical initial true no-undo.
    define variable iPageSize     as integer              no-undo.
    define variable iPage         as integer              no-undo.
    define variable oRequest      as JsonAPIRequestParser no-undo.

    assign
        orequest     = new JsonAPIRequestParser(oReq)
        iStartRow    = oRequest:getStartRow()
        iPageSize    = oRequest:getPageSize()
        iPage        = oRequest:getPage().
    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0200.p persistent set boHandler.
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
        run getRowid        in boHandler (output rId).
        run getBatchRecords in boHandler( 
            input rId,//parƒmetro de entrada, que indica o rowid a ser reposicionado para o in¡cio da leitura
            input no, //parƒmetro de entrada, que indica se a leitura deve ser feita a partir do pr¢ximo registro
            input iPageSize, //parƒmetro de entrada, que indica o n£mero de registros a serem retornados;
            output iReturnedRows, //parƒmetro de sa¡da, que indica o n£mero de registros retornados
            output table ttChecklist //parƒmetro de entrada, que cont‚m o handle da temp-table onde serÆo retornados os registros
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
    else do :
        assign
            aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttChecklist:handle)
            oRes       = JsonApiResponseBuilder:ok(aJsonArray, hasNext).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 

end procedure.

/*****************************************************************************
                            CADASTRAR CHECKLIST
******************************************************************************/
procedure pi-create:
    define input  param oReq  as JsonObject            no-undo.
    define output param oRes  as JsonObject            no-undo.
    define variable oRequest  as JsonAPIRequestParser  no-undo.
    define variable oPayload  as JsonObject            no-undo.
    define variable msg       as JsonObject            no-undo.
    define variable pType     as char initial "Create" no-undo.
    
    assign 
        oRequest = new JsonAPIRequestParser(oReq)
        oPayload = oRequest:getPayload().
    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0200.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    create ttChecklist.
    
    find first ttChecklist no-lock no-error.
    
    if oPayload:has('agendamento_id':U) then do:
        ttChecklist.agendamento_id = oPayload:getInteger('agendamento_id').
    end.
    if oPayload:has('tipo':U) then do:
        ttChecklist.tipo = oPayload:getInteger('tipo').
    end.
    if oPayload:has('avaliador':U) then do:
        ttChecklist.avaliador = oPayload:getInteger('avaliador').
    end.
    if oPayload:has('dt_checklist':U) then do:
        ttChecklist.dt_checklist = oPayload:getDate('dt_checklist').
    end.
    if oPayload:has('hr_checklist':U) then do:
        ttChecklist.hr_checklist = oPayload:getCharacter('hr_checklist').
    end.
    if oPayload:has('km':U) then do:
        ttChecklist.km = oPayload:getInteger('km').
    end.
    if oPayload:has('observacoes':U) then do:
        ttChecklist.observacoes = oPayload:getCharacter('observacoes').
    end.
    if oPayload:has('limp_ext':U) then do:
        ttChecklist.limp_ext = oPayload:getInteger('limp_ext').
    end.
    if oPayload:has('limp_int':U) then do:
        ttChecklist.limp_int = oPayload:getInteger('limp_int').
    end.
    if oPayload:has('pneus':U) then do:
        ttChecklist.pneus = oPayload:getInteger('pneus').
    end.
    if oPayload:has('estepe':U) then do:
        ttChecklist.estepe = oPayload:getInteger('estepe').
    end.
    if oPayload:has('pintura':U) then do:
        ttChecklist.pintura = oPayload:getInteger('pintura').
    end.
    if oPayload:has('lataria':U) then do:
        ttChecklist.lataria = oPayload:getInteger('lataria').
    end.
    if oPayload:has('parachoque_diant':U) then do:
        ttChecklist.parachoque_diant = oPayload:getInteger('parachoque_diant').
    end.
    if oPayload:has('parachoque_tras':U) then do:
        ttChecklist.parachoque_tras = oPayload:getInteger('parachoque_tras').
    end.
    if oPayload:has('farol_alto':U) then do:
        ttChecklist.farol_alto = oPayload:getInteger('farol_alto').
    end.
    if oPayload:has('farol_baixo':U) then do:
        ttChecklist.farol_baixo = oPayload:getInteger('farol_baixo').
    end.
    if oPayload:has('setas':U) then do:
        ttChecklist.setas = oPayload:getInteger('setas').
    end.
    if oPayload:has('luz_re':U) then do:
        ttChecklist.luz_re = oPayload:getInteger('luz_re').
    end.
    if oPayload:has('agua_limp':U) then do:
        ttChecklist.agua_limp = oPayload:getInteger('agua_limp').
    end.
    if oPayload:has('agua_rad':U) then do:
        ttChecklist.agua_rad = oPayload:getInteger('agua_rad').
    end.
    if oPayload:has('embreagem':U) then do:
        ttChecklist.embreagem = oPayload:getInteger('embreagem').
    end.
    if oPayload:has('cambio':U) then do:
        ttChecklist.cambio = oPayload:getInteger('cambio').
    end.
    if oPayload:has('freio':U) then do:
        ttChecklist.freio = oPayload:getInteger('freio').
    end.
    if oPayload:has('oleo_freio':U) then do:
        ttChecklist.oleo_freio = oPayload:getInteger('oleo_freio').
    end.
    if oPayload:has('oleo_motor':U) then do:
        ttChecklist.oleo_motor = oPayload:getInteger('oleo_motor').
    end.
    if oPayload:has('combustivel':U) then do:
        ttChecklist.combustivel = oPayload:getInteger('combustivel').
    end.
    if oPayload:has('parabrisa':U) then do:
        ttChecklist.parabrisa = oPayload:getInteger('parabrisa').
    end.
    if oPayload:has('alarme':U) then do:
        ttChecklist.alarme = oPayload:getInteger('alarme').
    end.
    if oPayload:has('buzina':U) then do:
        ttChecklist.buzina = oPayload:getInteger('buzina').
    end.
    if oPayload:has('cintos':U) then do:
        ttChecklist.cintos = oPayload:getInteger('cintos').
    end.
    if oPayload:has('documentos':U) then do:
        ttChecklist.documentos = oPayload:getInteger('documentos').
    end.
    if oPayload:has('extintor':U) then do:
        ttChecklist.extintor = oPayload:getInteger('extintor').
    end.
    if oPayload:has('limpadores':U) then do:
        ttChecklist.limpadores = oPayload:getInteger('limpadores').
    end.
    if oPayload:has('macaco':U) then do:
        ttChecklist.macaco = oPayload:getInteger('macaco').
    end.
    if oPayload:has('chave_roda':U) then do:
        ttChecklist.chave_roda = oPayload:getInteger('chave_roda').
    end.
    if oPayload:has('retrov_ext':U) then do:
        ttChecklist.retrov_ext = oPayload:getInteger('retrov_ext').
    end.
    if oPayload:has('retrov_int':U) then do:
        ttChecklist.retrov_int = oPayload:getInteger('retrov_int').         
    end.

    run setRecord      in boHandler (input table ttChecklist).
    run validateRecord in boHandler (input pType).
    run createRecord   in boHandler.
    run getRowErrors   in boHandler (output table RowErrors append).

    if valid-handle(boHandler) then
        run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        msg = new JsonObject().
        msg:add("code", 2).
        msg:add("message", "Checklist Cadastrado!").
        msg:add("detailedMessage", "Checklist cadastrado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(msg, 201).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
    
end procedure.
 
/*****************************************************************************
                            ATUALIZAR CHECKLIST
******************************************************************************/
procedure pi-update:
    define input  param oReq     as JsonObject            no-undo.                                                                   
    define output param oRes     as JsonObject            no-undo.                                                                   
    define variable oRequest     as JsonAPIRequestParser  no-undo.                                                                   
    define variable oPayload     as JsonObject            no-undo.                                                                   
    define variable msg          as JsonObject            no-undo.
    define variable msgArray     as JsonArray             no-undo.
    define variable pType        as char initial "Update" no-undo.                                                                   
    define variable cAgendamento as integer               no-undo.
    define variable cTipo        as integer               no-undo.                                                                   
                                                                                                                                  
    assign
        oRequest     = new JsonAPIRequestParser(oReq)                                                                            
        oPayload     = oRequest:getPayload()                                                                                     
        cAgendamento = integer(oRequest:getPathParams():GetCharacter(1))
        cTipo        = integer(oRequest:getPathParams():GetCharacter(2)).                                                          
                                                                                                                                  
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0200.p persistent set boHandler.
    end.                                                                
    
    run openQueryStatic in boHandler (input "Main":U).                                                                        
    run emptyRowErrors  in boHandler.                                                                                              
    run goToKey         in boHandler (input cAgendamento, input cTipo).                                                                                   
                                                                                                                                  
    if return-value = "NOK" then do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Checklist nÆo encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Checklist nÆo encontrado!").
        msg:add("ErrorSubType", "error").
        msgArray:Add(msg).
        assign oRes = JsonApiResponseBuilder:asError(msgArray, 404).
        
        if valid-handle(boHandler) then
            run destroy in boHandler.
        return.                                                                                                               
    end.                                                                                                                          
                                                                                                                                  
    run getRecord in boHandler (output table ttChecklist).

    find first ttChecklist no-lock no-error.

    if oPayload:has('avaliador':U) then do:
        ttChecklist.avaliador = oPayload:getInteger('avaliador').
    end.
    if oPayload:has('dt_checklist':U) then do:
        ttChecklist.dt_checklist = oPayload:getDate('dt_checklist').
    end.
    if oPayload:has('hr_checklist':U) then do:
        ttChecklist.hr_checklist = oPayload:getCharacter('hr_checklist').
    end.
    if oPayload:has('km':U) then do:
        ttChecklist.km = oPayload:getInteger('km').
    end.
    if oPayload:has('observacoes':U) then do:
        ttChecklist.observacoes = oPayload:getCharacter('observacoes').
    end.
    if oPayload:has('limp_ext':U) then do:
        ttChecklist.limp_ext = oPayload:getInteger('limp_ext').
    end.
    if oPayload:has('limp_int':U) then do:
        ttChecklist.limp_int = oPayload:getInteger('limp_int').
    end.
    if oPayload:has('pneus':U) then do:
        ttChecklist.pneus = oPayload:getInteger('pneus').
    end.
    if oPayload:has('estepe':U) then do:
        ttChecklist.estepe = oPayload:getInteger('estepe').
    end.
    if oPayload:has('pintura':U) then do:
        ttChecklist.pintura = oPayload:getInteger('pintura').
    end.
    if oPayload:has('lataria':U) then do:
        ttChecklist.lataria = oPayload:getInteger('lataria').
    end.
    if oPayload:has('parachoque_diant':U) then do:
        ttChecklist.parachoque_diant = oPayload:getInteger('parachoque_diant').
    end.
    if oPayload:has('parachoque_tras':U) then do:
        ttChecklist.parachoque_tras = oPayload:getInteger('parachoque_tras').
    end.
    if oPayload:has('farol_alto':U) then do:
        ttChecklist.farol_alto = oPayload:getInteger('farol_alto').
    end.
    if oPayload:has('farol_baixo':U) then do:
        ttChecklist.farol_baixo = oPayload:getInteger('farol_baixo').
    end.
    if oPayload:has('setas':U) then do:
        ttChecklist.setas = oPayload:getInteger('setas').
    end.
    if oPayload:has('luz_re':U) then do:
        ttChecklist.luz_re = oPayload:getInteger('luz_re').
    end.
    if oPayload:has('agua_limp':U) then do:
        ttChecklist.agua_limp = oPayload:getInteger('agua_limp').
    end.
    if oPayload:has('agua_rad':U) then do:
        ttChecklist.agua_rad = oPayload:getInteger('agua_rad').
    end.
    if oPayload:has('embreagem':U) then do:
        ttChecklist.embreagem = oPayload:getInteger('embreagem').
    end.
    if oPayload:has('cambio':U) then do:
        ttChecklist.cambio = oPayload:getInteger('cambio').
    end.
    if oPayload:has('freio':U) then do:
        ttChecklist.freio = oPayload:getInteger('freio').
    end.
    if oPayload:has('oleo_freio':U) then do:
        ttChecklist.oleo_freio = oPayload:getInteger('oleo_freio').
    end.
    if oPayload:has('oleo_motor':U) then do:
        ttChecklist.oleo_motor = oPayload:getInteger('oleo_motor').
    end.
    if oPayload:has('combustivel':U) then do:
        ttChecklist.combustivel = oPayload:getInteger('combustivel').
    end.
    if oPayload:has('parabrisa':U) then do:
        ttChecklist.parabrisa = oPayload:getInteger('parabrisa').
    end.
    if oPayload:has('alarme':U) then do:
        ttChecklist.alarme = oPayload:getInteger('alarme').
    end.
    if oPayload:has('buzina':U) then do:
        ttChecklist.buzina = oPayload:getInteger('buzina').
    end.
    if oPayload:has('cintos':U) then do:
        ttChecklist.cintos = oPayload:getInteger('cintos').
    end.
    if oPayload:has('documentos':U) then do:
        ttChecklist.documentos = oPayload:getInteger('documentos').
    end.
    if oPayload:has('extintor':U) then do:
        ttChecklist.extintor = oPayload:getInteger('extintor').
    end.
    if oPayload:has('limpadores':U) then do:
        ttChecklist.limpadores = oPayload:getInteger('limpadores').
    end.
    if oPayload:has('macaco':U) then do:
        ttChecklist.macaco = oPayload:getInteger('macaco').
    end.
    if oPayload:has('chave_roda':U) then do:
        ttChecklist.chave_roda = oPayload:getInteger('chave_roda').
    end.
    if oPayload:has('retrov_ext':U) then do:
        ttChecklist.retrov_ext = oPayload:getInteger('retrov_ext').
    end.
    if oPayload:has('retrov_int':U) then do:
        ttChecklist.retrov_int = oPayload:getInteger('retrov_int').         
    end.

    run setRecord      in boHandler (input table ttChecklist).
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
        msg:add("message", "Checklist Atualizado!").
        msg:add("detailedMessage", "Checklist atualizado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(msg, 200). 
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
end procedure.

/*****************************************************************************
                            ELIMINAR CHECKLIST
******************************************************************************/
procedure pi-delete:
    define input  param oReq     as JsonObject           no-undo.
    define output param oRes     as JsonObject           no-undo.
    define variable aJsonArray   as JsonArray            no-undo.
    define variable cAgendamento as integer              no-undo.
    define variable cTipo        as integer              no-undo.
    define variable msg          as JsonObject           no-undo.
    define variable msgArray     as JsonArray            no-undo.
    define variable oRequest     as JsonAPIRequestParser no-undo.
    
    assign
        oRequest     = new JsonAPIRequestParser(oReq)
        cAgendamento = integer(oRequest:getPathParams():GetCharacter(1))
        cTipo        = integer(oRequest:getPathParams():GetCharacter(2)).

    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/bocst0200.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run goToKey         in boHandler (input cAgendamento , input cTipo).
    
    if return-value = "OK" then do:
        run deleteRecord in boHandler.
        run getRowErrors in boHandler (output table RowErrors append).   
    end.
    else do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Checklist nÆo encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Checklist nÆo encontrado!").
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

