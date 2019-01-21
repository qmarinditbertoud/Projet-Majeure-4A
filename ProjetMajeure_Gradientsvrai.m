clear all;
close all;

I=imread('data/image_a_traiter.png');                     %Lecture de l'image de base
figure();
imagesc(I),title('Image de base en RGB');      %Affichage de l'image de base

I_degrad=imread('data/image_a_traiter.png');
I_degrad=uint8(I_degrad);
%figure(2);
imagesc(I_degrad),title('Image bruitée en uint8');
I_degrade=im2double(I_degrad(:,:,1));          %Convertit image 1 sous forme de matrice de type double
[Ni,Nj]=size(I_degrade);                       %Récupération de la taille de la matrice(hauteur et largeur)
figure();
imshow(I_degrade),title('Image bruitée en double');%Affichage de l'image par la matrice
[Ni,Nj]=size(I_degrade);

% for i=1:Ni                                  %Parcourt les lignes
%     for j=1:Nj                              %Parcourt les colonnes
%         if I_degrade(i,j)==0                       %On détecte les pixels noirs
%             Marqueur(i,j)=1; %On remplit le tableau par les valeurs des pixels non noirs
%         else
%             Marqueur(i,j)=0;
%         end
%     end
% end
% 
% figure();
% imshow(Marqueur);
n=1;
w=1;
VectL=[];

H=[-1,0,1];                 %Filtre de Sobel
G=[-1,0,1]';                %Filtre de Sobel
Gh=imfilter(I_degrade,H);   %Calcul du gradient selon x
Gg=imfilter(I_degrade,G);   %Calcul du gradient selon y
% [Gh,Gg]=imgradientxy(I_degrade,'intermediate');
% G=sqrt(Gh.^2+Gg.^2);
% [Gh2,Gg2]=imgradient(uint8(G),'intermediate');

Gh2=imfilter(I_degrade,Gh); %Calcul du gradient second selon x
Gg2=imfilter(I_degrade,Gg); %Calcul du gradient second selon y

L=Gh2+Gg2;
% [Gx,Gy]=imgradient(I_degrade);
deltat=0.1;                
figure();
hold on;
%  for w=1:2
     for n=1:15
        for i=173:217
            for j=143:187
                
                for k=1:Ni                                  %Parcourt les lignes
                    for l=1:Nj                              %Parcourt les colonnes
                        if I_degrade(k,l)==0                       %On détecte les pixels noirs
                            Marqueur(k,l)=1; %On remplit le tableau par les valeurs des pixels non noirs
                        else
                            Marqueur(k,l)=0;
                        end
                    end
                end
                if(Marqueur(i,j)==1)
                    VectL=[L(i+1,j)-L(i-1,j),L(i,j+1)-L(i,j-1)];
                    NormaleNum=[-Gg(i,j),Gh(i,j)];
                    NormaleNumx=Gg(i,j)/sqrt(Gh(i,j)^2+Gg(i,j)^2);
                    NormaleNumy=-Gh(i,j)/sqrt(Gh(i,j)^2+Gg(i,j)^2);
                    NormaleDenom=sqrt(Gh(i,j)^2+Gg(i,j)^2);
                    Normale=[NormaleNum./(NormaleDenom+0.000001)];
                    if(Marqueur(i,j)==1)
                        if(abs(NormaleNumy)>0.5  || abs(NormaleNumx)>0.5)
                            plot(j,220-i,'*b');
                            plot(j+NormaleNumy,220-i+NormaleNumx,'+r');
                        end
                        plot([j,j+NormaleNumy],[220-i,220-i+NormaleNumx],'-g');
                    end


                    Beta=dot(VectL,Normale);

                    Ixb=Gh(i,j)-Gh(i-1,j);
                    Ixf=Gh(i+1,j)-Gh(i,j);
                    Iyb=Gg(i,j)-Gg(i-1,j);
                    Iyf=Gg(i+1,j)-Gg(i,j);

                    if Beta>0
                        if Ixb>0
                           Ixb=0;
                        end
                        if Iyb>0
                           Iyb=0;
                        end
                        DeltaI=sqrt((Ixb)^2+(Ixf)^2+(Iyb)^2+(Iyf)^2);
                    else
                        if Ixf>0
                           Ixf=0;
                        end
                        if Iyf>0
                           Iyf=0;
                        end
                        DeltaI=sqrt((Ixb)^2+(Ixf)^2+(Iyb)^2+(Iyf)^2);
                    end
                    It(i,j)=Beta*DeltaI;
                    I_degrade(i,j)=I_degrade(i,j)+deltat*It(i,j);
                end
            end
        end
        Gh=imfilter(I_degrade,H);   %Calcul du gradient selon x
        Gg=imfilter(I_degrade,G);   %Calcul du gradient selon y
        Gh2=imfilter(I_degrade,Gh); %Calcul du gradient second selon x
        Gg2=imfilter(I_degrade,Gg); %Calcul du gradient second selon y
        L=Gh2+Gg2;
        [Gx,Gy]=imgradient(I_degrade);
        
     end
        
       
%     for m=1:2
%         for i=174:216
%             for j=144:186
%                 I_degrade(i,j)=imdiffusefilt(I_degrade(i,j));
%             end
%         end
%         m=m+1;
%     end
% 
% 
% end


figure(10);
imshow(I_degrade);
