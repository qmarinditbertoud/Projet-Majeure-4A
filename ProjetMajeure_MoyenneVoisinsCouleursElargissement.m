clear all;
close all;

I=imread('data/Lena.png');                     %Lecture de l'image de base
figure(1);
imagesc(I),title('Image de base en RGB');      %Affichage de l'image de base

I_degrad=imread('data/Lena_degrad2.png');


R=I_degrad(:,:,1);
G=I_degrad(:,:,2);
B=I_degrad(:,:,3);
R=uint16(R);
G=uint16(G);
B=uint16(B);
[Ni,Nj]=size(R);                %Récupération de la taille de la matrice(hauteur et largeur)

figure(2);
subplot(1,4,1);
imagesc(R),title('Image bruitée en composante R');
subplot(1,4,2);
imagesc(G),title('Image bruitée en composante G');
subplot(1,4,3);
imagesc(B),title('Image bruitée en composante B');
subplot(1,4,4);
imagesc(I_degrad),title('Image bruitée en uint8');


%Détection nombre de pixels noirs --> OK car aucun autre pixel noir dans l'image
% cpt=0;
% for i=1:Ni
%     for j=1:Nj
%         if I_degrad(i,j)==0
%             cpt=cpt+1;
%         end
%     end
% end
% cpt=1521=39*39=taille du carré noir


r=0;
q=1;
Seuil=20;
Arret=false;
%% Boucle sur la composante R
for i=1:Ni                                  %Parcourt les lignes
    for j=1:Nj                              %Parcourt les colonnes
        if R(i,j)==0;                       %On détecte les pixels noirs
            S=0;N=0;                        %Initialisation des paramètres de somme et du compteur
            while Arret==false
                for k=i-q:i+q                   %Ces deux boucles for parcourent les voisins du pixel noir
                    for l=j-q:j+q
                        if R(k,l)~=0            %On détecte les voisins non noirs
                            TabR(1,1+r)=R(k,l); %On remplit le tableau par les valeurs des pixels non noirs
                            r=r+1;              %Incrémente les colonnes
                            S=S+R(k,l);         %Numérateur
                            N=N+1;              %Dénominateur
                        end
                    end
                end
                for s=1:length(TabR)-1               %On parcourt le tableau comprenant les valeurs des voisins
                    if abs(TabR(s)-TabR(s+1))>=Seuil %Condition si nos pixels sont proches les uns des autres
                        Arret=true;                  %On stoppe dès qu'on a plus de zone homogène                     
                    end
                end
                q=q+1;                               %On passe aux voisins de rangs supérieurs
            end
            TabR=[];                                 %On remet à 0 le tableau des voisins
            r=0;
            q=1;
            Arret=false;
            R(i,j)=S/N;                     %Le pixel noir prend la valeur moyenne des pixels voisins non noirs
        end
    end
end

%% Boucle sur la composante G
for i=1:Ni                                  %Parcourt les lignes
    for j=1:Nj                              %Parcourt les colonnes
        if G(i,j)==0;                       %On détecte les pixels noirs
            S=0;N=0;                        %Initialisation des paramètres de somme et du compteur
            while Arret==false
                for k=i-q:i+q                   %Ces deux boucles for parcourent les voisins du pixel noir
                    for l=j-q:j+q
                        if G(k,l)~=0            %On détecte les voisins non noirs
                            TabG(1,1+r)=G(k,l); %On remplit le tableau par les valeurs des pixels non noirs
                            r=r+1;              %Incrémente les colonnes
                            S=S+G(k,l);         %Numérateur
                            N=N+1;              %Dénominateur
                        end
                    end
                end
                for s=1:length(TabG)-1               %On parcourt le tableau comprenant les valeurs des voisins
                    if abs(TabG(s)-TabG(s+1))>=Seuil %Condition si nos pixels sont proches les uns des autres
                        Arret=true;                  %On stoppe dès qu'on a plus de zone homogène                     
                    end
                end
                q=q+1;                               %On passe aux voisins de rangs supérieurs
            end
            TabG=[];                                 %On remet à 0 le tableau des voisins
            r=0;
            q=1;
            Arret=false;
            G(i,j)=S/N;                              %Le pixel noir prend la valeur moyenne des pixels voisins non noirs
        end
    end
end

%% Boucle sur la composante B
for i=1:Ni                                  %Parcourt les lignes
    for j=1:Nj                              %Parcourt les colonnes
        if B(i,j)==0;                       %On détecte les pixels noirs
            S=0;N=0;                        %Initialisation des paramètres de somme et du compteur
            while Arret==false
                for k=i-q:i+q                   %Ces deux boucles for parcourent les voisins du pixel noir
                    for l=j-q:j+q
                        if B(k,l)~=0            %On détecte les voisins non noirs
                            TabB(1,1+r)=B(k,l); %On remplit le tableau par les valeurs des pixels non noirs
                            r=r+1;              %Incrémente les colonnes
                            S=S+B(k,l);         %Numérateur
                            N=N+1;              %Dénominateur
                        end
                    end
                end
                for s=1:length(TabB)-1               %On parcourt le tableau comprenant les valeurs des voisins
                    if abs(TabB(s)-TabB(s+1))>=Seuil %Condition si nos pixels sont proches les uns des autres
                        Arret=true;                  %On stoppe dès qu'on a plus de zone homogène                     
                    end
                end
                q=q+1;                               %On passe aux voisins de rangs supérieurs
            end
            TabB=[];                                 %On remet à 0 le tableau des voisins
            r=0;
            q=1;
            Arret=false;
            B(i,j)=S/N;                              %Le pixel noir prend la valeur moyenne des pixels voisins non noirs
        end
    end
end

%% Affichage Image Reconstruite

figure(4);
subplot(1,4,1);
imagesc(R),title('Image reconstruite en composante R');
subplot(1,4,2);
imagesc(G),title('Image reconstruite en composante G');
subplot(1,4,3);
imagesc(B),title('Image breconstruite en composante B');
subplot(1,4,4);
Imagefinale=cat(3,R,G,B);
Imagefinale=uint8(Imagefinale);
imshow(Imagefinale),title('Image reconstruite'); %Affichage de l'image reconstruite