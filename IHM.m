function varargout = IHM(varargin)
% IHM MATLAB code for IHM.fig
%      IHM, by itself, creates a new IHM or raises the existing
%      singleton*.
%
%      H = IHM returns the handle to a new IHM or the handle to
%      the existing singleton*.
%
%      IHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IHM.M with the given input arguments.
%
%      IHM('Property','Value',...) creates a new IHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IHM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IHM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IHM

% Last Modified by GUIDE v2.5 11-Jun-2018 13:57:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IHM_OpeningFcn, ...
                   'gui_OutputFcn',  @IHM_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before IHM is made visible.
function IHM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IHM (see VARARGIN)
% Choose default command line output for IHM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IHM wait for user response (see UIRESUME)
% uiwait(handles.figure1);
setappdata(0  , 'LePath', gcf);

% --- Outputs from this function are returned to the command line.
function varargout = IHM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in OpenButton.
function OpenButton_Callback(hObject, eventdata, handles)


axes(handles.axes1);
[Filename, Pathname] = uigetfile({'*.*'},'Select your picture(s)','MultiSelect','off');% recupere le chemin de l'image
Chemin= Pathname;
Chemin=strcat(Chemin, Filename);%concatene le chemin et le nom du fichier
Foto=imread(Chemin); 


%adapate les axes et redimensionne en fonction de la taille de l'image
set(handles.axes1,'Units','pixels');
resizePos = get(handles.axes1,'Position');
Foto= imresize(Foto, [resizePos(3) resizePos(3)]);
imagesc(Foto,'hittest','off');
set(handles.axes1,'Units','normalized');
axis manual;

%set(gca,'ButtonDownFcn',{@start_pencil});%appel fonction si clique sur une image 

 
function ButtonDown(hObject, eventData,J)
%saveas(h,'SvgChiffre','jpg')%sauvegarde de l'image
%msgbox(sprintf('Cliqué sur l''image %d',find(h==hObject)));


function DrawButton_Callback(hObject, eventdata, handles)
% hObject    handle to DrawButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(gca,'buttondownfcn',@start_pencil)%envoie vers la fonction start_pencil si on clique sur image

function start_pencil(src,eventdata)
coords=get(src,'currentpoint'); %récupère les info sur la position du curseur
x=coords(1,1,1);
y=coords(1,2,1);

%définition des traits que l'on dessine (position,couleur, largeur..)
r=line(x, y, 'color', [0 0 0],'Linestyle','-' , 'LineWidth', 1, 'hittest', 'off'); %turning     hittset off allows you to draw new lines that start on top of an existing line.
set(gcf,'windowbuttonmotionfcn',{@continue_pencil,r})
set(gcf,'windowbuttonupfcn',@done_pencil)

function continue_pencil(src,eventdata,r)
%Note: src is now the figure handle, not the axes, so we need to use gca.
axis manual;
coords=get(gca,'currentpoint'); %this updates every time i move the mouse
x=coords(1,1,1);
y=coords(1,2,1);
%get the line's existing coordinates and append the new ones.
lastx=get(r,'xdata');  
lasty=get(r,'ydata');
newx=[lastx x];
newy=[lasty y];
set(r,'xdata',newx,'ydata',newy);


function done_pencil(src,evendata)
%all this funciton does is turn the motion function off 
set(gcf,'windowbuttonmotionfcn','')
set(gcf,'windowbuttonupfcn','')

% --- Executes on button press in SaveButton.

function SaveButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% sauvegarde de l'image 

set(gcf, 'PaperPositionMode', 'auto')%save figures that are the same size as the figure on the screen
set(gcf, 'InvertHardCopy', 'off'); % setting 'grid color reset' off
set(gcf,'GraphicsSmoothing','off');%lisser les traits noirs pour ne pas avoir de pixels gris

%esauvegarde de l'image en coupant les axes sur les cotès
ax = gca;
ax.Units = 'pixels';
pos = ax.Position;
marg = -10;
rect = [-marg, -marg, pos(3)+2*marg, pos(4)+2*marg];%taille de l'image "rognée"
%acquiert l'image
f = getframe(gca,rect);
im = frame2im(f);
%sauvegarde de l'image sous le nom image_a_traiter dans le dossier du code
imwrite(im,'data/image_a_traiter.png');


% --- Executes on button press in ProcessingButton.
function ProcessingButton_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ProjetMajeure_couleur(); %appel de la fonction ProjetMajeure_couleur


% --- Executes on button press in ProcessingGrad.
function ProcessingGrad_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingGrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ProjetMajeure_Gradientsvrai();%appel de la fonction ProjetMajeure_Gradientsvrai
