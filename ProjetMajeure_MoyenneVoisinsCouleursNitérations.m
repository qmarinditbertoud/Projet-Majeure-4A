clear all;
close all;

I=imread('Lena.png');
figure();
imagesc(I),title('Image de base');


I_degrad=imread('Lena_degrad3.png');
figure();
imagesc(I_degrad),title('Image bruitée en uint8');

R = I_degrad(:,:,1); %On sépare l'image en Rouge
R=uint16(R); %On convertit en 16 bits pour simplifier le calcul de la moyenne
G = I_degrad(:,:,2); %En Vert
G=uint16(G);
B = I_degrad(:,:,3); %En Bleu
B=uint16(B);
% figure; %On affiche les images rouges, verts et bleus
% imagesc(R)
% figure;
% imagesc(G)
% figure;
% imagesc(B)
r=0; %r permet de réaliser un compteur pour vérifier si on rentre bien r fois dans la condition
R2=0;
B2=0;
G2=0;
[Ni,Nj]=size(B); 

R2=zeros(Ni,Nj);
G2=zeros(Ni,Nj);
B2=zeros(Ni,Nj);

for i=1:Ni %on parcourt les lignes
   for j=1:Nj %on parcourt les colonnes
       S1=0; S2=0; S3=0; N=0; %On réinitialise les valeurs à la fin du if
       if(R(i,j)==0 && G(i,j)==0 && B(i,j)==0) %On cherche seulement les pixels noirs
           r=r+1; %On incrémente le compteurs
           for k=i-1:i+1 %On parcourt les pixels voisinant
               for l=j-1:j+1 %De même
                   if(R(k,l)~=0 && G(k,l)~=0 && B(k,l)~=0) %Si les pixels voisins sont différents de 0
                       S1=S1+R(k,l); %Alors on somme la valeur de ces pixels voisins
                       S2=S2+G(k,l); %Afin de pouvoir effectuer une moyenne
                       S3=S3+B(k,l);
                       N=N+1; %D'où l'incrémentation de N quand on rentre dans le if pour faire une bonne moy.
                   end
               end
           end
           R(i,j)=S1/N; %Calcul de moyenne
           G(i,j)=S2/N;
           B(i,j)=S3/N;
           R2(i,j)=R(i,j);
           B2(i,j)=B(i,j);
           G2(i,j)=G(i,j);
       end

   end
end
% figure; %Affichage des images reconstruites en rouge, vert et en bleu
% imagesc(R)
% figure;
% imagesc(G)
% figure;
% imagesc(B)
figure;
Ifinal=cat(3,R,G,B); %On reconstruit les images en RGB
Ifinal=uint8(Ifinal); %On reconvertit en 8 bits
imagesc(Ifinal);

%% Test pour réitérer la boucle

cpt=0;
while(cpt<=100)
    for i=2:Ni
        for j=2:Nj
            S1=0;S2=0;S3=0;N=0;
               if(R2(i,j)~=0 && B2(i,j)~=0 && G2(i,j)~=0)
                   for k=i-1:i+1
                       for l=j-1:j+1

                           S1=S1+R(k,l);
                           S2=S2+G(k,l);
                           S3=S3+B(k,l);
                           N=N+1;
                       end
                   end
                   R(i,j)=S1/N;
                   G(i,j)=S2/N;
                   B(i,j)=S3/N;
               end
        end    
    end
    cpt=cpt+1;
end

figure(10);
Ifinal2=cat(3,R,G,B);
Ifinal2=uint8(Ifinal2);
imagesc(Ifinal2);

