&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS DBOProgram 
/*:T--------------------------------------------------------------------------
    File       : dbo.p
    Purpose    : O DBO (Datasul Business Objects) Ç um programa PROGRESS 
                 que contÇm a l¢gica de neg¢cio e acesso a dados para uma 
                 tabela do banco de dados.

    Parameters : 

    Notes      : 
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.               */
/*------------------------------------------------------------------------*/

/* ***************************  Definitions  **************************** */

/*:T--- Diretrizes de definiá∆o ---*/
&GLOBAL-DEFINE DBOName BOCST0200
&GLOBAL-DEFINE DBOVersion 2.00
&GLOBAL-DEFINE DBOCustomFunctions 
&GLOBAL-DEFINE TableName cst_veiculos_checklist
&GLOBAL-DEFINE TableLabel checklist
&GLOBAL-DEFINE QueryName qr{&TableName} 

/* DBO-XML-BEGIN */
/*:T Pre-processadores para ativar XML no DBO */
/*:T Retirar o comentario para ativar 
&GLOBAL-DEFINE XMLProducer YES    /*:T DBO atua como producer de mensagens para o Message Broker */
&GLOBAL-DEFINE XMLTopic           /*:T Topico da Mensagem enviada ao Message Broker, geralmente o nome da tabela */
&GLOBAL-DEFINE XMLTableName       /*:T Nome da tabela que deve ser usado como TAG no XML */ 
&GLOBAL-DEFINE XMLTableNameMult   /*:T Nome da tabela no plural. Usado para multiplos registros */ 
&GLOBAL-DEFINE XMLPublicFields    /*:T Lista dos campos (c1,c2) que podem ser enviados via XML. Ficam fora da listas os campos de especializacao da tabela */ 
&GLOBAL-DEFINE XMLKeyFields       /*:T Lista dos campos chave da tabela (c1,c2) */
&GLOBAL-DEFINE XMLExcludeFields   /*:T Lista de campos a serem excluidos do XML quando PublicFields = "" */

&GLOBAL-DEFINE XMLReceiver YES    /*:T DBO atua como receiver de mensagens enviado pelo Message Broker (mÇtodo Receive Message) */
&GLOBAL-DEFINE QueryDefault       /*:T Nome da Query que d† acessos a todos os registros, exceto os exclu°dos pela constraint de seguranáa. Usada para receber uma mensagem XML. */
&GLOBAL-DEFINE KeyField1 cust-num /*:T Informar os campos da chave quando o Progress n∆o conseguir resolver find {&TableName} OF RowObject. */
*/
/* DBO-XML-END */

/*:T--- Include com definiá∆o da temptable RowObject ---*/
/*:T--- Este include deve ser copiado para o diret¢rio do DBO e, ainda, seu nome
      deve ser alterado a fim de ser idàntico ao nome do DBO mas com 
      extens∆o .i ---*/
{cstbo/bocst0200.i RowObject}


/*:T--- Include com definiá∆o da query para tabela {&TableName} ---*/
/*:T--- Em caso de necessidade de alteraá∆o da definiá∆o da query, pode ser retirada
      a chamada ao include a seguir e em seu lugar deve ser feita a definiá∆o 
      manual da query ---*/
{method/dboqry.i}


/*:T--- Definiá∆o de buffer que ser† utilizado pelo mÇtodo goToKey ---*/
DEFINE BUFFER bf{&TableName} FOR {&TableName}.

DEFINE VARIABLE agendamento as integer no-undo.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DBOProgram
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DBOProgram
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: CODE-ONLY COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW DBOProgram ASSIGN
         HEIGHT             = 17.79
         WIDTH              = 40.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "DBO 2.0 Wizard" DBOProgram _INLINE
/* Actions: wizard/dbowizard.w ? ? ? ? */
/* DBO 2.0 Wizard (DELETE)*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB DBOProgram 
/* ************************* Included-Libraries *********************** */

{method/dbo.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK DBOProgram 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterCreateRecord DBOProgram 
PROCEDURE afterCreateRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    if RowObject.tipo = 1 then do:
        for first cst_veiculos_agendamento
            where cst_veiculos_agendamento.agendamento_id = RowObject.agendamento_id no-lock:
            find first cst_veiculos
                where cst_veiculos.placa = cst_veiculos_agendamento.placa exclusive-lock no-error.
                update cst_veiculos.disponivel       = false
                       cst_veiculos.agua_limp        = RowObject.agua_limp        
                       cst_veiculos.agua_rad         = RowObject.agua_rad         
                       cst_veiculos.alarme           = RowObject.alarme           
                       cst_veiculos.buzina           = RowObject.buzina           
                       cst_veiculos.cambio           = RowObject.cambio           
                       cst_veiculos.chave_roda       = RowObject.chave_roda       
                       cst_veiculos.cintos           = RowObject.cintos           
                       cst_veiculos.combustivel      = RowObject.combustivel      
                       cst_veiculos.documentos       = RowObject.documentos       
                       cst_veiculos.embreagem        = RowObject.embreagem        
                       cst_veiculos.estepe           = RowObject.estepe           
                       cst_veiculos.extintor         = RowObject.extintor         
                       cst_veiculos.farol_alto       = RowObject.farol_alto       
                       cst_veiculos.farol_baixo      = RowObject.farol_baixo      
                       cst_veiculos.freio            = RowObject.freio            
                       cst_veiculos.km               = RowObject.km               
                       cst_veiculos.lataria          = RowObject.lataria          
                       cst_veiculos.limpadores       = RowObject.limpadores       
                       cst_veiculos.limp_ext         = RowObject.limp_ext         
                       cst_veiculos.limp_int         = RowObject.limp_int         
                       cst_veiculos.luz_re           = RowObject.luz_re           
                       cst_veiculos.macaco           = RowObject.macaco           
                       cst_veiculos.oleo_freio       = RowObject.oleo_freio       
                       cst_veiculos.oleo_motor       = RowObject.oleo_motor       
                       cst_veiculos.parabrisa        = RowObject.parabrisa        
                       cst_veiculos.parachoque_diant = RowObject.parachoque_diant 
                       cst_veiculos.parachoque_tras  = RowObject.parachoque_tras  
                       cst_veiculos.pintura          = RowObject.pintura          
                       cst_veiculos.pneus            = RowObject.pneus            
                       cst_veiculos.retrov_ext       = RowObject.retrov_ext       
                       cst_veiculos.retrov_int       = RowObject.retrov_int       
                       cst_veiculos.setas            = RowObject.setas            
                       cst_veiculos.triangulo        = RowObject.triangulo.        
        end.
    end.
    else if RowObject.tipo = 2 then do:
        find first cst_veiculos_agendamento
             where cst_veiculos_agendamento.agendamento_id = RowObject.agendamento_id exclusive-lock no-error.
            update cst_veiculos_agendamento.concluido = true.

        find first cst_veiculos 
             where cst_veiculos.placa = cst_veiculos_agendamento.placa exclusive-lock no-error.
            update cst_veiculos.disponivel       = true
                   cst_veiculos.agua_limp        = RowObject.agua_limp        
                   cst_veiculos.agua_rad         = RowObject.agua_rad         
                   cst_veiculos.alarme           = RowObject.alarme           
                   cst_veiculos.buzina           = RowObject.buzina           
                   cst_veiculos.cambio           = RowObject.cambio           
                   cst_veiculos.chave_roda       = RowObject.chave_roda       
                   cst_veiculos.cintos           = RowObject.cintos           
                   cst_veiculos.combustivel      = RowObject.combustivel      
                   cst_veiculos.documentos       = RowObject.documentos       
                   cst_veiculos.embreagem        = RowObject.embreagem        
                   cst_veiculos.estepe           = RowObject.estepe           
                   cst_veiculos.extintor         = RowObject.extintor         
                   cst_veiculos.farol_alto       = RowObject.farol_alto       
                   cst_veiculos.farol_baixo      = RowObject.farol_baixo      
                   cst_veiculos.freio            = RowObject.freio            
                   cst_veiculos.km               = RowObject.km               
                   cst_veiculos.lataria          = RowObject.lataria          
                   cst_veiculos.limpadores       = RowObject.limpadores       
                   cst_veiculos.limp_ext         = RowObject.limp_ext         
                   cst_veiculos.limp_int         = RowObject.limp_int         
                   cst_veiculos.luz_re           = RowObject.luz_re           
                   cst_veiculos.macaco           = RowObject.macaco           
                   cst_veiculos.oleo_freio       = RowObject.oleo_freio       
                   cst_veiculos.oleo_motor       = RowObject.oleo_motor       
                   cst_veiculos.parabrisa        = RowObject.parabrisa        
                   cst_veiculos.parachoque_diant = RowObject.parachoque_diant 
                   cst_veiculos.parachoque_tras  = RowObject.parachoque_tras  
                   cst_veiculos.pintura          = RowObject.pintura          
                   cst_veiculos.pneus            = RowObject.pneus            
                   cst_veiculos.retrov_ext       = RowObject.retrov_ext       
                   cst_veiculos.retrov_int       = RowObject.retrov_int       
                   cst_veiculos.setas            = RowObject.setas            
                   cst_veiculos.triangulo        = RowObject.triangulo.
    end.
    
    IF CAN-FIND(FIRST RowErrors WHERE RowErrors.ErrorSubType = "ERROR":U) THEN
        RETURN "NOK":U.
    
    RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE beforeDeleteRecord DBOProgram 
PROCEDURE beforeDeleteRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
if RowObject.tipo = 1 then do:
    for first cst_veiculos_checklist
            where cst_veiculos_checklist.agendamento_id = RowObject.agendamento_id
            and   cst_veiculos_checklist.tipo = 2
            no-lock:
    
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Checklist de SA÷DA n∆o pode ser exclu°do!"
                    &ErrorHelp="CHECKLIST DE SA÷DA j† possui CHECKLIST DE RETORNO cadastrado."}
    end.
end.

    IF CAN-FIND(FIRST RowErrors WHERE RowErrors.ErrorSubType = "ERROR":U) THEN
        RETURN "NOK":U.
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getCharField DBOProgram 
PROCEDURE getCharField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo caracter
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS CHARACTER NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        WHEN "hr_checklist":U THEN ASSIGN pFieldValue = RowObject.hr_checklist.
        WHEN "observacoes":U THEN ASSIGN pFieldValue = RowObject.observacoes.
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getDateField DBOProgram 
PROCEDURE getDateField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo data
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS DATE NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        WHEN "dt_checklist":U THEN ASSIGN pFieldValue = RowObject.dt_checklist.
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getDecField DBOProgram 
PROCEDURE getDecField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo decimal
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS DECIMAL NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getIntField DBOProgram 
PROCEDURE getIntField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo inteiro
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS INTEGER NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        WHEN "agendamento_id":U THEN ASSIGN pFieldValue = RowObject.agendamento_id.
        WHEN "agua_limp":U THEN ASSIGN pFieldValue = RowObject.agua_limp.
        WHEN "agua_rad":U THEN ASSIGN pFieldValue = RowObject.agua_rad.
        WHEN "alarme":U THEN ASSIGN pFieldValue = RowObject.alarme.
        WHEN "avaliador":U THEN ASSIGN pFieldValue = RowObject.avaliador.
        WHEN "buzina":U THEN ASSIGN pFieldValue = RowObject.buzina.
        WHEN "cambio":U THEN ASSIGN pFieldValue = RowObject.cambio.
        WHEN "chave_roda":U THEN ASSIGN pFieldValue = RowObject.chave_roda.
        WHEN "cintos":U THEN ASSIGN pFieldValue = RowObject.cintos.
        WHEN "combustivel":U THEN ASSIGN pFieldValue = RowObject.combustivel.
        WHEN "documentos":U THEN ASSIGN pFieldValue = RowObject.documentos.
        WHEN "embreagem":U THEN ASSIGN pFieldValue = RowObject.embreagem.
        WHEN "estepe":U THEN ASSIGN pFieldValue = RowObject.estepe.
        WHEN "extintor":U THEN ASSIGN pFieldValue = RowObject.extintor.
        WHEN "farol_alto":U THEN ASSIGN pFieldValue = RowObject.farol_alto.
        WHEN "farol_baixo":U THEN ASSIGN pFieldValue = RowObject.farol_baixo.
        WHEN "freio":U THEN ASSIGN pFieldValue = RowObject.freio.
        WHEN "km":U THEN ASSIGN pFieldValue = RowObject.km.
        WHEN "lataria":U THEN ASSIGN pFieldValue = RowObject.lataria.
        WHEN "limpadores":U THEN ASSIGN pFieldValue = RowObject.limpadores.
        WHEN "limp_ext":U THEN ASSIGN pFieldValue = RowObject.limp_ext.
        WHEN "limp_int":U THEN ASSIGN pFieldValue = RowObject.limp_int.
        WHEN "luz_re":U THEN ASSIGN pFieldValue = RowObject.luz_re.
        WHEN "macaco":U THEN ASSIGN pFieldValue = RowObject.macaco.
        WHEN "oleo_freio":U THEN ASSIGN pFieldValue = RowObject.oleo_freio.
        WHEN "oleo_motor":U THEN ASSIGN pFieldValue = RowObject.oleo_motor.
        WHEN "parabrisa":U THEN ASSIGN pFieldValue = RowObject.parabrisa.
        WHEN "parachoque_diant":U THEN ASSIGN pFieldValue = RowObject.parachoque_diant.
        WHEN "parachoque_tras":U THEN ASSIGN pFieldValue = RowObject.parachoque_tras.
        WHEN "pintura":U THEN ASSIGN pFieldValue = RowObject.pintura.
        WHEN "pneus":U THEN ASSIGN pFieldValue = RowObject.pneus.
        WHEN "retrov_ext":U THEN ASSIGN pFieldValue = RowObject.retrov_ext.
        WHEN "retrov_int":U THEN ASSIGN pFieldValue = RowObject.retrov_int.
        WHEN "setas":U THEN ASSIGN pFieldValue = RowObject.setas.
        WHEN "tipo":U THEN ASSIGN pFieldValue = RowObject.tipo.
        WHEN "triangulo":U THEN ASSIGN pFieldValue = RowObject.triangulo.
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getKey DBOProgram 
PROCEDURE getKey :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valores dos campos do °ndice pk
  Parameters:  
               retorna valor do campo agendamento_id
               retorna valor do campo tipo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE OUTPUT PARAMETER pagendamento_id LIKE cst_veiculos_checklist.agendamento_id NO-UNDO.
    DEFINE OUTPUT PARAMETER ptipo LIKE cst_veiculos_checklist.tipo NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
       RETURN "NOK":U.

    ASSIGN pagendamento_id = RowObject.agendamento_id
           ptipo = RowObject.tipo.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getLogField DBOProgram 
PROCEDURE getLogField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo l¢gico
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS LOGICAL NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getRawField DBOProgram 
PROCEDURE getRawField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo raw
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS RAW NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getRecidField DBOProgram 
PROCEDURE getRecidField :
/*------------------------------------------------------------------------------
  Purpose:     Retorna valor de campos do tipo recid
  Parameters:  
               recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pFieldName AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pFieldValue AS RECID NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
        RETURN "NOK":U.

    CASE pFieldName:
        OTHERWISE RETURN "NOK":U.
    END CASE.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE goToKey DBOProgram 
PROCEDURE goToKey :
/*------------------------------------------------------------------------------
  Purpose:     Reposiciona registro com base no °ndice pk
  Parameters:  
               recebe valor do campo agendamento_id
               recebe valor do campo tipo
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pagendamento_id LIKE cst_veiculos_checklist.agendamento_id NO-UNDO.
    DEFINE INPUT PARAMETER ptipo LIKE cst_veiculos_checklist.tipo NO-UNDO.

    FIND FIRST bfcst_veiculos_checklist WHERE 
        bfcst_veiculos_checklist.agendamento_id = pagendamento_id AND 
        bfcst_veiculos_checklist.tipo = ptipo NO-LOCK NO-ERROR.

    /*--- Verifica se registro foi encontrado, em caso de erro ser† retornada flag "NOK":U ---*/
    IF NOT AVAILABLE bfcst_veiculos_checklist THEN 
        RETURN "NOK":U.

    /*--- Reposiciona query atravÇs de rowid e verifica a ocorrància de erros, caso
          existam erros ser† retornada flag "NOK":U ---*/
    RUN repositionRecord IN THIS-PROCEDURE (INPUT ROWID(bfcst_veiculos_checklist)).
    IF RETURN-VALUE = "NOK":U THEN
        RETURN "NOK":U.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE linkToAgendamento DBOProgram 
PROCEDURE linkToAgendamento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    define input parameter pHBOAgendamento      as handle  no-undo.
    define variable        iAgendamentoCorrente as integer no-undo.

    run getKey in pHBOAgendamento (output iAgendamentoCorrente).

    run setConstraintAgendamento in this-procedure (input iAgendamentoCorrente).

    return "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE openQueryAgendamento DBOProgram 
PROCEDURE openQueryAgendamento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    open query {&QueryName} for each {&TableName} 
        where cst_veiculos_checklist.agendamento_id = agendamento no-lock.

    return "OK":U.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE openQueryMain DBOProgram 
PROCEDURE openQueryMain :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY {&QueryName} FOR EACH {&TableName} NO-LOCK.
   RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setConstraintAgendamento DBOProgram 
PROCEDURE setConstraintAgendamento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    define input parameter iAgendamentoCorrente as integer no-undo.
    assign agendamento = iAgendamentoCorrente.
    return "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setConstraintMain DBOProgram 
PROCEDURE setConstraintMain :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    return "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validateRecord DBOProgram 
PROCEDURE validateRecord :
/*:T------------------------------------------------------------------------------
  Purpose:     Validaá‰es pertinentes ao DBO
  Parameters:  recebe o tipo de validaá∆o (Create, Delete, Update)
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER pType AS CHARACTER NO-UNDO.
    /*:T--- Utilize o parÉmetro pType para identificar quais as validaá‰es a serem
          executadas ---*/
    /*:T--- Os valores poss°veis para o parÉmetro s∆o: Create, Delete e Update ---*/
    /*:T--- Devem ser tratados erros PROGRESS e erros do Produto, atravÇs do 
          include: method/svc/errors/inserr.i ---*/
    /*:T--- Inclua aqui as validaá‰es ---*/
if pType = "Create":U THEN DO:
    if can-find (first cst_veiculos_checklist 
       where cst_veiculos_checklist.agendamento_id = RowObject.agendamento_id
       and   cst_veiculos_checklist.tipo = RowObject.tipo) then 
        {method/svc/errors/inserr.i
             &ErrorNumber="112"
             &ErrorType="EMS"
             &ErrorSubType="ERROR"
             &ErrorDescription="AGENDAMENTO j† foi cadastrado com este TIPO!"
             &ErrorHelp="Verifique se este CHECKLIST ja foi cadastrado no sistema."}
             
    if RowObject.tipo = 1 then do:
        for first cst_veiculos_agendamento 
            where cst_veiculos_agendamento.agendamento_id = RowObject.agendamento_id no-lock,
            first cst_veiculos
            where cst_veiculos.placa = cst_veiculos_agendamento.placa
            and   cst_veiculos.disponivel = false:
            {method/svc/errors/inserr.i
                 &ErrorNumber="112"
                 &ErrorType="EMS"
                 &ErrorSubType="ERROR"
                 &ErrorDescription="VE÷CULO encontra-se INDISPON÷VEL!"
                 &ErrorHelp="Verifique se o ve°culo possui pendància de CHECKLIST DE RETORNO no sistema."}
        end.
    end.
    if RowObject.tipo = 2 then do:
        if not can-find (first cst_veiculos_checklist 
            where cst_veiculos_checklist.agendamento_id = RowObject.agendamento_id
            and   cst_veiculos_checklist.tipo = 1) then
             {method/svc/errors/inserr.i
                &ErrorNumber="112"
                &ErrorType="EMS"
                &ErrorSubType="ERROR"
                &ErrorDescription="Checklist RETORNO n∆o permitido antes do checklist SA÷DA!"
                &ErrorHelp="Para incluir um checklist de RETORNO, Ç necess†rio ter um checklist de SA÷DA cadastrado previamente."}
    end.
    if not can-find (first cst_veiculos_agendamento 
       where cst_veiculos_agendamento.agendamento_id = RowObject.agendamento_id) then
        {method/svc/errors/inserr.i
             &ErrorNumber="112"
             &ErrorType="EMS"
             &ErrorSubType="ERROR"
             &ErrorDescription="Numero AGENDAMENTO n∆o foi encontrado!"
             &ErrorHelp="Verifique se o numero do agendamento foi digitado corretamente."}
             
    if RowObject.agendamento_id = 0 then
        {method/svc/errors/inserr.i
             &ErrorNumber="112"
             &ErrorType="EMS"
             &ErrorSubType="ERROR"
             &ErrorDescription="Valor inv†lido para o campo No.AGENDAMENTO!"
             &ErrorHelp="Informe o N£mero do Agendamento."} 
    if RowObject.tipo = 0 then
        {method/svc/errors/inserr.i
             &ErrorNumber="112"
             &ErrorType="EMS"
             &ErrorSubType="ERROR"
             &ErrorDescription="Valor inv†lido para o campo TIPO!"
             &ErrorHelp="Informe o Tipo do Checklist (Sa°da / Retorno)."}                      
end.

IF pType = "Create":U or pType = "Update":U THEN DO:    
    IF RowObject.avaliador = 0 THEN
    {method/svc/errors/inserr.i
                &ErrorNumber="112"
                &ErrorType="EMS"
                &ErrorSubType="ERROR"
                &ErrorDescription="Valor inv†lido para o campo AVALIADOR!"
                &ErrorHelp="Informe a matr°cula do avaliador respons†vel por este checklist."}
                
    IF RowObject.dt_checklist = ? THEN
    {method/svc/errors/inserr.i
                &ErrorNumber="112"
                &ErrorType="EMS"
                &ErrorSubType="ERROR"
                &ErrorDescription="Valor inv†lido para o campo DATA!"
                &ErrorHelp="Informe a data do checklist."}
                
    IF RowObject.hr_checklist = "" THEN
    {method/svc/errors/inserr.i
                &ErrorNumber="112"
                &ErrorType="EMS"
                &ErrorSubType="ERROR"
                &ErrorDescription="Valor inv†lido para o campo HORA!"
                &ErrorHelp="Informe o hor†rio do checklist."}
                
    IF RowObject.km = 0 THEN
    {method/svc/errors/inserr.i
                &ErrorNumber="112"
                &ErrorType="EMS"
                &ErrorSubType="ERROR"
                &ErrorDescription="Valor inv†lido para o campo KM!"
                &ErrorHelp="Informe a Quilometragem atual do ve°culo."}
                
end.
    /*:T--- Verifica ocorrància de erros ---*/
    IF CAN-FIND(FIRST RowErrors WHERE RowErrors.ErrorSubType = "ERROR":U) THEN
        RETURN "NOK":U.
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

