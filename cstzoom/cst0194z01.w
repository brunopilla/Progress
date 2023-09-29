&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          emscustom        PROGRESS
*/
&Scoped-define WINDOW-NAME wZoom


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE ttVeiculos1 NO-UNDO LIKE cst_veiculos
       field r-rowid as rowid.
DEFINE TEMP-TABLE ttVeiculos2 NO-UNDO LIKE cst_veiculos
       field r-rowid as rowid.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wZoom 
/*:T*******************************************************************************
** Copyright TOTVS S.A. (2009)
** Todos os Direitos Reservados.
**
** Este fonte e de propriedade exclusiva da TOTVS, sua reproducao
** parcial ou total por qualquer meio, so podera ser feita mediante
** autorizacao expressa.
*******************************************************************************/
{include/i-prgvrs.i cst0194z01 2023.00.00.001}

/* Chamada a include do gerenciador de licen‡as. Necessario alterar os parametros */
/*                                                                                */
/* <programa>:  Informar qual o nome do programa.                                 */
/* <m¢dulo>:  Informar qual o m¢dulo a qual o programa pertence.                  */

&IF "{&EMSFND_VERSION}" >= "1.00" &THEN
    {include/i-license-manager.i cst0194z01 MUT}
&ENDIF

CREATE WIDGET-POOL.

/* Preprocessors Definitions ---                                      */
&GLOBAL-DEFINE Program           cst0194z01
&GLOBAL-DEFINE Version           2023.00.00.001

&GLOBAL-DEFINE InitialPage       1
&GLOBAL-DEFINE FolderLabels      Placa,Modelo

&GLOBAL-DEFINE Range             YES

&GLOBAL-DEFINE FieldsRangePage1  emscustom.cst_veiculos.placa
&GLOBAL-DEFINE FieldsRangePage2  emscustom.cst_veiculos.modelo
/* &GLOBAL-DEFINE FieldsRangePage3  <Field1,Field2,...,FieldN> */
/* &GLOBAL-DEFINE FieldsRangePage4  <Field1,Field2,...,FieldN> */
/* &GLOBAL-DEFINE FieldsRangePage5  <Field1,Field2,...,FieldN> */
/* &GLOBAL-DEFINE FieldsRangePage6  <Field1,Field2,...,FieldN> */
/* &GLOBAL-DEFINE FieldsRangePage7  <Field1,Field2,...,FieldN> */
/* &GLOBAL-DEFINE FieldsRangePage8  <Field1,Field2,...,FieldN> */
&GLOBAL-DEFINE FieldsAnyKeyPage1 YES
&GLOBAL-DEFINE FieldsAnyKeyPage2 YES
/* &GLOBAL-DEFINE FieldsAnyKeyPage3 <YES,YES,...,YES> */
/* &GLOBAL-DEFINE FieldsAnyKeyPage4 <YES,YES,...,YES> */
/* &GLOBAL-DEFINE FieldsAnyKeyPage5 <YES,YES,...,YES> */
/* &GLOBAL-DEFINE FieldsAnyKeyPage6 <YES,YES,...,YES> */
/* &GLOBAL-DEFINE FieldsAnyKeyPage7 <YES,YES,...,YES> */
/* &GLOBAL-DEFINE FieldsAnyKeyPage8 <YES,YES,...,YES> */

&GLOBAL-DEFINE ttTable1          ttVeiculos1
&GLOBAL-DEFINE hDBOTable1        hBOVeiculos1
&GLOBAL-DEFINE DBOTable1         Veiculos

&GLOBAL-DEFINE ttTable2          ttVeiculos2
&GLOBAL-DEFINE hDBOTable2        hBOVeiculos2
&GLOBAL-DEFINE DBOTable2         Veiculos

&GLOBAL-DEFINE page1Browse       brTable1
&GLOBAL-DEFINE page2Browse       brTable2

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* Local Variable Definitions (DBOs Handles) --- */
DEFINE VARIABLE {&hDBOTable1} AS HANDLE NO-UNDO.
DEFINE VARIABLE {&hDBOTable2} AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Zoom
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fpage0
&Scoped-define BROWSE-NAME brTable1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ttVeiculos1 ttVeiculos2

/* Definitions for BROWSE brTable1                                      */
&Scoped-define FIELDS-IN-QUERY-brTable1 ttVeiculos1.placa ttVeiculos1.marca ~
ttVeiculos1.modelo ttVeiculos1.ano ttVeiculos1.cor ttVeiculos1.renavam ~
ttVeiculos1.km ttVeiculos1.proprietario ttVeiculos1.observacoes ~
ttVeiculos1.disponivel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTable1 
&Scoped-define QUERY-STRING-brTable1 FOR EACH ttVeiculos1 ~
      WHERE ttVeiculos1.ativo = TRUE NO-LOCK
&Scoped-define OPEN-QUERY-brTable1 OPEN QUERY brTable1 FOR EACH ttVeiculos1 ~
      WHERE ttVeiculos1.ativo = TRUE NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brTable1 ttVeiculos1
&Scoped-define FIRST-TABLE-IN-QUERY-brTable1 ttVeiculos1


/* Definitions for BROWSE brTable2                                      */
&Scoped-define FIELDS-IN-QUERY-brTable2 ttVeiculos2.placa ttVeiculos2.marca ~
ttVeiculos2.modelo ttVeiculos2.ano ttVeiculos2.cor ttVeiculos2.renavam ~
ttVeiculos2.proprietario ttVeiculos2.km ttVeiculos2.disponivel ~
ttVeiculos2.observacoes 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTable2 
&Scoped-define QUERY-STRING-brTable2 FOR EACH ttVeiculos2 ~
      WHERE ttVeiculos2.ativo = TRUE NO-LOCK
&Scoped-define OPEN-QUERY-brTable2 OPEN QUERY brTable2 FOR EACH ttVeiculos2 ~
      WHERE ttVeiculos2.ativo = TRUE NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brTable2 ttVeiculos2
&Scoped-define FIRST-TABLE-IN-QUERY-brTable2 ttVeiculos2


/* Definitions for FRAME fPage1                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage1 ~
    ~{&OPEN-QUERY-brTable1}

/* Definitions for FRAME fPage2                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage2 ~
    ~{&OPEN-QUERY-brTable2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rtToolBar btOK btCancel btHelp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wZoom AS WIDGET-HANDLE NO-UNDO.

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

DEFINE RECTANGLE rtToolBar
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 90 BY 1.42
     BGCOLOR 7 .

DEFINE BUTTON btImplant1 
     LABEL "Implantar" 
     SIZE 10 BY 1.

DEFINE BUTTON btImplant2 
     LABEL "Implantar" 
     SIZE 10 BY 1.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brTable1 FOR 
      ttVeiculos1 SCROLLING.

DEFINE QUERY brTable2 FOR 
      ttVeiculos2 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brTable1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTable1 wZoom _STRUCTURED
  QUERY brTable1 NO-LOCK DISPLAY
      ttVeiculos1.placa FORMAT "x(12)":U
      ttVeiculos1.marca FORMAT "x(20)":U
      ttVeiculos1.modelo FORMAT "x(40)":U
      ttVeiculos1.ano FORMAT ">>>9":U
      ttVeiculos1.cor FORMAT "x(20)":U
      ttVeiculos1.renavam FORMAT "X(16)":U
      ttVeiculos1.km FORMAT "->,>>>,>>9":U
      ttVeiculos1.proprietario FORMAT "x(40)":U
      ttVeiculos1.observacoes FORMAT "x(200)":U
      ttVeiculos1.disponivel FORMAT "SIM/NÇO":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 82 BY 10.67
         FONT 2.

DEFINE BROWSE brTable2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTable2 wZoom _STRUCTURED
  QUERY brTable2 NO-LOCK DISPLAY
      ttVeiculos2.placa FORMAT "x(12)":U
      ttVeiculos2.marca FORMAT "x(20)":U
      ttVeiculos2.modelo FORMAT "x(40)":U
      ttVeiculos2.ano FORMAT ">>>9":U
      ttVeiculos2.cor FORMAT "x(20)":U
      ttVeiculos2.renavam FORMAT "X(16)":U
      ttVeiculos2.proprietario FORMAT "x(40)":U
      ttVeiculos2.km FORMAT "->,>>>,>>9":U
      ttVeiculos2.disponivel FORMAT "SIM/NÇO":U
      ttVeiculos2.observacoes FORMAT "x(200)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 82 BY 10.67
         FONT 2.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fpage0
     btOK AT ROW 16.71 COL 2
     btCancel AT ROW 16.71 COL 13
     btHelp AT ROW 16.71 COL 80
     rtToolBar AT ROW 16.5 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 90 BY 16.98
         FONT 1 WIDGET-ID 100.

DEFINE FRAME fPage1
     brTable1 AT ROW 2.33 COL 2
     btImplant1 AT ROW 13 COL 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3.5 ROW 2.45
         SIZE 84.43 BY 13.29
         FONT 1 WIDGET-ID 100.

DEFINE FRAME fPage2
     brTable2 AT ROW 2.33 COL 2
     btImplant2 AT ROW 13 COL 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3.57 ROW 2.45
         SIZE 84.43 BY 13.29
         FONT 1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Zoom
   Allow: Basic,Browse,DB-Fields,Window,Query
   Add Fields to: Neither
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: ttVeiculos1 T "?" NO-UNDO emscustom cst_veiculos
      ADDITIONAL-FIELDS:
          field r-rowid as rowid
      END-FIELDS.
      TABLE: ttVeiculos2 T "?" NO-UNDO emscustom cst_veiculos
      ADDITIONAL-FIELDS:
          field r-rowid as rowid
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wZoom ASSIGN
         HIDDEN             = YES
         TITLE              = ""
         HEIGHT             = 17
         WIDTH              = 90
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 90
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 90
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wZoom 
/* ************************* Included-Libraries *********************** */

{zoom/zoom.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wZoom
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* REPARENT FRAME */
ASSIGN FRAME fPage1:FRAME = FRAME fpage0:HANDLE
       FRAME fPage2:FRAME = FRAME fpage0:HANDLE.

/* SETTINGS FOR FRAME fpage0
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME fPage1
                                                                        */
/* BROWSE-TAB brTable1 1 fPage1 */
/* SETTINGS FOR FRAME fPage2
                                                                        */
/* BROWSE-TAB brTable2 1 fPage2 */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wZoom)
THEN wZoom:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTable1
/* Query rebuild information for BROWSE brTable1
     _TblList          = "Temp-Tables.ttVeiculos1"
     _Options          = "NO-LOCK"
     _Where[1]         = "Temp-Tables.ttVeiculos1.ativo = TRUE"
     _FldNameList[1]   = Temp-Tables.ttVeiculos1.placa
     _FldNameList[2]   = Temp-Tables.ttVeiculos1.marca
     _FldNameList[3]   = Temp-Tables.ttVeiculos1.modelo
     _FldNameList[4]   = Temp-Tables.ttVeiculos1.ano
     _FldNameList[5]   = Temp-Tables.ttVeiculos1.cor
     _FldNameList[6]   = Temp-Tables.ttVeiculos1.renavam
     _FldNameList[7]   = Temp-Tables.ttVeiculos1.km
     _FldNameList[8]   = Temp-Tables.ttVeiculos1.proprietario
     _FldNameList[9]   = Temp-Tables.ttVeiculos1.observacoes
     _FldNameList[10]   > Temp-Tables.ttVeiculos1.disponivel
"disponivel" ? "SIM/NÇO" "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brTable1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTable2
/* Query rebuild information for BROWSE brTable2
     _TblList          = "Temp-Tables.ttVeiculos2"
     _Options          = "NO-LOCK"
     _Where[1]         = "Temp-Tables.ttVeiculos2.ativo = TRUE"
     _FldNameList[1]   = Temp-Tables.ttVeiculos2.placa
     _FldNameList[2]   = Temp-Tables.ttVeiculos2.marca
     _FldNameList[3]   = Temp-Tables.ttVeiculos2.modelo
     _FldNameList[4]   = Temp-Tables.ttVeiculos2.ano
     _FldNameList[5]   = Temp-Tables.ttVeiculos2.cor
     _FldNameList[6]   = Temp-Tables.ttVeiculos2.renavam
     _FldNameList[7]   = Temp-Tables.ttVeiculos2.proprietario
     _FldNameList[8]   = Temp-Tables.ttVeiculos2.km
     _FldNameList[9]   > Temp-Tables.ttVeiculos2.disponivel
"disponivel" ? "SIM/NÇO" "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   = Temp-Tables.ttVeiculos2.observacoes
     _Query            is OPENED
*/  /* BROWSE brTable2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fpage0
/* Query rebuild information for FRAME fpage0
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME fpage0 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fPage1
/* Query rebuild information for FRAME fPage1
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME fPage1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fPage2
/* Query rebuild information for FRAME fPage2
     _Query            is NOT OPENED
*/  /* FRAME fPage2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wZoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wZoom wZoom
ON END-ERROR OF wZoom
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wZoom wZoom
ON WINDOW-CLOSE OF wZoom
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel wZoom
ON CHOOSE OF btCancel IN FRAME fpage0 /* Cancelar */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btHelp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btHelp wZoom
ON CHOOSE OF btHelp IN FRAME fpage0 /* Ajuda */
DO:
    {include/ajuda.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btImplant1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btImplant1 wZoom
ON CHOOSE OF btImplant1 IN FRAME fPage1 /* Implantar */
DO:
    {zoom/implant.i &ProgramImplant="cstp/cspt019a.w"
                    &PageNumber="1"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btImplant2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btImplant2 wZoom
ON CHOOSE OF btImplant2 IN FRAME fPage2 /* Implantar */
DO:
    {zoom/implant.i &ProgramImplant="cstp/cspt019a.w"
                    &PageNumber="2"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fpage0
&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK wZoom
ON CHOOSE OF btOK IN FRAME fpage0 /* OK */
DO:
    RUN returnValues IN THIS-PROCEDURE.
    
    APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brTable1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wZoom 


/* ***************************  Main Block  *************************** */

/*:T--- L¢gica para inicializa‡Æo do programam ---*/
{zoom/mainblock.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeDBOs wZoom 
PROCEDURE initializeDBOs :
/*:T------------------------------------------------------------------------------
  Purpose:     Inicializa DBOs
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

    
    /*:T--- Verifica se o DBO j  est  inicializado ---*/
    IF NOT VALID-HANDLE({&hDBOTable1}) OR
       {&hDBOTable1}:TYPE <> "PROCEDURE":U OR
       {&hDBOTable1}:FILE-NAME <> "cstbo/bocst0194.p":U THEN DO:
       
        {btb/btb008za.i1 cstbo/bocst0194.p YES}
        {btb/btb008za.i2 cstbo/bocst0194.p '' {&hDBOTable1}} 
    END.
    
   // RUN setConstraint<Description> IN {&hDBOTable1} (<pamameters>) NO-ERROR.
    
    /*:T--- Verifica se o DBO j  est  inicializado ---*/
    IF NOT VALID-HANDLE({&hDBOTable2}) OR
       {&hDBOTable2}:TYPE <> "PROCEDURE":U OR
       {&hDBOTable2}:FILE-NAME <> "cstbo/bocst0194.p":U THEN DO:
       
        {btb/btb008za.i1 cstbo/bocst0194.p YES}
        {btb/btb008za.i2 cstbo/bocst0194.p '' {&hDBOTable2}} 
    END.
    
   // RUN setConstraint<Description> IN {&hDBOTable2} (<pamameters>) NO-ERROR.
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE openQueries wZoom 
PROCEDURE openQueries :
/*:T------------------------------------------------------------------------------
  Purpose:     Atualiza browsers
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
    
    {zoom/openqueries.i &Query="Placa"
                        &PageNumber="1"}
    
    {zoom/openqueries.i &Query="Modelo"
                        &PageNumber="2"}
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE returnFieldsPage1 wZoom 
PROCEDURE returnFieldsPage1 :
/*:T------------------------------------------------------------------------------
  Purpose:     Retorna valores dos campos da p gina 1
  Parameters:  recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
   
    DEFINE  INPUT PARAMETER pcField      AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pcFieldValue AS CHARACTER NO-UNDO.
    
    IF AVAILABLE {&ttTable1} THEN DO:
        CASE pcField:
            WHEN "ano":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.ano).
            WHEN "cor":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.cor).
            WHEN "disponivel":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.disponivel).
            WHEN "km":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.km).
            WHEN "marca":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.marca).
            WHEN "modelo":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.modelo).
            WHEN "observacoes":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.observacoes).
            WHEN "proprietario":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.proprietario).
            WHEN "renavam":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.renavam).
             WHEN "placa":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable1}.placa).
        END CASE.
    END.
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE returnFieldsPage2 wZoom 
PROCEDURE returnFieldsPage2 :
/*:T------------------------------------------------------------------------------
  Purpose:     Retorna valores dos campos da p gina 2
  Parameters:  recebe nome do campo
               retorna valor do campo
  Notes:       
------------------------------------------------------------------------------*/
    
    DEFINE  INPUT PARAMETER pcField      AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pcFieldValue AS CHARACTER NO-UNDO.
    
   IF AVAILABLE {&ttTable2} THEN DO:
        CASE pcField:
            WHEN "ano":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.ano).
            WHEN "cor":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.cor).
            WHEN "disponivel":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.disponivel).
            WHEN "km":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.km).
            WHEN "marca":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.marca).
            WHEN "modelo":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.modelo).
            WHEN "observacoes":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.observacoes).
            WHEN "proprietario":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.proprietario).
            WHEN "renavam":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.renavam).
             WHEN "placa":U THEN
                ASSIGN pcFieldValue = STRING({&ttTable2}.placa).
        END CASE.
    END.
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setConstraints wZoom 
PROCEDURE setConstraints :
/*:T------------------------------------------------------------------------------
  Purpose:     Seta constraints e atualiza o browse, conforme n£mero da p gina
               passado como parƒmetro
  Parameters:  recebe n£mero da p gina
  Notes:       
------------------------------------------------------------------------------*/
    
    DEFINE INPUT PARAMETER pPageNumber AS INTEGER NO-UNDO.
    
    /*:T--- Seta constraints conforme n£mero da p gina ---*/
    CASE pPageNumber:
        WHEN 1 THEN
            /*:T--- Seta Constraints para o DBO Table1 ---*/
            RUN setConstraintPlaca IN {&hDBOTable1} (INPUT FnIniRangeCharPage(input 1,input 1),
                                                     INPUT FnEndRangeCharPage(input 1,input 1)).
                                                               
        WHEN 2 THEN
            /*:T--- Seta Constraints para o DBO Table2 ---*/
            RUN setConstraintModelo IN {&hDBOTable2} (INPUT FnIniRangeCharPage(input 2,input 1),
                                                      INPUT FnEndRangeCharPage(input 2,input 1)).
    END CASE.
    
    /*:T--- Seta vari vel iConstraintPageNumber com o n£mero da p gina atual 
          Esta vari vel ‚ utilizada no m‚todo openQueries ---*/
    ASSIGN iConstraintPageNumber = pPageNumber.
    
    /*:T--- Atualiza browse ---*/
    RUN openQueries IN THIS-PROCEDURE.
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

