Readme du Projet de Majeure IMI sur l'inpainting de BIASSIN Romain, SILINSKI R�my et MARIN DIT BERTOUD Quentin

Image repr�sentant notre projet :

Image Repr�sentant le Projet.png


Noms des images contenues dans le dossier data:

Lena.png --> Image de base en couleurs non d�grad�e
Lena_degrad.png --> Image d�grad�e en couleurs avec un marqueur carr� noir
Lena_degrad2.png --> Image d�grad�e en couleurs avec un marqueur de type trait noir
Lena_degrad3.png --> Image d�grad�e en couleurs avec un marqueur de type texte noir
image_a_traiter.png --> Image g�n�r�e par l'interface graphique


Noms des programmes associ�s au type de traitement :

Programmes de Moyennage :
--> ProjetMajeure_MoyenneVoisinsNoiretBlanc.m
	Traitement de l'image d�grad�e en noir et blanc avec reconstruction par la m�thode de moyennage des voisins
--> ProjetMajeure_MoyenneVoisinsCouleurs1it�ration.m
	Traitement de l'image d�grad�e en couleurs avec reconstruction par la m�thode de moyennage des voisins
--> ProjetMajeure_MoyenneVoisinsCouleursElargissement.m
	Traitement de l'image d�grad�e en couleur avec reconstruction en consid�rant les voisins plus �loign�s
--> ProjetMajeure_MoyenneVoisinsCouleursNit�rations.m
	Traitement de l'image d�grad�e en couleur avec reconstruction en ex�cutant plusieurs it�rations

Programme avec l'interface graphique :
--> IHM.m avec les fonction ProjetMajeure_couleur.m et ProjetMajeure_Gradientsvrai.m
	G�n�re une image s'appelant image_a_traiter.png rempla�ant l'image d�grad�e contenant le marqueur de base
	Traitement de l'image d�grad�e en couleurs avec reconstruction

Programme avec les gradients :
--> Methode_de_bertalmio.m
	Traitement de l'image d�grad�e en couleurs avec reconstruction par la m�thode de Bertalmio
	(Enorm�ment d'it�rations, programme peut mettre du temps � s'ex�cuter)