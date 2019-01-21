clear all;
close all;

I=imread('data/Lena.png');              %Lecture de l'image de base
figure(1);
imagesc(I),title('Image de base en RGB');      %Affichage de l'image de base

I_degrad=imread('data/Lena_degrad2.png');
figure(2);
imagesc(I_degrad),title('Image bruit�e en uint8');
I_degrade=im2double(I_degrad(:,:,1));   %Convertit image 1 sous forme de matrice de type double
[Ni,Nj]=size(I_degrade);                %R�cup�ration de la taille de la matrice(hauteur et largeur)
figure(3);
imshow(I_degrade),title('Image bruit�e en double');%Affichage de l'image par la matrice

%D�tection nombre de pixels noirs --> OK car aucun autre pixel noir dans l'image
% cpt=0;
% for i=1:Ni
%     for j=1:Nj
%         if I_degrad(i,j)==0
%             cpt=cpt+1;
%         end
%     end
% end
% cpt=1521=39*39=taille du carr� noir

S=0;
N=0;
for i=1:Ni                                  %Parcourt les lignes
    for j=1:Nj                              %Parcourt les colonnes
        if I_degrade(i,j)==0;               %On d�tecte les pixels noirs
            S=0;N=0;                        %Initialisation des param�tres de somme et du compteur
            for k=i-1:i+1                   %Ces deux boucles for parcourt les voisins du pixel noir
                for l=j-1:j+1
                    if I_degrade(k,l)~=0    %On d�tecte les voisins non noirs
                        S=S+I_degrade(k,l); %Num�rateur
                        N=N+1;              %D�nominateur
                    end
                end
            end
            I_degrade(i,j)=S/N;             %Le pixel noir prend la valeur moyenne des pixels voisins non noirs
        end
    end
end
figure(4);
imshow(I_degrade),title('Image reconstruite'); %Affichage de l'image reconstruite