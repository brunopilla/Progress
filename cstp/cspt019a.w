&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          emscustom        PROGRESS
*/
&Scoped-define WINDOW-NAME wMaintenanceNoNavigation


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE ttVeiculos NO-UNDO LIKE cst_veiculos
       FIELD R-ROWID AS ROWID.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wMaintenanceNoNavigation 
/*:T*******************************************************************************
** Copyright TOTVS S.A. (2009)
** Todos os Direitos Reservados.
**
** Este fonte e de propriedade exclusiva da TOTVS, sua reproducao
** parcial ou total por qualquer meio, so podera ser feita mediante
** autorizacao expressa.
*******************************************************************************/
{include/i-prgvrs.i cspt019a 2023.00.00.001}

/* Chamada a include do gerenciador de licen‡as. Necessario alterar os parametros */
/*                                                                                */
/* <programa>:  Informar qual o nome do programa.                                 */
/* <m¢dulo>:  Informar qual o m¢dulo a qual o programa pertence.                  */

&IF "{&EMSFND_VERSION}" >= "1.00" &THEN
    {include/i-license-manager.i cspt019a MUT}
&ENDIF

CREATE WIDGET-POOL.

/* Preprocessors Definitions ---                                      */
&GLOBAL-DEFINE Program           cspt019a
&GLOBAL-DEFINE Version           2023.00.00.001

&GLOBAL-DEFINE Folder            YES
&GLOBAL-DEFINE InitialPage       1

&GLOBAL-DEFINE FolderLabels      Geral,Check-list

&GLOBAL-DEFINE ttTable           ttVeiculos
&GLOBAL-DEFINE hDBOTable         hBOVeiculos
&GLOBAL-DEFINE DBOTable          Veiculos

                           

&GLOBAL-DEFINE ttParent          
&GLOBAL-DEFINE DBOParentTable    
&GLOBAL-DEFINE page0KeyFields    ttVeiculos.placa
&GLOBAL-DEFINE page0Fields       ttVeiculos.modelo
&GLOBAL-DEFINE page0ParentFields 
&GLOBAL-DEFINE page1Fields       ttVeiculos.ano ~
                                 ttVeiculos.ativo ~
                                 ttVeiculos.cor ~
                                 ttVeiculos.km ~
                                 ttVeiculos.marca ~
                                 ttVeiculos.observacoes ~
                                 ttVeiculos.proprietario ~
                                 ttVeiculos.cod_categ_habilit ~
                                 ttVeiculos.renavam

&GLOBAL-DEFINE page2Fields       ttVeiculos.agua_rad ~
                                 ttVeiculos.agua_limp ~
                                 ttVeiculos.alarme ~
                                 ttVeiculos.buzina ~
                                 ttVeiculos.cambio ~
                                 ttVeiculos.chave_roda ~
                                 ttVeiculos.cintos ~
                                 ttVeiculos.combustivel ~
                                 ttVeiculos.documentos ~
                                 ttVeiculos.embreagem ~
                                 ttVeiculos.estepe ~
                                 ttVeiculos.extintor ~
                                 ttVeiculos.farol_alto ~
                                 ttVeiculos.farol_baixo ~
                                 ttVeiculos.freio ~
                                 ttVeiculos.lataria ~
                                 ttVeiculos.limpadores ~
                                 ttVeiculos.limp_ext ~
                                 ttVeiculos.limp_int ~
                                 ttVeiculos.luz_re ~
                                 ttVeiculos.macaco ~
                                 ttVeiculos.oleo_freio ~
                                 ttVeiculos.oleo_motor ~
                                 ttVeiculos.parabrisa ~
                                 ttVeiculos.parachoque_diant ~
                                 ttVeiculos.parachoque_tras ~
                                 ttVeiculos.pintura ~
                                 ttVeiculos.pneus ~
                                 ttVeiculos.retrov_ext ~
                                 ttVeiculos.retrov_int ~
                                 ttVeiculos.setas ~
                                 ttVeiculos.triangulo
                                 
/* Parameters Definitions ---                                           */
DEFINE INPUT PARAMETER prTable         AS ROWID     NO-UNDO.
/* DEFINE INPUT PARAMETER prParent        AS ROWID     NO-UNDO. */
DEFINE INPUT PARAMETER pcAction        AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER phCaller        AS HANDLE    NO-UNDO.
/* DEFINE INPUT PARAMETER piSonPageNumber AS INTEGER   NO-UNDO. */

/* Local Variable Definitions ---                                       */

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
&Scoped-Define ENABLED-FIELDS ttVeiculos.placa ttVeiculos.modelo 
&Scoped-define ENABLED-TABLES ttVeiculos
&Scoped-define FIRST-ENABLED-TABLE ttVeiculos
&Scoped-Define ENABLED-OBJECTS btOK btSave btCancel btHelp rtKeys rtToolBar 
&Scoped-Define DISPLAYED-FIELDS ttVeiculos.placa ttVeiculos.modelo 
&Scoped-define DISPLAYED-TABLES ttVeiculos
&Scoped-define FIRST-DISPLAYED-TABLE ttVeiculos


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

DEFINE RECTANGLE rtKeys
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 92 BY 2.25.

DEFINE RECTANGLE rtToolBar
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 92 BY 1.42
     BGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fpage0
     ttVeiculos.placa AT ROW 1.17 COL 20 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 9.72 BY .88
     ttVeiculos.modelo AT ROW 2.17 COL 20 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 30 BY .88
     btOK AT ROW 21.5 COL 2
     btSave AT ROW 21.5 COL 13
     btCancel AT ROW 21.5 COL 24
     btHelp AT ROW 21.5 COL 82
     rtKeys AT ROW 1 COL 1
     rtToolBar AT ROW 21.25 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 92 BY 21.75
         FONT 1 WIDGET-ID 100.

DEFINE FRAME fPage1
     ttVeiculos.marca AT ROW 1.17 COL 20 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 22 BY .88
     ttVeiculos.ano AT ROW 2.17 COL 20 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 9 BY .88
     ttVeiculos.cor AT ROW 3.17 COL 20 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 22 BY .88
     ttVeiculos.renavam AT ROW 4.17 COL 20 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 22 BY .88
     ttVeiculos.cod_categ_habilit AT ROW 5.17 COL 20 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     ttVeiculos.proprietario AT ROW 6.17 COL 20 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 30 BY .88
     ttVeiculos.km AT ROW 7.17 COL 20 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 9 BY .88
     ttVeiculos.ativo AT ROW 8.17 COL 22 WIDGET-ID 4
          VIEW-AS TOGGLE-BOX
          SIZE 7 BY .71
     ttVeiculos.observacoes AT ROW 9.17 COL 22 NO-LABEL WIDGET-ID 22
          VIEW-AS EDITOR NO-WORD-WRAP MAX-CHARS 300 SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
          SIZE 51 BY 7.58
     "Observa‡äes:" VIEW-AS TEXT
          SIZE 10.29 BY .54 AT ROW 9.17 COL 11 WIDGET-ID 24
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 4.71
         SIZE 92 BY 16.29
         FONT 1 WIDGET-ID 100.

DEFINE FRAME fPage2
     ttVeiculos.limp_ext AT ROW 1.17 COL 17.86 NO-LABEL WIDGET-ID 330
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.freio AT ROW 1.17 COL 62.14 NO-LABEL WIDGET-ID 318
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.limp_int AT ROW 2.17 COL 17.86 NO-LABEL WIDGET-ID 334
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.oleo_freio AT ROW 2.17 COL 62.14 NO-LABEL WIDGET-ID 346
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.pneus AT ROW 3.17 COL 17.86 NO-LABEL WIDGET-ID 370
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.oleo_motor AT ROW 3.17 COL 62.14 NO-LABEL WIDGET-ID 350
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.estepe AT ROW 4.17 COL 17.86 NO-LABEL WIDGET-ID 302
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.combustivel AT ROW 4.17 COL 62.14 NO-LABEL WIDGET-ID 290
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.lataria AT ROW 5.17 COL 17.86 NO-LABEL WIDGET-ID 322
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.parabrisa AT ROW 5.17 COL 62.14 NO-LABEL WIDGET-ID 354
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.pintura AT ROW 6.17 COL 17.86 NO-LABEL WIDGET-ID 366
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.alarme AT ROW 6.17 COL 62.14 NO-LABEL WIDGET-ID 270
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.parachoque_diant AT ROW 7.17 COL 17.86 NO-LABEL WIDGET-ID 358
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.buzina AT ROW 7.17 COL 62.14 NO-LABEL WIDGET-ID 274
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.parachoque_tras AT ROW 8.17 COL 17.86 NO-LABEL WIDGET-ID 362
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.cintos AT ROW 8.17 COL 62.14 NO-LABEL WIDGET-ID 286
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 4.71
         SIZE 92 BY 16.29
         FONT 1 WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fPage2
     ttVeiculos.setas AT ROW 9.17 COL 17.86 NO-LABEL WIDGET-ID 382
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.documentos AT ROW 9.17 COL 62.14 NO-LABEL WIDGET-ID 294
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.farol_alto AT ROW 10.17 COL 17.86 NO-LABEL WIDGET-ID 310
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.extintor AT ROW 10.17 COL 62.14 NO-LABEL WIDGET-ID 306
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.farol_baixo AT ROW 11.17 COL 17.86 NO-LABEL WIDGET-ID 314
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.limpadores AT ROW 11.17 COL 62.14 NO-LABEL WIDGET-ID 326
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.luz_re AT ROW 12.17 COL 17.86 NO-LABEL WIDGET-ID 338
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.macaco AT ROW 12.17 COL 62.14 NO-LABEL WIDGET-ID 342
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.agua_limp AT ROW 13.17 COL 17.86 NO-LABEL WIDGET-ID 262
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.triangulo AT ROW 13.17 COL 62.14 NO-LABEL WIDGET-ID 450
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.agua_rad AT ROW 14.17 COL 17.86 NO-LABEL WIDGET-ID 266
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.chave_roda AT ROW 14.17 COL 62.14 NO-LABEL WIDGET-ID 282
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.embreagem AT ROW 15.17 COL 17.86 NO-LABEL WIDGET-ID 298
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.retrov_ext AT ROW 15.17 COL 62.14 NO-LABEL WIDGET-ID 374
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 4.71
         SIZE 92 BY 16.29
         FONT 1 WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fPage2
     ttVeiculos.cambio AT ROW 16.17 COL 17.86 NO-LABEL WIDGET-ID 278
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     ttVeiculos.retrov_int AT ROW 16.17 COL 62.14 NO-LABEL WIDGET-ID 378
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Ruim", 1,
"M‚dio", 2,
"Bom", 3
          SIZE 26 BY .88
     "Farol Baixo:" VIEW-AS TEXT
          SIZE 8 BY .88 AT ROW 11.17 COL 8.43 WIDGET-ID 432
     "Agua Radiador:" VIEW-AS TEXT
          SIZE 11 BY .88 AT ROW 14.17 COL 5.72 WIDGET-ID 434
     "Farol Alto:" VIEW-AS TEXT
          SIZE 7.57 BY .88 AT ROW 10.17 COL 9.57 WIDGET-ID 436
     "Pneus:" VIEW-AS TEXT
          SIZE 5.14 BY .88 AT ROW 3.17 COL 11.72 WIDGET-ID 438
     "Luz R‚:" VIEW-AS TEXT
          SIZE 6.29 BY .88 AT ROW 12.17 COL 11 WIDGET-ID 440
     "Embreagem:" VIEW-AS TEXT
          SIZE 9 BY .88 AT ROW 15.17 COL 7.72 WIDGET-ID 426
     "Freio:" VIEW-AS TEXT
          SIZE 4 BY .88 AT ROW 1.17 COL 56.72 WIDGET-ID 424
     "Retrovisor Int.:" VIEW-AS TEXT
          SIZE 10.57 BY .88 AT ROW 16.17 COL 51.14 WIDGET-ID 422
     "Parachoque Tras.:" VIEW-AS TEXT
          SIZE 13.14 BY .88 AT ROW 8.17 COL 4.14 WIDGET-ID 444
     "Parachoque Diant.:" VIEW-AS TEXT
          SIZE 13 BY .88 AT ROW 7.17 COL 3.57 WIDGET-ID 448
     "Documentos:" VIEW-AS TEXT
          SIZE 9.72 BY .88 AT ROW 9.17 COL 51.57 WIDGET-ID 446
     "Setas:" VIEW-AS TEXT
          SIZE 5.14 BY .88 AT ROW 9.17 COL 12.14 WIDGET-ID 386
     "Lataria:" VIEW-AS TEXT
          SIZE 5.72 BY .88 AT ROW 5.17 COL 11.57 WIDGET-ID 388
     "Oleo Motor:" VIEW-AS TEXT
          SIZE 9.29 BY .88 AT ROW 3.17 COL 52.57 WIDGET-ID 390
     "Alarme:" VIEW-AS TEXT
          SIZE 6 BY .88 AT ROW 6.17 COL 55.57 WIDGET-ID 392
     "Chave Roda:" VIEW-AS TEXT
          SIZE 9.14 BY .88 AT ROW 14.17 COL 51.72 WIDGET-ID 394
     "Parabrisa:" VIEW-AS TEXT
          SIZE 7.72 BY .88 AT ROW 5.17 COL 53.86 WIDGET-ID 396
     "Retrovisores ext.:" VIEW-AS TEXT
          SIZE 12.14 BY .88 AT ROW 15.17 COL 49.29 WIDGET-ID 398
     "Macaco:" VIEW-AS TEXT
          SIZE 6.57 BY .88 AT ROW 12.17 COL 54.29 WIDGET-ID 400
     "Cintos:" VIEW-AS TEXT
          SIZE 5.57 BY .88 AT ROW 8.17 COL 56 WIDGET-ID 402
     "Buzina:" VIEW-AS TEXT
          SIZE 6 BY .88 AT ROW 7.17 COL 55.57 WIDGET-ID 404
     "Limpeza Ext.:" VIEW-AS TEXT
          SIZE 9.29 BY .88 AT ROW 1.17 COL 7.43 WIDGET-ID 406
     "Extintor:" VIEW-AS TEXT
          SIZE 6 BY .88 AT ROW 10.17 COL 55 WIDGET-ID 416
     "Combust¡vel:" VIEW-AS TEXT
          SIZE 9.43 BY .88 AT ROW 4.17 COL 51.57 WIDGET-ID 418
     "Limpadores:" VIEW-AS TEXT
          SIZE 8.86 BY .88 AT ROW 11.17 COL 52.29 WIDGET-ID 414
     "Agua Limpador:" VIEW-AS TEXT
          SIZE 11 BY .88 AT ROW 13.17 COL 5.72 WIDGET-ID 428
     "Pintura:" VIEW-AS TEXT
          SIZE 6 BY .88 AT ROW 6.17 COL 11.29 WIDGET-ID 430
     "Limpeza Int.:" VIEW-AS TEXT
          SIZE 9.57 BY .88 AT ROW 2.17 COL 8 WIDGET-ID 408
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 4.71
         SIZE 92 BY 16.29
         FONT 1 WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fPage2
     "Estepe:" VIEW-AS TEXT
          SIZE 5.86 BY .88 AT ROW 4.17 COL 11.43 WIDGET-ID 410
     "Triƒngulo:" VIEW-AS TEXT
          SIZE 7.14 BY .88 AT ROW 13.17 COL 53.72 WIDGET-ID 412
     "àleo Freio:" VIEW-AS TEXT
          SIZE 7.57 BY .88 AT ROW 2.17 COL 53.14 WIDGET-ID 420
     "Cambio:" VIEW-AS TEXT
          SIZE 6.43 BY .88 AT ROW 16.17 COL 10.72 WIDGET-ID 442
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 4.71
         SIZE 92 BY 16.29
         FONT 1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: MaintenanceNoNavigation
   Allow: Basic,Browse,DB-Fields,Window,Query
   Add Fields to: Neither
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: ttVeiculos T "?" NO-UNDO emscustom cst_veiculos
      ADDITIONAL-FIELDS:
          FIELD R-ROWID AS ROWID
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
         HEIGHT             = 21.75
         WIDTH              = 92
         MAX-HEIGHT         = 24.38
         MAX-WIDTH          = 92.86
         VIRTUAL-HEIGHT     = 24.38
         VIRTUAL-WIDTH      = 92.86
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
/* REPARENT FRAME */
ASSIGN FRAME fPage1:FRAME = FRAME fpage0:HANDLE
       FRAME fPage2:FRAME = FRAME fpage0:HANDLE.

/* SETTINGS FOR FRAME fpage0
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fPage1:MOVE-AFTER-TAB-ITEM (ttVeiculos.modelo:HANDLE IN FRAME fpage0)
       XXTABVALXX = FRAME fPage1:MOVE-BEFORE-TAB-ITEM (btOK:HANDLE IN FRAME fpage0)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fPage1
                                                                        */
/* SETTINGS FOR FRAME fPage2
                                                                        */
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


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wMaintenanceNoNavigation 


/*:T--- L¢gica para inicializa‡Æo do programam ---*/
{maintenancenonavigation/mainblock.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterInitializeInterface wMaintenanceNoNavigation 
PROCEDURE afterInitializeInterface :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    APPLY "entry":U TO ttVeiculos.placa IN FRAME {&FRAME-NAME}.
    RETURN "OK":U.

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
    
    RETURN "OK":U.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

