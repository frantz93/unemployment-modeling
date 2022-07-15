PROC IMPORT OUT= WORK.chomage
            DATAFILE= "C:\Users\NEW\OneDrive\Dossiers\Economie données de panel\SAS\19.01.2022chomage_individuSAS.xls"
            DBMS=xls REPLACE;
     GETNAMES=YES;
RUN;

/* Vérification de la structure de la base de données */
PROC PRINT data=chomage(obs=10);
RUN;

PROC CONTENTS;
RUN;


/* Estimations des modèles */

PROC REG data=chomage outtest=OLS ;      /* ESTIMATION PAR OLS */
MODEL TC=CF RLT TS SM/VIF;
RUN;


PROC panel data=chomage outest=wIT;    /* ESTIMATION modèle within temporel et individuel */
   id ID AN;
   fixetwo: model TC=CF RLT TS SM/NOINT fixtwo  printfixed plots=all; * fixetwo precise que l'on veut faire l'estimation within a 2 effets;
run;																   * NOINT pour enlever l'intercept.;


PROC panel data=chomage outest=wI;  /* ESTIMATION modèle within individuel */
   id ID AN;
   fixeone: model TC=CF RLT TS SM/fixone  printfixed noint;
run;* fixeone precise que l'on veut faire l'estimation within a effet individuel seulement;

PROC panel data=chomage outest=wT;   /* ESTIMATION modèle within temporel */
   id ID AN;
   fixeonetime: model TC=CF RLT TS SM/fixonetime noint printfixed;
run; * fixeonetime precise que l'on veut faire l'estimation within a effet temporel seulement;

PROC panel data=chomage outest=aIT;  /* ESTIMATION  EFETS ALEATOIRES INDIVIDUEL ET TEMPOREL */
   id ID AN;
   rantwo: model TC=CF RLT TS SM/rantwo ;
run;

PROC panel data=chomage outest=aI;  /* ESTIMATION EFFETS ALEATOIRE INDIVIDUEL SEULEMENT */
   id ID AN;
   ranONE: model TC=CF RLT TS SM/ranONE ;
run;

PROC panel data=chomage outest=aT;  /* ESTIMATION EFFETS ALEATOIRE TEMPOREL SEULEMENT */
   id ID AN;
   ranONETIME: model TC=CF RLT TS SM/ranONEtime ;
run;


PROC panel data=chomage outest=bI;  /* ESTIMATION  BETWEEN individuel */
   id ID AN;
   BTWNG: model TC=CF RLT TS SM/BTWNG ;
run;

PROC panel data=chomage outest=bT;  /* ESTIMATION  BETWEEN temporel */
   id ID AN;
   BTWNT: model TC=CF RLT TS SM/BTWNT ;
run;
