                          
/* dvc + barra espa�o */  DEFINE VARIABLE cNome            AS CHARACTER                     NO-UNDO. 
/* dvin + barra espa�o */ DEFINE VARIABLE iIdade           AS INTEGER                       NO-UNDO.
/* dvde + barra espa�o */ DEFINE VARIABLE fAltura          AS DECIMAL                       NO-UNDO.
/* dvdt + barra espa�o */ DEFINE VARIABLE dDataNascimento  AS DATE      FORMAT "99/99/9999" NO-UNDO.
/* dvl + barra espa�o */  DEFINE VARIABLE lAtivo           AS LOGICAL   INITIAL TRUE        NO-UNDO.
/* dvc + barra espa�o */  DEFINE VARIABLE cCoresPreferidas AS CHARACTER EXTENT 2            NO-UNDO.

ASSIGN cNome                = "Jo�o"
       iIdade               = 32
       fAltura              = 1.79
       dDataNascimento      = 09/15/1990
       lAtivo               = TRUE
       cCoresPreferidas[1]  = "Azul"
       cCoresPreferidas[2]  = "Preto".


MESSAGE "Ol� " + cNome
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.



DISPLAY cNome iIdade fAltura dDataNascimento lAtivo.



