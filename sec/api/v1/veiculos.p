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
{cstp/api/v1/services/cstbo/bocst0194.i ttVeiculos}

define variable boHandler as handle no-undo.
  
/*********************************** PESQUISAR VE÷CULO ***********************************************/
procedure pi-find:
    define input  param oReq      as JsonObject            no-undo.
    define output param oRes      as JsonObject            no-undo.
    define variable aJsonArray    as JsonArray             no-undo.
    define variable pathParam     as character             no-undo.
    define variable msg           as JsonObject            no-undo.
    define variable msgArray      as JsonArray             no-undo.
    define variable oRequest      as JsonAPIRequestParser  no-undo.
    
    assign oRequest = new JsonAPIRequestParser(oReq).
    assign pathParam = oRequest:getPathParams():GetCharacter(1).
    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/cstbo/bocst0194.p persistent set boHandler.
    end.
   
    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors  in boHandler.
    run getRowErrors    in boHandler (output table RowErrors append).
    run goToKey         in boHandler (input pathParam).

    if upper(return-value) = "OK":U then do:
        run getRecord in boHandler (output table ttVeiculos).
        assign aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttVeiculos:handle).
        assign oRes = JsonApiResponseBuilder:ok(aJsonArray, false).
        return.
    end.
    else do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Ve°culo placa " + pathParam  + " n∆o encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Ve°culo n∆o encontrado!").
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
        assign aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttVeiculos:handle).
        assign oRes = JsonApiResponseBuilder:ok(aJsonArray, false).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally.
end procedure.

/************************************* LISTAR VE÷CULOS ************************************************/
procedure pi-list:
    define input  param oReq      as JsonObject no-undo.
    define output param oRes      as JsonObject no-undo.
    define variable aJsonArray    as JsonArray  no-undo.
    define variable rId           as rowid      no-undo.
    define variable iReturnedRows as integer    no-undo.

    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/cstbo/bocst0194.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors in boHandler.
    run getRowid in boHandler (output rId).
   
    run getBatchRecords in boHandler( 
        input rId,//parÉmetro de entrada, que indica o rowid a ser reposicionado para o in°cio da leitura
        input no, //parÉmetro de entrada, que indica se a leitura deve ser feita a partir do pr¢ximo registro
        input 10, //parÉmetro de entrada, que indica o n£mero de registros a serem retornados;
        output iReturnedRows, //parÉmetro de sa°da, que indica o n£mero de registros retornados
        output table ttVeiculos //parÉmetro de entrada, que contÇm o handle da temp-table onde ser∆o retornados os registros
        ). 
     
    run getRowErrors in boHandler (output table RowErrors append).

    if valid-handle(boHandler) then
    run destroy in boHandler.

    if can-find(first RowErrors where upper(RowErrors.ErrorSubType) = 'ERROR':U) then do:
        assign oRes = JsonApiResponseBuilder:asError(temp-table RowErrors:handle).
    end.
    else do :
        assign aJsonArray = JsonAPIUtils:ConvertTempTableToJsonArray(temp-table ttVeiculos:handle).
        assign oRes = JsonApiResponseBuilder:ok(aJsonArray, false).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 

end procedure.

/*********************************** CADASTRAR VE÷CULO ***********************************************/
procedure pi-create:
    define input  param oReq  as JsonObject            no-undo.
    define output param oRes  as JsonObject            no-undo.

    define variable oRequest  as JsonAPIRequestParser  no-undo.
    define variable oPayload  as JsonObject            no-undo.
    define variable msg       as JsonObject            no-undo.
    define variable pType     as char initial "Create" no-undo.
    
    assign oRequest = new JsonAPIRequestParser(oReq).
    assign oPayload = oRequest:getPayload().
    
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/cstbo/bocst0194.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors in boHandler.
    create ttVeiculos.
    
    find first ttVeiculos no-lock no-error.
    
    if oPayload:has('placa':U) then do:
        ttVeiculos.placa = oPayload:getCharacter('placa').
    end.
    if oPayload:has('modelo':U) then do:
        ttVeiculos.modelo = oPayload:getCharacter('modelo').
    end.
    if oPayload:has('marca':U) then do:
        ttVeiculos.marca = oPayload:getCharacter('marca').
    end.
    if oPayload:has('ano':U) then do:
        ttVeiculos.ano = oPayload:getInteger('ano').
    end.
    if oPayload:has('cor':U) then do:
        ttVeiculos.cor = oPayload:getCharacter('cor').
    end.
    if oPayload:has('renavam':U) then do:
        ttVeiculos.renavam = oPayload:getCharacter('renavam').
    end.
    if oPayload:has('cod_categ_habilit':U) then do:
        ttVeiculos.cod_categ_habilit = oPayload:getCharacter('cod_categ_habilit').
    end.
    if oPayload:has('ativo':U) then do:
        ttVeiculos.ativo = oPayload:getLogical('ativo').
    end.
    if oPayload:has('disponivel':U) then do:
        ttVeiculos.disponivel = oPayload:getLogical('disponivel').
    end.
    if oPayload:has('km':U) then do:
        ttVeiculos.km = oPayload:getInteger('km').
    end.
    if oPayload:has('proprietario':U) then do:
        ttVeiculos.proprietario = oPayload:getCharacter('proprietario').
    end.
    if oPayload:has('observacoes':U) then do:
        ttVeiculos.observacoes = oPayload:getCharacter('observacoes').
    end.
    if oPayload:has('limp_ext':U) then do:
        ttVeiculos.limp_ext = oPayload:getInteger('limp_ext').
    end.
    if oPayload:has('limp_int':U) then do:
        ttVeiculos.limp_int = oPayload:getInteger('limp_int').
    end.
    if oPayload:has('pneus':U) then do:
        ttVeiculos.pneus = oPayload:getInteger('pneus').
    end.
    if oPayload:has('estepe':U) then do:
        ttVeiculos.estepe = oPayload:getInteger('estepe').
    end.
    if oPayload:has('pintura':U) then do:
        ttVeiculos.pintura = oPayload:getInteger('pintura').
    end.
    if oPayload:has('lataria':U) then do:
        ttVeiculos.lataria = oPayload:getInteger('lataria').
    end.
    if oPayload:has('parachoque_diant':U) then do:
        ttVeiculos.parachoque_diant = oPayload:getInteger('parachoque_diant').
    end.
    if oPayload:has('parachoque_tras':U) then do:
        ttVeiculos.parachoque_tras = oPayload:getInteger('parachoque_tras').
    end.
    if oPayload:has('farol_alto':U) then do:
        ttVeiculos.farol_alto = oPayload:getInteger('farol_alto').
    end.
    if oPayload:has('farol_baixo':U) then do:
        ttVeiculos.farol_baixo = oPayload:getInteger('farol_baixo').
    end.
    if oPayload:has('setas':U) then do:
        ttVeiculos.setas = oPayload:getInteger('setas').
    end.
    if oPayload:has('luz_re':U) then do:
        ttVeiculos.luz_re = oPayload:getInteger('luz_re').
    end.
    if oPayload:has('agua_limp':U) then do:
        ttVeiculos.agua_limp = oPayload:getInteger('agua_limp').
    end.
    if oPayload:has('agua_rad':U) then do:
        ttVeiculos.agua_rad = oPayload:getInteger('agua_rad').
    end.
    if oPayload:has('embreagem':U) then do:
        ttVeiculos.embreagem = oPayload:getInteger('embreagem').
    end.
    if oPayload:has('cambio':U) then do:
        ttVeiculos.cambio = oPayload:getInteger('cambio').
    end.
    if oPayload:has('freio':U) then do:
        ttVeiculos.freio = oPayload:getInteger('freio').
    end.
    if oPayload:has('oleo_freio':U) then do:
        ttVeiculos.oleo_freio = oPayload:getInteger('oleo_freio').
    end.
    if oPayload:has('oleo_motor':U) then do:
        ttVeiculos.oleo_motor = oPayload:getInteger('oleo_motor').
    end.
    if oPayload:has('combustivel':U) then do:
        ttVeiculos.combustivel = oPayload:getInteger('combustivel').
    end.
    if oPayload:has('parabrisa':U) then do:
        ttVeiculos.parabrisa = oPayload:getInteger('parabrisa').
    end.
    if oPayload:has('alarme':U) then do:
        ttVeiculos.alarme = oPayload:getInteger('alarme').
    end.
    if oPayload:has('buzina':U) then do:
        ttVeiculos.buzina = oPayload:getInteger('buzina').
    end.
    if oPayload:has('cintos':U) then do:
        ttVeiculos.cintos = oPayload:getInteger('cintos').
    end.
    if oPayload:has('documentos':U) then do:
        ttVeiculos.documentos = oPayload:getInteger('documentos').
    end.
    if oPayload:has('extintor':U) then do:
        ttVeiculos.extintor = oPayload:getInteger('extintor').
    end.
    if oPayload:has('limpadores':U) then do:
        ttVeiculos.limpadores = oPayload:getInteger('limpadores').
    end.
    if oPayload:has('macaco':U) then do:
        ttVeiculos.macaco = oPayload:getInteger('macaco').
    end.
    if oPayload:has('chave_roda':U) then do:
        ttVeiculos.chave_roda = oPayload:getInteger('chave_roda').
    end.
    if oPayload:has('retrov_ext':U) then do:
        ttVeiculos.retrov_ext = oPayload:getInteger('retrov_ext').
    end.
    if oPayload:has('retrov_int':U) then do:
        ttVeiculos.retrov_int = oPayload:getInteger('retrov_int').         
    end.

    run setRecord      in boHandler (input table ttVeiculos).
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
        msg:add("message", "Ve°culo Cadastrado!").
        msg:add("detailedMessage", "Ve°culo " + ttVeiculos.placa  + " cadastrado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(msg, 201).
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
    
end procedure.
 
/*********************************** ATUALIZAR VE÷CULO ***********************************************/
procedure pi-update:
    define input  param oReq  as JsonObject            no-undo.                                                                   
    define output param oRes  as JsonObject            no-undo.                                                                   
                                                                                                                                  
    define variable oRequest  as JsonAPIRequestParser  no-undo.                                                                   
    define variable oPayload  as JsonObject            no-undo.                                                                   
    define variable msg       as JsonObject            no-undo.
    define variable msgArray  as JsonArray             no-undo.
    define variable pType     as char initial "Update" no-undo.                                                                   
    define variable pathParam as character             no-undo.                                                                   
                                                                                                                                  
    assign oRequest  = new JsonAPIRequestParser(oReq).                                                                            
    assign oPayload  = oRequest:getPayload().                                                                                     
    assign pathParam = oRequest:getPathParams():GetCharacter(1).                                                          
                                                                                                                                  
    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/cstbo/bocst0194.p persistent set boHandler.
    end.                                                                
    
    run openQueryStatic in boHandler (input "Main":U).                                                                        
    run emptyRowErrors  in boHandler.                                                                                              
    run goToKey         in boHandler (input pathParam).                                                                                   
                                                                                                                                  
    if return-value = "NOK" then do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Ve°culo placa " + pathParam  + " n∆o encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Ve°culo n∆o encontrado!").
        msg:add("ErrorSubType", "error").
        msgArray:Add(msg).
        assign oRes = JsonApiResponseBuilder:asError(msgArray, 404).
        
        if valid-handle(boHandler) then
            run destroy in boHandler.
        return.                                                                                                               
    end.                                                                                                                          
                                                                                                                                  
    run getRecord in boHandler (output table ttVeiculos).

    find first ttVeiculos no-lock no-error.

    if oPayload:has('modelo':U) then do:
        ttVeiculos.modelo = oPayload:getCharacter('modelo').
    end.
    if oPayload:has('marca':U) then do:
        ttVeiculos.marca = oPayload:getCharacter('marca').
    end.
    if oPayload:has('ano':U) then do:
        ttVeiculos.ano = oPayload:getInteger('ano').
    end.
    if oPayload:has('cor':U) then do:
        ttVeiculos.cor = oPayload:getCharacter('cor').
    end.
    if oPayload:has('renavam':U) then do:
        ttVeiculos.renavam = oPayload:getCharacter('renavam').
    end.
    if oPayload:has('cod_categ_habilit':U) then do:
        ttVeiculos.cod_categ_habilit = oPayload:getCharacter('cod_categ_habilit').
    end.
    if oPayload:has('ativo':U) then do:
        ttVeiculos.ativo = oPayload:getLogical('ativo').
    end.
    if oPayload:has('disponivel':U) then do:
        ttVeiculos.disponivel = oPayload:getLogical('disponivel').
    end.
    if oPayload:has('km':U) then do:
        ttVeiculos.km = oPayload:getInteger('km').
    end.
    if oPayload:has('proprietario':U) then do:
        ttVeiculos.proprietario = oPayload:getCharacter('proprietario').
    end.
    if oPayload:has('observacoes':U) then do:
        ttVeiculos.observacoes = oPayload:getCharacter('observacoes').
    end.
    if oPayload:has('limp_ext':U) then do:
        ttVeiculos.limp_ext = oPayload:getInteger('limp_ext').
    end.
    if oPayload:has('limp_int':U) then do:
        ttVeiculos.limp_int = oPayload:getInteger('limp_int').
    end.
    if oPayload:has('pneus':U) then do:
        ttVeiculos.pneus = oPayload:getInteger('pneus').
    end.
    if oPayload:has('estepe':U) then do:
        ttVeiculos.estepe = oPayload:getInteger('estepe').
    end.
    if oPayload:has('pintura':U) then do:
        ttVeiculos.pintura = oPayload:getInteger('pintura').
    end.
    if oPayload:has('lataria':U) then do:
        ttVeiculos.lataria = oPayload:getInteger('lataria').
    end.
    if oPayload:has('parachoque_diant':U) then do:
        ttVeiculos.parachoque_diant = oPayload:getInteger('parachoque_diant').
    end.
    if oPayload:has('parachoque_tras':U) then do:
        ttVeiculos.parachoque_tras = oPayload:getInteger('parachoque_tras').
    end.
    if oPayload:has('farol_alto':U) then do:
        ttVeiculos.farol_alto = oPayload:getInteger('farol_alto').
    end.
    if oPayload:has('farol_baixo':U) then do:
        ttVeiculos.farol_baixo = oPayload:getInteger('farol_baixo').
    end.
    if oPayload:has('setas':U) then do:
        ttVeiculos.setas = oPayload:getInteger('setas').
    end.
    if oPayload:has('luz_re':U) then do:
        ttVeiculos.luz_re = oPayload:getInteger('luz_re').
    end.
    if oPayload:has('agua_limp':U) then do:
        ttVeiculos.agua_limp = oPayload:getInteger('agua_limp').
    end.
    if oPayload:has('agua_rad':U) then do:
        ttVeiculos.agua_rad = oPayload:getInteger('agua_rad').
    end.
    if oPayload:has('embreagem':U) then do:
        ttVeiculos.embreagem = oPayload:getInteger('embreagem').
    end.
    if oPayload:has('cambio':U) then do:
        ttVeiculos.cambio = oPayload:getInteger('cambio').
    end.
    if oPayload:has('freio':U) then do:
        ttVeiculos.freio = oPayload:getInteger('freio').
    end.
    if oPayload:has('oleo_freio':U) then do:
        ttVeiculos.oleo_freio = oPayload:getInteger('oleo_freio').
    end.
    if oPayload:has('oleo_motor':U) then do:
        ttVeiculos.oleo_motor = oPayload:getInteger('oleo_motor').
    end.
    if oPayload:has('combustivel':U) then do:
        ttVeiculos.combustivel = oPayload:getInteger('combustivel').
    end.
    if oPayload:has('parabrisa':U) then do:
        ttVeiculos.parabrisa = oPayload:getInteger('parabrisa').
    end.
    if oPayload:has('alarme':U) then do:
        ttVeiculos.alarme = oPayload:getInteger('alarme').
    end.
    if oPayload:has('buzina':U) then do:
        ttVeiculos.buzina = oPayload:getInteger('buzina').
    end.
    if oPayload:has('cintos':U) then do:
        ttVeiculos.cintos = oPayload:getInteger('cintos').
    end.
    if oPayload:has('documentos':U) then do:
        ttVeiculos.documentos = oPayload:getInteger('documentos').
    end.
    if oPayload:has('extintor':U) then do:
        ttVeiculos.extintor = oPayload:getInteger('extintor').
    end.
    if oPayload:has('limpadores':U) then do:
        ttVeiculos.limpadores = oPayload:getInteger('limpadores').
    end.
    if oPayload:has('macaco':U) then do:
        ttVeiculos.macaco = oPayload:getInteger('macaco').
    end.
    if oPayload:has('chave_roda':U) then do:
        ttVeiculos.chave_roda = oPayload:getInteger('chave_roda').
    end.
    if oPayload:has('retrov_ext':U) then do:
        ttVeiculos.retrov_ext = oPayload:getInteger('retrov_ext').
    end.
    if oPayload:has('retrov_int':U) then do:
        ttVeiculos.retrov_int = oPayload:getInteger('retrov_int').         
    end.

    run setRecord      in boHandler (input table ttVeiculos).
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
        msg:add("message", "Ve°culo Atualizado!").
        msg:add("detailedMessage", "Ve°culo " + ttVeiculos.placa  + " atualizado com sucesso!").
        assign oRes = JsonApiResponseBuilder:ok(msg, 200). 
    end.

    catch oE as error:
        assign oRes = JsonApiResponseBuilder:asError(oE).
    end catch.
    
    finally: delete procedure boHandler no-error. end finally. 
end procedure.

/*********************************** ELIMINAR VE÷CULO ***********************************************/
procedure pi-delete:
    define input  param oReq      as JsonObject            no-undo.
    define output param oRes      as JsonObject            no-undo.
    define variable aJsonArray    as JsonArray             no-undo.
    define variable pathParam     as character             no-undo.
    define variable msg           as JsonObject            no-undo.
    define variable msgArray      as JsonArray             no-undo.
    define variable oRequest      as JsonAPIRequestParser  no-undo.
    
    assign oRequest = new JsonAPIRequestParser(oReq).
    assign pathParam = oRequest:getPathParams():GetCharacter(1).

    if not valid-handle(boHandler) then do:
        run cstp/api/v1/services/cstbo/bocst0194.p persistent set boHandler.
    end.

    run openQueryStatic in boHandler (input "Main":U).
    run emptyRowErrors in boHandler.
    run goToKey in boHandler (input pathParam).
    
    if return-value = "OK" then do:
        run deleteRecord in boHandler.
        run getRowErrors in boHandler (output table RowErrors append).   
    end.
    else do:
        assign
            msgArray = new JsonArray()
            msg      = new JsonObject().
        
        msg:add("ErrorHelp", "Ve°culo placa " + pathParam  + " n∆o encontrado na base de dados!").
        msg:add("ErrorNumber", 1).
        msg:add("ErrorDescription", "Ve°culo n∆o encontrado!").
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

