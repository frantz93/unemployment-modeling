?GOTO 9; ?(commande � ex�cuter pour avoir les r�sultats des effets temporels'.

? ANALYSE DES MODELES A EFFETS INDIVIDUELS

LOAD(file='19.01.2022chomage_ind.xls');	  ? chargement de la base des donn�es class�es par pays.
SHOW series; ? On affiche le contenu de la base
GENR LN_PIB = Log(PIB); 	? cr�ation d'une nouvelle variable (Ln du PIB per capita).
SMPL 1,10;	 ? On s�lectionne les 10 premi�res observations
PRINT TC CF RLT TS SM; ? On affiche les 10 premi�res observations s�lectionn�es.
SMPL 1,300;  ? S�lection de l'ensemble des observations pour lancer la r�gression
REGOPT(pvprint,stars) all;		  ? commande pour avoir des tests �conom�triques supplementaires.
TITLE 'Comparaison des mod�les � effets individuels (PAYS)';
PANEL(all,id=ID,time=AN,byID,print) TC CF RLT TS SM;
			 ? la commande "PANEL" permet de r�aliser les tests sur les donn�es de panel. TAUX_CHOM est la variable endog�ne;
			 ? CF RLT TS SM sont les variables exog�nes.
			 ? all veut dire qu'on demande tous les tests. id et time sont les dimensions des donn�es de panel.
TITLE 'Moyennes par pays selon les variables du PANEL';
PRINT @mean; ? moyenne des variables par pays.
STOP; 	? Fin de l'analyse des mod�les a effets individuels.

? *******************************************************************************************************

? ANALYSE DES MODELES A EFFETS TEMPORELS

9 LOAD(file='19.01.2022chomage_tps.xls');	  ? chargement de la base des donn�es class�es par ann�es.
SHOW series; ? On affiche le contenu de la base.
GENR LN_PIB = Log(PIB);  ? cr�ation de la nouvelle variable (Ln du PIB per capita).
SMPL 1,10;	 ? On s�lectionne les 10 premi�res observations.
PRINT ANNEE TC CF RLT TS SM; ? On affiche les 10 premi�res observations s�lectionn�es.
SMPL 1,300;  ? S�lection de l'ensemble des observations pour lancer la r�gression
REGOPT(pvprint,stars) all;		  ? commande pour avoir des tests �conom�triques supplementaires.
TITLE 'Comparaison des mod�les � effets temporels (ANNEE)';
PANEL(all,id=AN,time=ID,byID,print) TC CF RLT TS SM;
			 ? la commande "PANEL" permet de r�aliser les tests sur les donn�es de panel. TAUX_CHOM est la variable endog�ne;
			 ? CF RLT TS SM sont les variables exog�nes.
			 ? all veut dire qu'on demande tous les tests. id et time sont les dimensions des donn�es de panel.


? *************************************************************************

END; 	? Fin d'ex�cution du programme