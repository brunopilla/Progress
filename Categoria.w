&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          pdv              PROGRESS
*/
&Scoped-define WINDOW-NAME wCategorias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wCategorias 
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
&Scoped-define FRAME-NAME fCategorias

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Categorias

/* Definitions for FRAME fCategorias                                    */
&Scoped-define FIELDS-IN-QUERY-fCategorias Categorias.id ~
Categorias.descricao 
&Scoped-define ENABLED-FIELDS-IN-QUERY-fCategorias Categorias.id ~
Categorias.descricao 
&Scoped-define ENABLED-TABLES-IN-QUERY-fCategorias Categorias
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-fCategorias Categorias
&Scoped-define QUERY-STRING-fCategorias FOR EACH Categorias SHARE-LOCK
&Scoped-define OPEN-QUERY-fCategorias OPEN QUERY fCategorias FOR EACH Categorias SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-fCategorias Categorias
&Scoped-define FIRST-TABLE-IN-QUERY-fCategorias Categorias


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Categorias.id Categorias.descricao 
&Scoped-define ENABLED-TABLES Categorias
&Scoped-define FIRST-ENABLED-TABLE Categorias
&Scoped-Define ENABLED-OBJECTS btnPrimeiro btnAnterior btnProximo btnUltimo ~
btnSalvar btnDelete btnCancelar 
&Scoped-Define DISPLAYED-FIELDS Categorias.id Categorias.descricao 
&Scoped-define DISPLAYED-TABLES Categorias
&Scoped-define FIRST-DISPLAYED-TABLE Categorias


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wCategorias AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnAnterior 
     LABEL "<" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON btnCancelar 
     LABEL "Sair" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnDelete 
     LABEL "Excluir" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnPrimeiro 
     LABEL "|<" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON btnProximo 
     LABEL ">" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON btnSalvar 
     LABEL "Incluir" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnUltimo 
     LABEL ">|" 
     SIZE 15 BY 1.14
     FONT 6.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY fCategorias FOR 
      Categorias SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fCategorias
     btnPrimeiro AT ROW 1.95 COL 4 WIDGET-ID 6
     btnAnterior AT ROW 1.95 COL 22.6 WIDGET-ID 10
     btnProximo AT ROW 1.95 COL 41.2 WIDGET-ID 12
     btnUltimo AT ROW 1.95 COL 60 WIDGET-ID 14
     Categorias.id AT ROW 4.1 COL 13 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 10.4 BY 1
     Categorias.descricao AT ROW 5.76 COL 13 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 60 BY 1
     btnSalvar AT ROW 7.67 COL 6 WIDGET-ID 18
     btnDelete AT ROW 7.67 COL 23 WIDGET-ID 20
     btnCancelar AT ROW 7.67 COL 61 WIDGET-ID 22
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 9.76
         TITLE "Categorias"
         DEFAULT-BUTTON btnDelete CANCEL-BUTTON btnCancelar WIDGET-ID 100.


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
  CREATE WINDOW wCategorias ASSIGN
         HIDDEN             = YES
         TITLE              = "Categorias"
         HEIGHT             = 9.76
         WIDTH              = 80
         MAX-HEIGHT         = 48.29
         MAX-WIDTH          = 384
         VIRTUAL-HEIGHT     = 48.29
         VIRTUAL-WIDTH      = 384
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
/* SETTINGS FOR WINDOW wCategorias
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fCategorias
   FRAME-NAME                                                           */
ASSIGN 
       Categorias.descricao:READ-ONLY IN FRAME fCategorias        = TRUE.

ASSIGN 
       Categorias.id:READ-ONLY IN FRAME fCategorias        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wCategorias)
THEN wCategorias:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fCategorias
/* Query rebuild information for FRAME fCategorias
     _TblList          = "pdv.Categorias"
     _Query            is OPENED
*/  /* FRAME fCategorias */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wCategorias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wCategorias wCategorias
ON END-ERROR OF wCategorias /* Categorias */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wCategorias wCategorias
ON WINDOW-CLOSE OF wCategorias /* Categorias */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAnterior
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAnterior wCategorias
ON CHOOSE OF btnAnterior IN FRAME fCategorias /* < */
DO:
  GET PREV fCategorias.
  IF AVAILABLE Categorias THEN 
    DISPLAY Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  ENABLE btnPrimeiro Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  {&OPEN-BROWSERS-IN-QUERY-fCategorias}
  VIEW wCategorias.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancelar wCategorias
ON CHOOSE OF btnCancelar IN FRAME fCategorias /* Sair */
DO:
  apply "close":U to this-procedure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDelete wCategorias
ON CHOOSE OF btnDelete IN FRAME fCategorias /* Excluir */
DO:
   message "Deseja Eliminar o Item?"
                skip(1)
                view-as alert-box question buttons yes-no
                title "" update choice as logical.

        case choice:
            when true then do: /* Yes */
                DELETE Categorias.
                pdv.Categorias.id:SCREEN-VALUE = "".
                pdv.Categorias.descricao:SCREEN-VALUE = "".
                MESSAGE "Categoria excluída com sucesso!" VIEW-AS ALERT-BOX INFORMATION.
            end.
            when false then do: /* No */
                return no-apply.
            end.
            otherwise /* Cancel */
                return no-apply.
        end case.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrimeiro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrimeiro wCategorias
ON CHOOSE OF btnPrimeiro IN FRAME fCategorias /* |< */
DO:
  GET FIRST fCategorias.
  IF AVAILABLE Categorias THEN 
    DISPLAY Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  ENABLE btnPrimeiro Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  {&OPEN-BROWSERS-IN-QUERY-fCategorias}
  VIEW wCategorias.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnProximo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnProximo wCategorias
ON CHOOSE OF btnProximo IN FRAME fCategorias /* > */
DO:
  GET NEXT fCategorias.
  IF AVAILABLE Categorias THEN 
    DISPLAY Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  ENABLE btnPrimeiro Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  {&OPEN-BROWSERS-IN-QUERY-fCategorias}
  VIEW wCategorias.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSalvar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSalvar wCategorias
ON CHOOSE OF btnSalvar IN FRAME fCategorias /* Incluir */
DO:
 RUN chamarCad.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnUltimo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnUltimo wCategorias
ON CHOOSE OF btnUltimo IN FRAME fCategorias /* >| */
DO:
  GET LAST fCategorias.
  IF AVAILABLE Categorias THEN 
    DISPLAY Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  ENABLE btnPrimeiro Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  {&OPEN-BROWSERS-IN-QUERY-fCategorias}
  VIEW wCategorias.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wCategorias 


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE chamarCad wCategorias 
PROCEDURE chamarCad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN CadastroCategoria.r.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criarCat wCategorias 
PROCEDURE criarCat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
REPEAT:
    INSERT Categorias WITH 2 COLUMNS.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wCategorias  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wCategorias)
  THEN DELETE WIDGET wCategorias.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wCategorias  _DEFAULT-ENABLE
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

  {&OPEN-QUERY-fCategorias}
  GET FIRST fCategorias.
  IF AVAILABLE Categorias THEN 
    DISPLAY Categorias.id Categorias.descricao 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  ENABLE btnPrimeiro btnAnterior btnProximo btnUltimo Categorias.id 
         Categorias.descricao btnSalvar btnDelete btnCancelar 
      WITH FRAME fCategorias IN WINDOW wCategorias.
  {&OPEN-BROWSERS-IN-QUERY-fCategorias}
  VIEW wCategorias.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE excluirCat wCategorias 
PROCEDURE excluirCat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

