                          
/* dvc + barra espaço */  DEFINE VARIABLE cNome            AS CHARACTER                     NO-UNDO. 
/* dvin + barra espaço */ DEFINE VARIABLE iIdade           AS INTEGER                       NO-UNDO.
/* dvde + barra espaço */ DEFINE VARIABLE fAltura          AS DECIMAL                       NO-UNDO.
/* dvdt + barra espaço */ DEFINE VARIABLE dDataNascimento  AS DATE      FORMAT "99/99/9999" NO-UNDO.
/* dvl + barra espaço */  DEFINE VARIABLE lAtivo           AS LOGICAL   INITIAL TRUE        NO-UNDO.
/* dvc + barra espaço */  DEFINE VARIABLE cCoresPreferidas AS CHARACTER EXTENT 2            NO-UNDO.

ASSIGN cNome                = "João"
       iIdade               = 32
       fAltura              = 1.79
       dDataNascimento      = 09/15/1990
       lAtivo               = TRUE
       cCoresPreferidas[1]  = "Azul"
       cCoresPreferidas[2]  = "Preto".


MESSAGE "Olá " + cNome
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.



DISPLAY cNome iIdade fAltura dDataNascimento lAtivo.



