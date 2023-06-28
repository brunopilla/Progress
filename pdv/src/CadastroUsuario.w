&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wUsuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wUsuario 
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

DEFINE TEMP-TABLE ttUsuario
    FIELD nome  AS CHARACTER
    FIELD email AS CHARACTER
    FIELD senha AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fUsuarios

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS filUsuNome filUsuEmail filUsuSenha btnSalvar ~
btnSair 
&Scoped-Define DISPLAYED-OBJECTS filUsuNome filUsuEmail filUsuSenha 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wUsuario AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnSair 
     LABEL "Sair" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnSalvar 
     LABEL "Salvar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE filUsuEmail AS CHARACTER FORMAT "X(256)":U 
     LABEL "E-mail" 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1 NO-UNDO.

DEFINE VARIABLE filUsuNome AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Nome" 
     VIEW-AS FILL-IN 
     SIZE 101 BY 1 NO-UNDO.

DEFINE VARIABLE filUsuSenha AS CHARACTER FORMAT "X(256)":U 
     LABEL "Senha" 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fUsuarios
     filUsuNome AT ROW 1.71 COL 8 COLON-ALIGNED WIDGET-ID 2
     filUsuEmail AT ROW 3.62 COL 8 COLON-ALIGNED WIDGET-ID 8
     filUsuSenha AT ROW 3.62 COL 71 COLON-ALIGNED WIDGET-ID 10 PASSWORD-FIELD 
     btnSalvar AT ROW 5.71 COL 5 WIDGET-ID 4
     btnSair AT ROW 5.71 COL 96 WIDGET-ID 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 113.4 BY 7.91
         TITLE "Cadastro de Usuário" WIDGET-ID 100.


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
  CREATE WINDOW wUsuario ASSIGN
         HIDDEN             = YES
         TITLE              = "Usuários"
         HEIGHT             = 7.38
         WIDTH              = 113.4
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 113.4
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 113.4
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
/* SETTINGS FOR WINDOW wUsuario
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fUsuarios
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wUsuario)
THEN wUsuario:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wUsuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wUsuario wUsuario
ON END-ERROR OF wUsuario /* Usuários */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wUsuario wUsuario
ON WINDOW-CLOSE OF wUsuario /* Usuários */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSair
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSair wUsuario
ON CHOOSE OF btnSair IN FRAME fUsuarios /* Sair */
DO:
  RUN sairUsu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSalvar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSalvar wUsuario
ON CHOOSE OF btnSalvar IN FRAME fUsuarios /* Salvar */
DO:
 RUN salvarUsu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wUsuario 


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wUsuario  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wUsuario)
  THEN DELETE WIDGET wUsuario.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wUsuario  _DEFAULT-ENABLE
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
  DISPLAY filUsuNome filUsuEmail filUsuSenha 
      WITH FRAME fUsuarios IN WINDOW wUsuario.
  ENABLE filUsuNome filUsuEmail filUsuSenha btnSalvar btnSair 
      WITH FRAME fUsuarios IN WINDOW wUsuario.
  {&OPEN-BROWSERS-IN-QUERY-fUsuarios}
  VIEW wUsuario.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sairUsu wUsuario 
PROCEDURE sairUsu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
apply "close":U to this-procedure.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE salvarUsu wUsuario 
PROCEDURE salvarUsu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
CREATE ttUsuario.
    ttUsuario.nome = filUsuNome:SCREEN-VALUE IN FRAME fUsuarios.
    ttUsuario.email = filUsuEmail:SCREEN-VALUE IN FRAME fUsuarios.
    ttUsuario.senha = filUsuSenha:SCREEN-VALUE IN FRAME fUsuarios.
    CREATE pdv.Usuarios.
    ASSIGN
        pdv.Usuarios.nome = ttUsuario.nome.
        pdv.Usuarios.email = ttUsuario.email.
        pdv.Usuarios.senha = ttUsuario.senha.
    MESSAGE "Usuário salvo com sucesso!" VIEW-AS ALERT-BOX INFORMATION.
    //CLEAR ttUsuario.
    filUsuNome:SCREEN-VALUE = "".
    filUsuEmail:SCREEN-VALUE = "".
    filUsuSenha:SCREEN-VALUE = "".
    DELETE ttUsuario.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

