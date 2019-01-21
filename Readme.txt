Readme du Projet de Majeure IMI sur l'inpainting de BIASSIN Romain, SILINSKI Rémy et MARIN DIT BERTOUD Quentin

Image représentant notre projet :

Image Représentant le Projet.png


Noms des images contenues dans le dossier data:

Lena.png --> Image de base en couleurs non dégradée
Lena_degrad.png --> Image dégradée en couleurs avec un marqueur carré noir
Lena_degrad2.png --> Image dégradée en couleurs avec un marqueur de type trait noir
Lena_degrad3.png --> Image dégradée en couleurs avec un marqueur de type texte noir
image_a_traiter.png --> Image générée par l'interface graphique


Noms des programmes associés au type de traitement :

Programmes de Moyennage :
--> ProjetMajeure_MoyenneVoisinsNoiretBlanc.m
	Traitement de l'image dégradée en noir et blanc avec reconstruction par la méthode de moyennage des voisins
--> ProjetMajeure_MoyenneVoisinsCouleurs1itération.m
	Traitement de l'image dégradée en couleurs avec reconstruction par la méthode de moyennage des voisins
--> ProjetMajeure_MoyenneVoisinsCouleursElargissement.m
	Traitement de l'image dégradée en couleur avec reconstruction en considérant les voisins plus éloignés
--> ProjetMajeure_MoyenneVoisinsCouleursNitérations.m
	Traitement de l'image dégradée en couleur avec reconstruction en exécutant plusieurs itérations

Programme avec l'interface graphique :
--> IHM.m avec les fonction ProjetMajeure_couleur.m et ProjetMajeure_Gradientsvrai.m
	Génère une image s'appelant image_a_traiter.png remplaçant l'image dégradée contenant le marqueur de base
	Traitement de l'image dégradée en couleurs avec reconstruction

Programme avec les gradients :
--> Methode_de_bertalmio.m
	Traitement de l'image dégradée en couleurs avec reconstruction par la méthode de Bertalmio
	(Enormément d'itérations, programme peut mettre du temps à s'exécuter)