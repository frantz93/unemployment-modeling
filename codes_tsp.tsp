?GOTO 9; ?(commande à exécuter pour avoir les résultats des effets temporels'.

? ANALYSE DES MODELES A EFFETS INDIVIDUELS

LOAD(file='19.01.2022chomage_ind.xls');	  ? chargement de la base des données classées par pays.
SHOW series; ? On affiche le contenu de la base
GENR LN_PIB = Log(PIB); 	? création d'une nouvelle variable (Ln du PIB per capita).
SMPL 1,10;	 ? On sélectionne les 10 premières observations
PRINT TC CF RLT TS SM; ? On affiche les 10 premières observations sélectionnées.
SMPL 1,300;  ? Sélection de l'ensemble des observations pour lancer la régression
REGOPT(pvprint,stars) all;		  ? commande pour avoir des tests économétriques supplementaires.
TITLE 'Comparaison des modèles à effets individuels (PAYS)';
PANEL(all,id=ID,time=AN,byID,print) TC CF RLT TS SM;
			 ? la commande "PANEL" permet de réaliser les tests sur les données de panel. TAUX_CHOM est la variable endogène;
			 ? CF RLT TS SM sont les variables exogènes.
			 ? all veut dire qu'on demande tous les tests. id et time sont les dimensions des données de panel.
TITLE 'Moyennes par pays selon les variables du PANEL';
PRINT @mean; ? moyenne des variables par pays.
STOP; 	? Fin de l'analyse des modèles a effets individuels.

? *******************************************************************************************************

? ANALYSE DES MODELES A EFFETS TEMPORELS

9 LOAD(file='19.01.2022chomage_tps.xls');	  ? chargement de la base des données classées par années.
SHOW series; ? On affiche le contenu de la base.
GENR LN_PIB = Log(PIB);  ? création de la nouvelle variable (Ln du PIB per capita).
SMPL 1,10;	 ? On sélectionne les 10 premières observations.
PRINT ANNEE TC CF RLT TS SM; ? On affiche les 10 premières observations sélectionnées.
SMPL 1,300;  ? Sélection de l'ensemble des observations pour lancer la régression
REGOPT(pvprint,stars) all;		  ? commande pour avoir des tests économétriques supplementaires.
TITLE 'Comparaison des modèles à effets temporels (ANNEE)';
PANEL(all,id=AN,time=ID,byID,print) TC CF RLT TS SM;
			 ? la commande "PANEL" permet de réaliser les tests sur les données de panel. TAUX_CHOM est la variable endogène;
			 ? CF RLT TS SM sont les variables exogènes.
			 ? all veut dire qu'on demande tous les tests. id et time sont les dimensions des données de panel.


? *************************************************************************

END; 	? Fin d'exécution du programme