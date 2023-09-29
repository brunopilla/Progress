&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          emscustom        PROGRESS
*/
&Scoped-define WINDOW-NAME wMaintenanceNoNavigation


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE ttAgendamento NO-UNDO LIKE cst_veiculos_agendamento
       field r-rowid as rowid.
DEFINE TEMP-TABLE ttVeiculos NO-UNDO LIKE cst_veiculos
       field r-rowid as rowid.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wMaintenanceNoNavigation 
/*:T*******************************************************************************
** Copyright TOTVS S.A. (2009)
** Todos os Direitos Reservados.
**
** Este fonte e de propriedade exclusiva da TOTVS, sua reproducao
** parcial ou total por qualquer meio, so podera ser feita mediante
** autorizacao expressa.
*******************************************************************************/
{include/i-prgvrs.i cspt019b 2023.00.00.001}

/* Chamada a include do gerenciador de licen‡as. Necessario alterar os parametros */
/*                                                                                */
/* <programa>:  Informar qual o nome do programa.                                 */
/* <m¢dulo>:  Informar qual o m¢dulo a qual o programa pertence.                  */

&IF "{&EMSFND_VERSION}" >= "1.00" &THEN
    {include/i-license-manager.i cspt019b MUT}
&ENDIF

CREATE WIDGET-POOL.


/* Preprocessors Definitions ---                                      */
&GLOBAL-DEFINE Program           cspt019b
&GLOBAL-DEFINE Version           2023.00.00.001

&GLOBAL-DEFINE Folder            no
&GLOBAL-DEFINE InitialPage       1

&GLOBAL-DEFINE FolderLabels      

&GLOBAL-DEFINE ttTable           ttAgendamento
&GLOBAL-DEFINE hDBOTable         hBOAgendamento
&GLOBAL-DEFINE DBOTable          Agendamento

&GLOBAL-DEFINE ttParent          ttVeiculos
&GLOBAL-DEFINE DBOParentTable    Veiculos

  
&GLOBAL-DEFINE page0KeyFields    ttAgendamento.agendamento_id  
&GLOBAL-DEFINE page0Fields       ttAgendamento.condutor ~
                                 ttAgendamento.destino ~
                                 ttAgendamento.motivo ~
                                 ttAgendamento.prev_data_fin ~
                                 ttAgendamento.prev_data_inic ~
                                 ttAgendamento.prev_hora_fin ~
                                 ttAgendamento.prev_hora_inic
                                  
&GLOBAL-DEFINE page0ParentFields ttVeiculos.placa ~
                                 ttVeiculos.modelo 
     

/* Parameters Definitions ---                                           */
DEFINE INPUT PARAMETER prTable         AS ROWID     NO-UNDO.
DEFINE INPUT PARAMETER prParent        AS ROWID     NO-UNDO.
DEFINE INPUT PARAMETER pcAction        AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER phCaller        AS HANDLE    NO-UNDO.
DEFINE INPUT PARAMETER piSonPageNumber AS INTEGER   NO-UNDO.

/*Vari veis do smart objects (zoom chave estrangeira condutor) ---                                       */

DEFINE NEW GLOBAL SHARED VARIABLE adm-broker-hdl AS HANDLE NO-UNDO.
DEFINE VARIABLE wh-pesquisa AS HANDLE NO-UNDO.


/* Local Variable Definitions (DBOs Handles) --- */
DEFINE VARIABLE {&hDBOTable}  AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE MaintenanceNoNavigation
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fpage0

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS ttAgendamento.condutor ~
ttAgendamento.prev_data_inic ttAgendamento.prev_hora_inic ~
ttAgendamento.prev_data_fin ttAgendamento.prev_hora_fin ~
ttAgendamento.destino ttAgendamento.motivo ttVeiculos.placa ~
ttVeiculos.modelo 
&Scoped-define ENABLED-TABLES ttAgendamento ttVeiculos
&Scoped-define FIRST-ENABLED-TABLE ttAgendamento
&Scoped-define SECOND-ENABLED-TABLE ttVeiculos
&Scoped-Define ENABLED-OBJECTS btOK btSave btCancel btHelp rtKeys rtToolBar ~
RECT-32 RECT-33 
&Scoped-Define DISPLAYED-FIELDS ttAgendamento.condutor ~
ttAgendamento.prev_data_inic ttAgendamento.prev_hora_inic ~
ttAgendamento.prev_data_fin ttAgendamento.prev_hora_fin ~
ttAgendamento.destino ttAgendamento.motivo ttAgendamento.agendamento_id ~
ttVeiculos.placa ttVeiculos.modelo 
&Scoped-define DISPLAYED-TABLES ttAgendamento ttVeiculos
&Scoped-define FIRST-DISPLAYED-TABLE ttAgendamento
&Scoped-define SECOND-DISPLAYED-TABLE ttVeiculos
&Scoped-Define DISPLAYED-OBJECTS c-condutor 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wMaintenanceNoNavigation AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCancel 
     LABEL "Cancelar" 
     SIZE 10 BY 1.

DEFINE BUTTON btHelp 
     LABEL "Ajuda" 
     SIZE 10 BY 1.

DEFINE BUTTON btOK 
     LABEL "OK" 
     SIZE 10 BY 1.

DEFINE BUTTON btSave 
     LABEL "Salvar" 
     SIZE 10 BY 1.

DEFINE VARIABLE c-condutor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49.57 BY .88 NO-UNDO.

DEFINE RECTANGLE RECT-32
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 3.63.

DEFINE RECTANGLE RECT-33
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 3.58.

DEFINE RECTANGLE rtKeys
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 90 BY 1.25.

DEFINE RECTANGLE rtToolBar
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 90 BY 1.42
     BGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fpage0
     ttAgendamento.condutor AT ROW 3.5 COL 13 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 13 BY .88
     ttAgendamento.prev_data_inic AT ROW 5.79 COL 23.72 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 13 BY .88
     ttAgendamento.prev_hora_inic AT ROW 6.79 COL 23.72 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 13 BY .88
     ttAgendamento.prev_data_fin AT ROW 5.79 COL 56.57 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 13 BY .88
     ttAgendamento.prev_hora_fin AT ROW 6.79 COL 56.57 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 13 BY .88
     ttAgendamento.destino AT ROW 8.46 COL 13 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 63 BY .88
     ttAgendamento.motivo AT ROW 9.46 COL 13 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 63 BY .88
     ttAgendamento.agendamento_id AT ROW 1.17 COL 13 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 13 BY .88 NO-TAB-STOP 
     ttVeiculos.placa AT ROW 2.5 COL 13 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 13 BY .88 NO-TAB-STOP 
     btOK AT ROW 10.92 COL 2
     ttVeiculos.modelo AT ROW 2.5 COL 26.43 COLON-ALIGNED NO-LABEL WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 49.57 BY .88 NO-TAB-STOP 
     btSave AT ROW 10.92 COL 13
     btCancel AT ROW 10.92 COL 24
     c-condutor AT ROW 3.5 COL 26.43 COLON-ALIGNED NO-LABEL WIDGET-ID 38 NO-TAB-STOP 
     btHelp AT ROW 10.92 COL 80
     "Sa¡da:" VIEW-AS TEXT
          SIZE 8 BY .54 AT ROW 4.88 COL 16.14 WIDGET-ID 32
     "Retorno:" VIEW-AS TEXT
          SIZE 8 BY .54 AT ROW 4.92 COL 49.14 WIDGET-ID 36
     rtKeys AT ROW 1 COL 1
     rtToolBar AT ROW 10.67 COL 1
     RECT-32 AT ROW 4.63 COL 15 WIDGET-ID 30
     RECT-33 AT ROW 4.67 COL 48 WIDGET-ID 34
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 90 BY 11.08
         FONT 1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: MaintenanceNoNavigation
   Allow: Basic,Browse,DB-Fields,Window,Query
   Add Fields to: Neither
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: ttAgendamento T "?" NO-UNDO emscustom cst_veiculos_agendamento
      ADDITIONAL-FIELDS:
          field r-rowid as rowid
      END-FIELDS.
      TABLE: ttVeiculos T "?" NO-UNDO emscustom cst_veiculos
      ADDITIONAL-FIELDS:
          field r-rowid as rowid
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wMaintenanceNoNavigation ASSIGN
         HIDDEN             = YES
         TITLE              = ""
         HEIGHT             = 11.08
         WIDTH              = 90
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 90.29
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 90.29
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = yes
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wMaintenanceNoNavigation 
/* ************************* Included-Libraries *********************** */

{maintenancenonavigation/maintenancenonavigation.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wMaintenanceNoNavigation
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME fpage0
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN ttAgendamento.agendamento_id IN FRAME fpage0
   NO-ENABLE                                                            */
ASSIGN 
       ttAgendamento.agendamento_id:READ-ONLY IN FRAME fpage0        = TRUE.

/* SETTINGS FOR FILL-IN c-condutor IN FRAME fpage0
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wMaintenanceNoNavigation)
THEN wMaintenanceNoNavigation:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fpage0
/* Query rebuild information for FRAME fpage0
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME fpage0 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wMaintenanceNoNavigation
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wMaintenanceNoNavigation wMaintenanceNoNavigation
ON END-ERROR OF wMaintenanceNoNavigation
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wMaintenanceNoNavigation wMaintenanceNoNavigation
ON WINDOW-CLOSE OF wMaintenanceNoNavigation
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel wMaintenanceNoNavigation
ON CHOOSE OF btCancel IN FRAME fpage0 /* Cancelar */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btHelp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btHelp wMaintenanceNoNavigation
ON CHOOSE OF btHelp IN FRAME fpage0 /* Ajuda */
DO:
    {include/ajuda.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK wMaintenanceNoNavigation
ON CHOOSE OF btOK IN FRAME fpage0 /* OK */
DO:
   RUN saveRecord IN THIS-PROCEDURE.
    IF RETURN-VALUE = "OK":U THEN
        APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSave wMaintenanceNoNavigation
ON CHOOSE OF btSave IN FRAME fpage0 /* Salvar */
DO:
    RUN saveRecord IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ttAgendamento.condutor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ttAgendamento.condutor wMaintenanceNoNavigation
ON F5 OF ttAgendamento.condutor IN FRAME fpage0 /* Condutor */
DO:
    {include/zoomvar.i &prog-zoom="prghur\cstzoom\cst0193z01.w"
                      &campo="ttAgendamento.condutor"
                      &campozoom="cdn_funcionario"
                      &frame="fpage0"
                      &campo2= c-condutor
                      &campozoom2= nom_pessoa_fisic
                      &frame2="fpage0"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ttAgendamento.condutor wMaintenanceNoNavigation
ON LEAVE OF ttAgendamento.condutor IN FRAME fpage0 /* Condutor */
DO:
  FIND FIRST funcionario
         WHERE funcionario.cdn_funcionario = int(ttAgendamento.condutor:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-LOCK NO-ERROR.

    IF AVAIL funcionario THEN DO:

        ASSIGN c-condutor:SCREEN-VALUE IN FRAME {&FRAME-NAME} = funcionario.nom_pessoa_fisic.
    end.
    ELSE DO:

        IF int(ttAgendamento.condutor:SCREEN-VALUE IN FRAME {&FRAME-NAME}) <> 0 then do:
            ASSIGN c-condutor:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Condutor nÆo existe".
            APPLY "entry":U TO ttAgendamento.condutor IN FRAME {&FRAME-NAME}.
        end.
        else do:
            ASSIGN c-condutor:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Condutor nÆo informado".
            APPLY "entry":U TO ttAgendamento.condutor IN FRAME {&FRAME-NAME}.
        end.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ttAgendamento.condutor wMaintenanceNoNavigation
ON MOUSE-SELECT-DBLCLICK OF ttAgendamento.condutor IN FRAME fpage0 /* Condutor */
DO:
   apply "f5" to self.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ttAgendamento.prev_hora_fin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ttAgendamento.prev_hora_fin wMaintenanceNoNavigation
ON LEAVE OF ttAgendamento.prev_hora_fin IN FRAME fpage0 /* Hora */
DO:

    def var c-hora-fin as char no-undo.
    
    assign 
       c-hora-fin = replace(INPUT FRAME fpage0 ttAgendamento.prev_hora_fin,":","").
    
    if (int(substring(c-hora-fin,1,2)) > 23 ) or
       (int(substring(c-hora-fin,3,2)) > 59 ) or
       (int(substring(c-hora-fin,5,2)) > 59 ) then do:
   
         MESSAGE "Digite o hor rio em formato v lido entre 00:00:00 e 23:59:59 !"
            VIEW-AS ALERT-BOX error BUTTONS OK.
        APPLY "entry":U TO ttAgendamento.prev_hora_fin IN FRAME fpage0.
        return no-apply.
    end.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ttAgendamento.prev_hora_inic
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ttAgendamento.prev_hora_inic wMaintenanceNoNavigation
ON LEAVE OF ttAgendamento.prev_hora_inic IN FRAME fpage0 /* Hora */
do:
    def var c-hora-ini as char no-undo.
    
    assign 
        c-hora-ini = replace(INPUT FRAME fpage0 ttAgendamento.prev_hora_inic,":","").
        
    if (int(substring(c-hora-ini,1,2)) > 23 ) or
       (int(substring(c-hora-ini,3,2)) > 59 ) or
       (int(substring(c-hora-ini,5,2)) > 59 ) then do:
    
        MESSAGE "Digite o hor rio em formato v lido entre 00:00:00 e 23:59:59 !"
            VIEW-AS ALERT-BOX error BUTTONS OK.
       
    APPLY "entry":U TO ttAgendamento.prev_hora_inic IN FRAME fpage0.
    return no-apply.
    end.
end.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wMaintenanceNoNavigation 


/*:T--- L¢gica para inicializa‡Æo do programam ---*/
{maintenancenonavigation/mainblock.i}

ttAgendamento.condutor:load-mouse-pointer ("image/lupa.cur") in frame {&frame-name}.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterDisplayFields wMaintenanceNoNavigation 
PROCEDURE afterDisplayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    apply "leave":U to ttAgendamento.condutor in frame fpage0.

    return "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterEnableFields wMaintenanceNoNavigation 
PROCEDURE afterEnableFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
do with frame fpage0:
    disable ttAgendamento.agendamento_id.
end.

return "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE beforeDisplayFields wMaintenanceNoNavigation 
PROCEDURE beforeDisplayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
if pcAction = "COPY" then 
   ttAgendamento.agendamento_id = next-value(seq_agendam_veic).




return "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE saveParentFields wMaintenanceNoNavigation 
PROCEDURE saveParentFields :
/*:T------------------------------------------------------------------------------
  Purpose:     Salva valores dos campos da tabela filho ({&ttTable}) com base 
               nos campos da tabela pai ({&ttParent})
  Parameters:  
  Notes:       Este m‚todo somente ‚ executado quando a vari vel pcAction 
               possuir os valores ADD ou COPY
------------------------------------------------------------------------------*/
    assign   ttAgendamento.placa = ttVeiculos.placa.
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

