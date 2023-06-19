&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          test             PROGRESS
*/
&Scoped-define WINDOW-NAME CustWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS CustWin 
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
&Scoped-define FRAME-NAME CustQuerry
&Scoped-define BROWSE-NAME OrderBrowse

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Customer Order

/* Definitions for BROWSE OrderBrowse                                   */
&Scoped-define FIELDS-IN-QUERY-OrderBrowse Order.Ordernum Order.OrderDate ~
Order.PromiseDate Order.ShipDate Order.PO 
&Scoped-define ENABLED-FIELDS-IN-QUERY-OrderBrowse 
&Scoped-define QUERY-STRING-OrderBrowse FOR EACH Order OF Customer NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-OrderBrowse OPEN QUERY OrderBrowse FOR EACH Order OF Customer NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-OrderBrowse Order
&Scoped-define FIRST-TABLE-IN-QUERY-OrderBrowse Order


/* Definitions for FRAME CustQuerry                                     */
&Scoped-define FIELDS-IN-QUERY-CustQuerry Customer.CustNum Customer.Name ~
Customer.Address Customer.State Customer.City 
&Scoped-define ENABLED-FIELDS-IN-QUERY-CustQuerry Customer.CustNum ~
Customer.Name Customer.Address Customer.State Customer.City 
&Scoped-define ENABLED-TABLES-IN-QUERY-CustQuerry Customer
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-CustQuerry Customer
&Scoped-define OPEN-BROWSERS-IN-QUERY-CustQuerry ~
    ~{&OPEN-QUERY-OrderBrowse}
&Scoped-define QUERY-STRING-CustQuerry FOR EACH Customer ~
      WHERE Customer.State = "NH" SHARE-LOCK ~
    BY Customer.City
&Scoped-define OPEN-QUERY-CustQuerry OPEN QUERY CustQuerry FOR EACH Customer ~
      WHERE Customer.State = "NH" SHARE-LOCK ~
    BY Customer.City.
&Scoped-define TABLES-IN-QUERY-CustQuerry Customer
&Scoped-define FIRST-TABLE-IN-QUERY-CustQuerry Customer


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Customer.CustNum Customer.Name ~
Customer.Address Customer.State Customer.City 
&Scoped-define ENABLED-TABLES Customer
&Scoped-define FIRST-ENABLED-TABLE Customer
&Scoped-Define ENABLED-OBJECTS btnFirst OrderBrowse 
&Scoped-Define DISPLAYED-FIELDS Customer.CustNum Customer.Name ~
Customer.Address Customer.State Customer.City 
&Scoped-define DISPLAYED-TABLES Customer
&Scoped-define FIRST-DISPLAYED-TABLE Customer


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR CustWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnFirst 
     LABEL "Primeiro" 
     SIZE 15 BY 1.13.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY OrderBrowse FOR 
      Order SCROLLING.

DEFINE QUERY CustQuerry FOR 
      Customer SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE OrderBrowse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS OrderBrowse CustWin _STRUCTURED
  QUERY OrderBrowse NO-LOCK DISPLAY
      Order.Ordernum COLUMN-LABEL "N§ Pedido" FORMAT "zzzzzzzzz9":U
            WIDTH 14.43
      Order.OrderDate COLUMN-LABEL "Data Pedido" FORMAT "99/99/99":U
            WIDTH 13.43
      Order.PromiseDate COLUMN-LABEL "Prev. Entrega" FORMAT "99/99/99":U
            WIDTH 15.43
      Order.ShipDate COLUMN-LABEL "Data Entrega" FORMAT "99/99/9999":U
            WIDTH 14.43
      Order.PO FORMAT "x(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 74 BY 7 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME CustQuerry
     btnFirst AT ROW 2.25 COL 2 WIDGET-ID 14
     Customer.CustNum AT ROW 4.5 COL 11.29 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 6.86 BY 1
     Customer.Name AT ROW 4.5 COL 41 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 31.14 BY 1
     Customer.Address AT ROW 6.42 COL 11 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 61.14 BY 1
     Customer.State AT ROW 8.33 COL 51 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 21.14 BY 1
     Customer.City AT ROW 8.42 COL 11.14 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 26.14 BY 1
     OrderBrowse AT ROW 10.75 COL 3 WIDGET-ID 200
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 82.86 BY 18.08 WIDGET-ID 100.


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
  CREATE WINDOW CustWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Clientes e Pedidos"
         HEIGHT             = 18.08
         WIDTH              = 82.86
         MAX-HEIGHT         = 42.25
         MAX-WIDTH          = 274.29
         VIRTUAL-HEIGHT     = 42.25
         VIRTUAL-WIDTH      = 274.29
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
/* SETTINGS FOR WINDOW CustWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME CustQuerry
   FRAME-NAME                                                           */
/* BROWSE-TAB OrderBrowse City CustQuerry */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(CustWin)
THEN CustWin:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME CustQuerry
/* Query rebuild information for FRAME CustQuerry
     _TblList          = "test.Customer"
     _OrdList          = "test.Customer.City|yes"
     _Where[1]         = "test.Customer.State = ""NH"""
     _Query            is OPENED
*/  /* FRAME CustQuerry */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE OrderBrowse
/* Query rebuild information for BROWSE OrderBrowse
     _TblList          = "test.Order OF test.Customer"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > test.Order.Ordernum
"Order.Ordernum" "N§ Pedido" ? "integer" ? ? ? ? ? ? no ? no no "14.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > test.Order.OrderDate
"Order.OrderDate" "Data Pedido" ? "date" ? ? ? ? ? ? no ? no no "13.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > test.Order.PromiseDate
"Order.PromiseDate" "Prev. Entrega" ? "date" ? ? ? ? ? ? no ? no no "15.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > test.Order.ShipDate
"Order.ShipDate" "Data Entrega" ? "date" ? ? ? ? ? ? no ? no no "14.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = test.Order.PO
     _Query            is OPENED
*/  /* BROWSE OrderBrowse */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME CustWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CustWin CustWin
ON END-ERROR OF CustWin /* Clientes e Pedidos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CustWin CustWin
ON WINDOW-CLOSE OF CustWin /* Clientes e Pedidos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst CustWin
ON CHOOSE OF btnFirst IN FRAME CustQuerry /* Primeiro */
DO:
  GET FIRST CustQuerry.
  IF AVAILABLE Customer THEN 
    DISPLAY Customer.CustNum Customer.Name Customer.Address Customer.State 
          Customer.City 
      WITH FRAME CustQuerry IN WINDOW CustWin.
  {&OPEN-BROWSERS-IN-QUERY-CustQuery}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME OrderBrowse
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK CustWin 


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI CustWin  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(CustWin)
  THEN DELETE WIDGET CustWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI CustWin  _DEFAULT-ENABLE
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

  {&OPEN-QUERY-CustQuerry}
  GET FIRST CustQuerry.
  IF AVAILABLE Customer THEN 
    DISPLAY Customer.CustNum Customer.Name Customer.Address Customer.State 
          Customer.City 
      WITH FRAME CustQuerry IN WINDOW CustWin.
  ENABLE btnFirst Customer.CustNum Customer.Name Customer.Address 
         Customer.State Customer.City OrderBrowse 
      WITH FRAME CustQuerry IN WINDOW CustWin.
  {&OPEN-BROWSERS-IN-QUERY-CustQuerry}
  VIEW CustWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

