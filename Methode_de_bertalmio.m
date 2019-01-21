clear all; close all;
I_degrade=imread('data/Lena_degrad3.png');
I_degrade=im2double(I_degrade(:,:,1));
figure;
imshow(I_degrade);
[Ni,Nj]=size(I_degrade);

%% Ceci permet de savoir la position des marqueurs, en noir(0)
for i=1:Ni                                  %Parcourt les lignes
    for j=1:Nj                              %Parcourt les colonnes
        if I_degrade(i,j)==0                       %On détecte les pixels noirs
            Marqueur(i,j)=1; %On remplit le tableau par les valeurs des pixels non noirs
        else
            Marqueur(i,j)=0;
        end
    end
end

%% Début du calcul
for k=1:100 %On réitère 100 fois la boucle
    f=mod(k,50); %On affiche le résultat toute les 50 itérations
    for n=1:700 %On réalise 700 fois le calcul
        for i=2:Ni-1 %On parcourt les pixels en lignes et en colonnes
            for j=2:Nj-1
                seuil=0.15;
                if (Marqueur(i,j)==1 || I_degrade(i,j)<=seuil) %On travaille seulement sur le marqueur
                    Ix=(I_degrade(i+1,j)-I_degrade(i-1,j))/2; %Calcul de la dérivée première
                    Iy=(I_degrade(i,j+1)-I_degrade(i,j-1))/2;
                    %Calcul du dénominateur de la norme
                    denoN=sqrt((Ix*Ix)+(Iy*Iy)+0.000001); %on ajoute 0,000001 pour pouvoir diviser par zéro
                    Nx=Ix/denoN; %On calcule la norme selon x et y
                    Ny=Iy/denoN;
                     p=i+1;q=j; %On définit p et q pour simplifier les calculs suivants
                     %On extrait l'information de l'image sur les pixels
                     %voisins
                     %Calcul du L(i+1,j)
                     L1=I_degrade(p+1,q)+I_degrade(p-1,q)+I_degrade(p,q+1)+I_degrade(p,q-1)-4*I_degrade(p,q);
                     p2=i-1;q2=j;
                     %Calcul du L(i-1,j)
                     L2=I_degrade(p2+1,q2)+I_degrade(p2-1,q2)+I_degrade(p2,q2+1)+I_degrade(p2,q2-1)-4*I_degrade(p2,q2);
                     p3=i;q3=j+1;
                     %Calcul du L(i,j+1)
                     L3=I_degrade(p3+1,q3)+I_degrade(p3-1,q3)+I_degrade(p3,q3+1)+I_degrade(p3,q3-1)-4*I_degrade(p3,q3);
                     p4=i;q4=j-1;
                     %Calcul du L(i,j-1)
                     L4=I_degrade(p4+1,q4)+I_degrade(p4-1,q4)+I_degrade(p4,q4+1)+I_degrade(p4,q4-1)-4*I_degrade(p4,q4);
                     %Ainsi on peut calculer le changement d'information de
                     %L par deltaL
                     deltaLx=L1-L2;
                     detaLy=L3-L4;
                    %Calcul du beta
                    beta=0.05*((deltaLx*(-Ny))+(detaLy*Nx));
                    %Calcul de la dérivée première en backward/forward
                    Ixf=I_degrade(i+1,j)-I_degrade(i,j);
                    Ixb=I_degrade(i,j)-I_degrade(i-1,j);
                    Iyf=I_degrade(i,j+1)-I_degrade(i,j);
                    Iyb=I_degrade(i,j)-I_degrade(i,j-1);
                    %Puis on cherche la valeur maximale et minimale
                    Ixfm=min(Ixf,0);
                    IxfM=max(Ixf,0);
                    Ixbm=min(Ixb,0);
                    IxbM=max(Ixb,0);
                    Iyfm=min(Iyf,0);
                    IyfM=max(Iyf,0);
                    Iybm=min(Iyb,0);
                    IybM=max(Iyb,0);
                    %Lorsque beta est positif, on prends le minimum de Ixb,
                    %et le max de Ixf
                    if(beta>0)
                        DeltaI=sqrt((Ixbm*Ixbm)+(IxfM*IxfM)+(Iybm*Iybm)+(IyfM*IyfM));
                    %Sinon l'inverse    
                    elseif (beta<=0)
                        DeltaI=sqrt((IxbM*IxbM)+(Ixfm*Ixfm)+(IybM*IybM)+(Iyfm*Iyfm));
                    end
                    %On définit It pour pouvoir améliorer l'image
                    It=beta*DeltaI;
                    %Puis on implémente l'équation principale afin d'avoir
                    %une version améliorée de l'image
                    I_degrade(i,j)=I_degrade(i,j)+0.5*(It); %La valeur de deltat=0,5 est à définir
                    %selon la convergence de l'algorithme, ici 0,5 est
                    %convenable
                end
            end
        end
    end

%% Cet code permet de réaliser un lissage des pixels reconstruits afin d'obtenir un aspect plus 'réaliste'
%     for m=1:2
%         for i=174:216
%             for j=144:186
%                 img(i,j)=imdiffusefilt(img(i,j));
%             end
%         end
%         m=m+1;
%     end
    
    %affichage de l'image toute les 50 itérations
    if(f==0)
       figure;
       imshow(I_degrade);
    end
end
