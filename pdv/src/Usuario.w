&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          pdv              PROGRESS
*/
&Scoped-define WINDOW-NAME wUsuarios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wUsuarios 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fUsuarios

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES usuarios

/* Definitions for FRAME fUsuarios                                      */
&Scoped-define FIELDS-IN-QUERY-fUsuarios usuarios.id usuarios.nome ~
usuarios.email usuarios.senha 
&Scoped-define ENABLED-FIELDS-IN-QUERY-fUsuarios usuarios.id usuarios.nome ~
usuarios.email usuarios.senha 
&Scoped-define ENABLED-TABLES-IN-QUERY-fUsuarios usuarios
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-fUsuarios usuarios
&Scoped-define QUERY-STRING-fUsuarios FOR EACH usuarios SHARE-LOCK
&Scoped-define OPEN-QUERY-fUsuarios OPEN QUERY fUsuarios FOR EACH usuarios SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-fUsuarios usuarios
&Scoped-define FIRST-TABLE-IN-QUERY-fUsuarios usuarios


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS usuarios.id usuarios.nome usuarios.email ~
usuarios.senha 
&Scoped-define ENABLED-TABLES usuarios
&Scoped-define FIRST-ENABLED-TABLE usuarios
&Scoped-Define ENABLED-OBJECTS btnPrimeiro btnAnterior btnProximo btnUltimo ~
btnbuscar btnIncluir btnAlterar btnExcluir btnSair 
&Scoped-Define DISPLAYED-FIELDS usuarios.id usuarios.nome usuarios.email ~
usuarios.senha 
&Scoped-define DISPLAYED-TABLES usuarios
&Scoped-define FIRST-DISPLAYED-TABLE usuarios


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wUsuarios AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnAlterar 
     LABEL "Alterar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnAnterior 
     LABEL "<" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON btnbuscar 
     LABEL "Buscar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnExcluir 
     LABEL "Excluir" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnIncluir 
     LABEL "Incluir" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnPrimeiro 
     LABEL "|<" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON btnProximo 
     LABEL ">" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON btnSair 
     LABEL "Sair" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnUltimo 
     LABEL ">|" 
     SIZE 15 BY 1.14
     FONT 6.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY fUsuarios FOR 
      usuarios SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fUsuarios
     btnPrimeiro AT ROW 1.57 COL 3.6 WIDGET-ID 16
     btnAnterior AT ROW 1.57 COL 20.6 WIDGET-ID 10
     btnProximo AT ROW 1.57 COL 37.6 WIDGET-ID 12
     btnUltimo AT ROW 1.57 COL 54.8 WIDGET-ID 14
     btnbuscar AT ROW 1.57 COL 96 WIDGET-ID 26
     usuarios.id AT ROW 3.86 COL 7 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
     usuarios.nome AT ROW 3.86 COL 27.2 WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 78 BY 1
     usuarios.email AT ROW 6 COL 2.2 WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 54 BY 1
     usuarios.senha AT ROW 6 COL 64.6 WIDGET-ID 8 PASSWORD-FIELD 
          VIEW-AS FILL-IN 
          SIZE 40 BY 1
     btnIncluir AT ROW 8.05 COL 3.2 WIDGET-ID 18
     btnAlterar AT ROW 8.05 COL 20.2 WIDGET-ID 20
     btnExcluir AT ROW 8.05 COL 37.8 WIDGET-ID 24
     btnSair AT ROW 8.05 COL 96.2 WIDGET-ID 22
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 113 BY 9.76
         TITLE "Manutenção de Usuários" WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wUsuarios ASSIGN
         HIDDEN             = YES
         TITLE              = "Manutenção de Usuarios"
         HEIGHT             = 9.76
         WIDTH              = 113
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 116
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 116
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wUsuarios
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fUsuarios
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN usuarios.email IN FRAME fUsuarios
   ALIGN-L                                                              */
ASSIGN 
       usuarios.email:READ-ONLY IN FRAME fUsuarios        = TRUE.

ASSIGN 
       usuarios.id:READ-ONLY IN FRAME fUsuarios        = TRUE.

/* SETTINGS FOR FILL-IN usuarios.nome IN FRAME fUsuarios
   ALIGN-L                                                              */
ASSIGN 
       usuarios.nome:READ-ONLY IN FRAME fUsuarios        = TRUE.

/* SETTINGS FOR FILL-IN usuarios.senha IN FRAME fUsuarios
   ALIGN-L                                                              */
ASSIGN 
       usuarios.senha:READ-ONLY IN FRAME fUsuarios        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wUsuarios)
THEN wUsuarios:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fUsuarios
/* Query rebuild information for FRAME fUsuarios
     _TblList          = "pdv.usuarios"
     _Query            is OPENED
*/  /* FRAME fUsuarios */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wUsuarios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wUsuarios wUsuarios
ON END-ERROR OF wUsuarios /* Manutenção de Usuarios */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wUsuarios wUsuarios
ON WINDOW-CLOSE OF wUsuarios /* Manutenção de Usuarios */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAlterar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAlterar wUsuarios
ON CHOOSE OF btnAlterar IN FRAME fUsuarios /* Alterar */
DO:
  RUN editarUsu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAnterior
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAnterior wUsuarios
ON CHOOSE OF btnAnterior IN FRAME fUsuarios /* < */
DO:
  GET PREV fUsuarios.
  IF AVAILABLE Usuarios THEN 
    DISPLAY Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  ENABLE btnPrimeiro Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuarios.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnbuscar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnbuscar wUsuarios
ON CHOOSE OF btnbuscar IN FRAME fUsuarios /* Buscar */
DO:
  GET LAST fUsuarios.
  IF AVAILABLE Usuarios THEN 
    DISPLAY Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  ENABLE btnPrimeiro Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuarios.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnExcluir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnExcluir wUsuarios
ON CHOOSE OF btnExcluir IN FRAME fUsuarios /* Excluir */
DO:
   MESSAGE "Deseja Eliminar o Usuário?"
                SKIP(1)
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL
                TITLE "Confirma exclusão?" UPDATE escolha AS LOGICAL.
       IF escolha = YES THEN
           DO:    
               DELETE Usuarios.
               pdv.Usuarios.id:   SCREEN-VALUE = "".
               pdv.Usuarios.nome: SCREEN-VALUE = "".
               pdv.Usuarios.email:SCREEN-VALUE = "".
               pdv.Usuarios.senha:SCREEN-VALUE = "".
               MESSAGE "Usuário EXCLUÍDO com sucesso!" VIEW-AS ALERT-BOX INFORMATION.
           END.
       ELSE DO:
               RETURN NO-APPLY.
       END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnIncluir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnIncluir wUsuarios
ON CHOOSE OF btnIncluir IN FRAME fUsuarios /* Incluir */
DO:
    RUN chamarCad.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrimeiro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrimeiro wUsuarios
ON CHOOSE OF btnPrimeiro IN FRAME fUsuarios /* |< */
DO:
  GET FIRST fUsuarios.
  IF AVAILABLE Usuarios THEN 
    DISPLAY Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  ENABLE btnPrimeiro Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha  
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuarios.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnProximo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnProximo wUsuarios
ON CHOOSE OF btnProximo IN FRAME fUsuarios /* > */
DO:
  GET NEXT fUsuarios.
  IF AVAILABLE Usuarios THEN 
    DISPLAY Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  ENABLE Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuarios.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSair
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSair wUsuarios
ON CHOOSE OF btnSair IN FRAME fUsuarios /* Sair */
DO:
  apply "close":U to this-procedure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnUltimo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnUltimo wUsuarios
ON CHOOSE OF btnUltimo IN FRAME fUsuarios /* >| */
DO:
  GET LAST fUsuarios.
  IF AVAILABLE Usuarios THEN 
    DISPLAY Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  ENABLE btnPrimeiro Usuarios.id Usuarios.nome Usuarios.email Usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuarios.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wUsuarios 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE chamarCad wUsuarios 
PROCEDURE chamarCad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN CadastroUsuario.w.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wUsuarios  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wUsuarios)
  THEN DELETE WIDGET wUsuarios.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE editarUsu wUsuarios 
PROCEDURE editarUsu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wUsuarios  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/

  {&OPEN-QUERY-fUsuarios}
  GET FIRST fUsuarios.
  IF AVAILABLE usuarios THEN 
    DISPLAY usuarios.id usuarios.nome usuarios.email usuarios.senha 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  ENABLE btnPrimeiro btnAnterior btnProximo btnUltimo btnbuscar usuarios.id 
         usuarios.nome usuarios.email usuarios.senha btnIncluir btnAlterar 
         btnExcluir btnSair 
      WITH FRAME fUsuarios IN WINDOW wUsuarios.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuarios.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE excluirUsuario wUsuarios 
PROCEDURE excluirUsuario :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

