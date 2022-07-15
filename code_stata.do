import excel "C:\Users\NEW\OneDrive\Dossiers\Economie données de panel\19.01.2022chomage_individu.xls", sheet("chomage") firstrow clear

xtset ID AN, yearly

ssc install xttest2                /* test BREUSCH-PAGAN LM : Test de la dépendance en coupe transversale/corrélation contemporaine  ie résidus corréles ou pas avec les PRODUITS*/
ssc install xtcsd                  /* test PASARAN CD TEST (m que xttest 2) */
ssc install xttest3                /* test d'heteroscedasticite  */ 

net from http://www.stata-journal.com/software/sj3-2/
net describe st0039
net install st0039  /*test la corrélation temporelle des donnees de panel*/
net get st0039


* ESTIMATION 1 : modèle de regression
regress TC CF RLT TS SM
estimates store ols /*enregistre le tableau sous le nom ols*/
estat vif

* Vérification de la corrélation entre les variables
pwcorr  TC CF RLT TS SM, sig


* ESTIMATION 2 : within avec effet temporel et individuel
xi: regress TC CF RLT TS SM i.AN i.ID, noconstant
xtreg TC CF RLT TS SM i.AN i.ID, fe
estimates store withinTI

*ESTIMATION 3 : within avec effet temporel 
xtreg TC CF RLT TS SM i.AN, fe 
estimates store withinT

*ESTIMATION 4 : within avec effet individuel 
xtreg TC CF RLT TS SM, fe
estimates store withinI

* ESTIMATION 5 : aléatoire avec effet temporel et individuel
xtmixed TC CF RLT TS SM
estimates store aleatoireTI

* ESTIMATION 6 : effets aléatoires individuels
xtreg TC CF RLT TS SM, re
estimates store aleatoireI

* ESTIMATION 7 : effets aléatoires temps
xtmixed TC CF RLT TS SM ||AN:
estimates store aleatoireT

* ESTIMATION 8 :  between temporel
xtreg TC CF RLT TS SM i.AN, be
estimates store betweenT

* ESTIMATION 9 : between individuel* (meilleur modèle selon TSP)
xtreg TC CF RLT TS SM, be 
estimates store betweenI

* Etude comparative 
* 1ere estimation
estimates table ols withinTI withinT withinI aleatoireTI aleatoireT aleatoireI betweenT betweenI, star stats(N r2 r2_a) /* modèles  withinTI aleatoireTI betweenT écartés */
* 2e estimation (avec les variables retenues)
estimates table withinT withinI aleatoireT aleatoireI betweenI, star stats(N r2 r2_a)

hausman withinI aleatoireI, sigmamore /* non significatif au seuil de 5%, donc aleatoireI est meilleur que withinI */
hausman withinT aleatoireT /* test non satisfaisant à cause d'un problème de matching des coefficients */

estimates stats withinT aleatoireT aleatoireI betweenI, n()




