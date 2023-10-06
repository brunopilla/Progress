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
&GLOBAL-DEFINE DBOName BOCST0197
&GLOBAL-DEFINE DBOVersion 2.00 
&GLOBAL-DEFINE DBOCustomFunctions 
&GLOBAL-DEFINE TableName cst_veiculos_agendamento
&GLOBAL-DEFINE TableLabel Agendamento
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
{cstbo/bocst0197.i RowObject}


/*:T--- Include com definiá∆o da query para tabela {&TableName} ---*/
/*:T--- Em caso de necessidade de alteraá∆o da definiá∆o da query, pode ser retirada
      a chamada ao include a seguir e em seu lugar deve ser feita a definiá∆o 
      manual da query ---*/
{method/dboqry.i}
/* define query {&QueryName} for */
/*     {&TableName},             */
/*     funcionario scrolling.    */


/*:T--- Definiá∆o de buffer que ser† utilizado pelo mÇtodo goToKey ---*/
DEFINE BUFFER bf{&TableName} FOR {&TableName}.

//DEFINE VARIABLE matriculaInicial AS INTEGER     NO-UNDO.
//DEFINE VARIABLE matriculaFinal   AS INTEGER     NO-UNDO.
DEFINE VARIABLE veiculo     AS character   NO-UNDO.
DEFINE VARIABLE funcionario AS integer     NO-UNDO.

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
         HEIGHT             = 15.75
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterNewRecord DBOProgram 
PROCEDURE afterNewRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

assign
    rowObject.agendamento_id = next-value(seq_agendam_veic).
    rowObject.prev_hora_inic = "000000".
    rowObject.prev_hora_fin  = "000000".
    
    
return "OK".
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
for first cst_veiculos_checklist
        where cst_veiculos_checklist.agendamento_id = RowObject.agendamento_id 
        no-lock:

        {method/svc/errors/inserr.i
                &ErrorNumber="112"
                &ErrorType="EMS"
                &ErrorSubType="ERROR"
                &ErrorDescription="Agendamento n∆o pode ser exclu°do!"
                &ErrorHelp="Agendamento possui hist¢rico com checklists de rotas."}
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
        WHEN "destino":U THEN ASSIGN pFieldValue = RowObject.destino.
        WHEN "motivo":U THEN ASSIGN pFieldValue = RowObject.motivo.
        WHEN "placa":U THEN ASSIGN pFieldValue = RowObject.placa.
        WHEN "prev_hora_fin":U THEN ASSIGN pFieldValue = RowObject.prev_hora_fin.
        WHEN "prev_hora_inic":U THEN ASSIGN pFieldValue = RowObject.prev_hora_inic.
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
        WHEN "prev_data_fin":U THEN ASSIGN pFieldValue = RowObject.prev_data_fin.
        WHEN "prev_data_inic":U THEN ASSIGN pFieldValue = RowObject.prev_data_inic.
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
        WHEN "aprovador":U THEN ASSIGN pFieldValue = RowObject.aprovador.
        WHEN "condutor":U THEN ASSIGN pFieldValue = RowObject.condutor.
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
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE OUTPUT PARAMETER pagendamento_id LIKE cst_veiculos_agendamento.agendamento_id NO-UNDO.

    /*--- Verifica se temptable RowObject est† dispon°vel, caso n∆o esteja ser†
          retornada flag "NOK":U ---*/
    IF NOT AVAILABLE RowObject THEN 
       RETURN "NOK":U.

    ASSIGN pagendamento_id = RowObject.agendamento_id.

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
        WHEN "concluido":U THEN ASSIGN pFieldValue = RowObject.concluido.
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
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pagendamento_id LIKE cst_veiculos_agendamento.agendamento_id NO-UNDO.

    FIND FIRST bfcst_veiculos_agendamento WHERE 
        bfcst_veiculos_agendamento.agendamento_id = pagendamento_id NO-LOCK NO-ERROR.

    /*--- Verifica se registro foi encontrado, em caso de erro ser† retornada flag "NOK":U ---*/
    IF NOT AVAILABLE bfcst_veiculos_agendamento THEN 
        RETURN "NOK":U.

    /*--- Reposiciona query atravÇs de rowid e verifica a ocorrància de erros, caso
          existam erros ser† retornada flag "NOK":U ---*/
    RUN repositionRecord IN THIS-PROCEDURE (INPUT ROWID(bfcst_veiculos_agendamento)).
    IF RETURN-VALUE = "NOK":U THEN
        RETURN "NOK":U.

    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE linkToVeiculos DBOProgram 
PROCEDURE linkToVeiculos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pHBOVeiculos     AS HANDLE    NO-UNDO.
    DEFINE VARIABLE        cVeiculoCorrente AS character NO-UNDO.

    run getKey in pHBOVeiculos (output cVeiculoCorrente).

    run setConstraintVeiculos in this-procedure (input cVeiculoCorrente).

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
        open query {&QueryName} for each {&TableName} no-lock.
        return "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE openQueryVeiculos DBOProgram 
PROCEDURE openQueryVeiculos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    open query {&QueryName} for each {&TableName} 
        where cst_veiculos_agendamento.placa = veiculo no-lock.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setConstraintVeiculos DBOProgram 
PROCEDURE setConstraintVeiculos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pVeiculoCorrente AS character NO-UNDO.
    assign veiculo = pVeiculoCorrente.
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
   
    def input parameter pType      as char     no-undo.

    def buffer agendamento for cst_veiculos_agendamento.
    
    def var             c-hora-ini as char     no-undo.
    def var             c-hora-fin as char     no-undo.
    def var             dt-ini     as datetime no-undo.
    def var             dt-fin     as datetime no-undo.
    def var             dt-ini-agd as datetime no-undo.
    def var             dt-fin-agd as datetime no-undo.
    /*:T--- Utilize o parÉmetro pType para identificar quais as validaá‰es a serem
          executadas ---*/
    /*:T--- Os valores poss°veis para o parÉmetro s∆o: Create, Delete e Update ---*/
    /*:T--- Devem ser tratados erros PROGRESS e erros do Produto, atravÇs do 
          include: method/svc/errors/inserr.i ---*/
    /*:T--- Inclua aqui as validaá‰es ---*/
    

IF pType = "Create":U or pType = "Update":U THEN DO:    
    IF RowObject.condutor = 0 THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o CONDUTOR!"
                    &ErrorHelp="Informe uma matr°cula v†lida para o campo condutor."}
                    
    IF RowObject.prev_data_inic = ? THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para DATA SA÷DA!"
                    &ErrorHelp="Informe a data prevista para sa°da."}
                    
    IF RowObject.prev_hora_inic = "" THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o HORA SA÷DA!"
                    &ErrorHelp="Informe o hor†rio previsto para sa°da."}
                    
    IF RowObject.prev_data_fin = ? THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o DATA RETORNO!"
                    &ErrorHelp="Informe a data prevista para retorno."}
                    
    IF RowObject.prev_hora_fin = "" THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o HORA RETORNO"
                    &ErrorHelp="Informe o hor†rio previsto para retorno."}
                    
    ASSIGN 
        c-hora-ini = REPLACE(RowObject.prev_hora_inic,":","")
        c-hora-fin = REPLACE(RowObject.prev_hora_fin,":","").
    
    if (INT(SUBSTRING(c-hora-ini,1,2)) > 23 ) or
       (INT(SUBSTRING(c-hora-ini,3,2)) > 59 ) or
       (INT(SUBSTRING(c-hora-ini,5,2)) > 59 ) then
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o campo HORA SA÷DA!"
                    &ErrorHelp="Informe um hor†rio de sa°da v†lido."}
    
    if (INT(SUBSTRING(c-hora-fin,1,2)) > 23 ) or
       (INT(SUBSTRING(c-hora-fin,3,2)) > 59 ) or
       (INT(SUBSTRING(c-hora-fin,5,2)) > 59 ) then
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o campo HORA RETORNO!"
                    &ErrorHelp="Informe um hor†rio de retorno v†lido."}
      
    IF RowObject.destino = "" THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o campo DESTINO!"
                    &ErrorHelp="Informe o destino/itiner†rio da rota."}
                    
    IF RowObject.motivo = "" THEN
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o campo MOTIVO!"
                    &ErrorHelp="O campo MOTIVO n∆o pode ser branco."}
                    
    FIND FIRST funcionario
         WHERE funcionario.cdn_funcionario = RowObject.condutor NO-LOCK NO-ERROR.
         
    if not avail funcionario then
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Valor inv†lido para o campo CONDUTOR!"
                    &ErrorHelp="Digite um n£mero de matr°cula v†lido para o campo condutor"}

    for first cst_hierarquia_func where cst_hierarquia_func.cdn_funcionario = funcionario.cdn_funcionario no-lock,
        first cst_veiculos where cst_veiculos.placa = RowObject.placa:
        
        if (cst_hierarquia_func.condutor = false) then
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Condutor n∆o autorizado!"
                    &ErrorHelp="O funcion†rio indicado n∆o est† cadastrado como CONDUTOR no programa CSFP015. Entre em contato com o RH para solicitar a permiss∆o para dirgir os ve°culos da empresa."}
        else if (length(trim(funcionario.cod_categ_habilit)) = 0) then 
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Condutor n∆o autorizado!"
                    &ErrorHelp="A categoria da CNH do CONDUTOR n∆o est† cadastrada. Entre em contato com o RH para solicitar a atualizaá∆o dos dados do condutor"}
        else if (substring(trim(funcionario.cod_categ_habilit), length(trim(funcionario.cod_categ_habilit))) < trim(cst_veiculos.cod_categ_habilit))
             or (trim(funcionario.cod_categ_habilit) = "ACC") then
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Condutor n∆o autorizado!"
                    &ErrorHelp="A categoria da CNH do CONDUTOR n∆o Ç compat°vel com a categoria do ve°culo selecionado. Entre em contato com o RH para solicitar a atualizaá∆o dos dados do condutor."}
        else if (funcionario.dat_vencto_habilit = ?) then
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Condutor n∆o autorizado!"
                    &ErrorHelp="A data de vencimento da CNH do CONDUTOR n∆o est† cadastrada. Entre em contato com o RH para solicitar a atualizaá∆o dos dados do condutor."}
        else if (funcionario.dat_vencto_habilit < today ) then
            {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Condutor n∆o autorizado!"
                    &ErrorHelp="A data de vencimento da CNH do CONDUTOR no sistema est† expirada. Entre em contato com o RH para solicitar a atualizaá∆o dos dados do condutor."}
    end.
        
    assign 
        dt-ini = DATETIME(string(RowObject.prev_data_inic,"99-99-9999") + " " + string(RowObject.prev_hora_inic,"99:99:99"))
        dt-fin = DATETIME(string(RowObject.prev_data_fin,"99-99-9999") + " " + string(RowObject.prev_hora_fin,"99:99:99")).
    
    if(dt-ini <= now) then
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Data Sa°da inv†lida!"
                    &ErrorHelp="A Data/Hora de Sa°da deve ser maior ou igual Ö Data/Hora Atual."}
    else if (dt-fin <= dt-ini) then
        {method/svc/errors/inserr.i
                    &ErrorNumber="112"
                    &ErrorType="EMS"
                    &ErrorSubType="ERROR"
                    &ErrorDescription="Data Retorno inv†lida!"
                    &ErrorHelp="A Data/Hora de Retorno deve ser maior que a Data/Hora de Sa°da."}
end.
IF pType = "Create":U THEN DO:
    for first agendamento no-lock 
       where agendamento.concluido = no 
         and agendamento.placa     = RowObject.placa: 
        assign
            dt-ini-agd = DATETIME(string(agendamento.prev_data_inic,"99-99-9999") + " " + string(agendamento.prev_hora_inic,"99:99:99"))
            dt-fin-agd = DATETIME(string(agendamento.prev_data_fin,"99-99-9999") + " " + string(agendamento.prev_hora_fin,"99:99:99")).
        if(dt-ini >= dt-ini-agd and dt-ini <= dt-fin-agd) or
          (dt-fin >= dt-ini-agd and dt-fin <= dt-fin-agd) then
             {method/svc/errors/inserr.i
                     &ErrorNumber="112"
                     &ErrorType="EMS"
                     &ErrorSubType="ERROR"
                     &ErrorDescription="Data/Hora conflitante!"
                     &ErrorHelp="O ve°culo possui um agendamento prÇvio conflitante com a data/hora escolhida. Verifique a agenda do ve°culo e escolha um novo hor†rio."}
    end.
end.

IF pType = "Update":U THEN DO:
    for first agendamento no-lock 
       where agendamento.concluido       =  no 
         and agendamento.placa           =  RowObject.placa 
         and agendamento.agendamento_id  <> RowObject.agendamento_id: 
        assign
            dt-ini-agd = DATETIME(string(agendamento.prev_data_inic,"99-99-9999") + " " + string(agendamento.prev_hora_inic,"99:99:99"))
            dt-fin-agd = DATETIME(string(agendamento.prev_data_fin,"99-99-9999") + " " + string(agendamento.prev_hora_fin,"99:99:99")).
        if(dt-ini >= dt-ini-agd and dt-ini <= dt-fin-agd) or
          (dt-fin >= dt-ini-agd and dt-fin <= dt-fin-agd) then
             {method/svc/errors/inserr.i
                     &ErrorNumber="112"
                     &ErrorType="EMS"
                     &ErrorSubType="ERROR"
                     &ErrorDescription="Data/Hora conflitante!"
                     &ErrorHelp="O ve°culo possui um agendamento prÇvio conflitante com a data/hora escolhida. Verifique a agenda do ve°culo e escolha um novo hor†rio."}
    end.
end.
      
        /*:T--- Verifica ocorrància de erros ---*/
IF CAN-FIND(FIRST RowErrors WHERE RowErrors.ErrorSubType = "ERROR":U) THEN
      RETURN "NOK":U.
       
RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

