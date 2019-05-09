function varargout = tryingg(varargin)
% TRYINGG MATLAB code for tryingg.fig
%      TRYINGG, by itself, creates a new TRYINGG or raises the existing
%      singleton*.
%
%      H = TRYINGG returns the handle to a new TRYINGG or the handle to
%      the existing singleton*.
%
%      TRYINGG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRYINGG.M with the given input arguments.
%
%      TRYINGG('Property','Value',...) creates a new TRYINGG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tryingg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tryingg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tryingg

% Last Modified by GUIDE v2.5 09-May-2019 02:47:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tryingg_OpeningFcn, ...
                   'gui_OutputFcn',  @tryingg_OutputFcn, ...
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


% --- Executes just before tryingg is made visible.
function tryingg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tryingg (see VARARGIN)

% Choose default command line output for tryingg
handles.output = hObject;
handles.xp_array=[];
handles.zeros_array=[];%imaginary
handles.poles_array=[];
handles.yp_array=[];
handles.xz_array=[];
handles.yz_array=[];
handles.axes_extention = 1.2;
handles.contents=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tryingg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tryingg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
axes(handles.axes1);
%%draw the circle
ce = exp(j*2*pi*(0:.01:1));
h = line(real(ce),imag(ce));
set(h,'linestyle',':','color','b','HitTest','off')
% draw the cartesian coordinates
h = line([0 0],[-handles.axes_extention handles.axes_extention]);
set(h,'linestyle',':','color','b','HitTest','off')
h = line([-handles.axes_extention handles.axes_extention],[0 0]);
set(h,'linestyle',':','color','b','HitTest','off')
axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
hold on
grid on
xlabel('Real(z)');
ylabel('Imag(z)');
% axes(handles.axes1)
% t=-1:.01:1;
% round=sqrt(1-t.^2);     
% round2=-sqrt(1-t.^2);
% plot(t,round)
% hold on
% grid on
% plot(t,round2)      % Plots the circle with unit radius - lower semicircle
% axis([1 0 1 0])


% --- Executes on button press in Addzeros.
function Addzeros_Callback(hObject, eventdata, handles)
% hObject    handle to Addzeros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.Addzeros,'value')
    handles.contents
    if  handles.contents==1 
        'in'
         axes_handle = gca;
         handles.poles = get(axes_handle,'currentpoint');
         handles.xz  = handles.poles(1);
         handles.yz  = handles.poles(1,2);
         handles.xz_array(end+1)=handles.xz;
         handles.xz_array
         handles.yz_array(end+1)=handles.yz;
         handles.yz_array
         handles.zeros_array=handles.xz_array+i.*handles.yz_array;
         handles.zeros_array
         plot(handles.xz_array,handles.yz_array,'O','markersize',20);
     else if handles.contents==2
             'in2'
          axes_handle = gca;
         handles.poles = get(axes_handle,'currentpoint');
         handles.xz  = handles.poles(1);
         handles.yz  = handles.poles(1,2);
         handles.xz_array(end+1)=handles.xz;
         handles.xz_array
         handles.yz_array(end+1)=handles.yz;
         handles.yz_array
         handles.xz_array(end+1)=handles.xz;
         handles.yz_array(end+1)=-handles.yz;
         handles.zeros_array=handles.xz_array+i.*handles.yz_array;
         %handles.zeros_array(end+1)=handles.xz_array +i.*handles.yz_array;
         handles.zeros_array
         plot(handles.xz_array,handles.yz_array,'O','markersize',20); 
      end
    end    
end
guidata(hObject,handles);



% --- Executes on button press in Addpoles.
function Addpoles_Callback(hObject, eventdata, handles)
% hObject    handle to Addpoles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.Addpoles,'value')
         axes_handle = gca;
         handles.poles = get(axes_handle,'currentpoint');
         handles.xp  = handles.poles(1);
         handles.yp  = handles.poles(1,2);
         handles.xp_array(end+1)=handles.xp;
         handles.xp_array
         handles.yp_array(end+1)=handles.yp;
         handles.yp_array
         handles.poles_array=handles.xp_array+i.*handles.yp_array;
         handles.poles_array
         plot(handles.xp_array,handles.yp_array,'x','markersize',20);
       
end
guidata(hObject,handles);



% --- Executes on button press in DeleteZeros.
function DeleteZeros_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteZeros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  axes_handle = gca;
  [x,y]=ginput(1);
  x
  y
  %temp=find((handles.xp_array & handles.yp_array);
  %handles.yp_array(find(handles.yp_array<(y+0.3))& (handles.yp_array>(y+.3)))=[];
  %temp=find((real(handles.z <(x+0.1)) & real(handles.z>(x-0.1))));
  %temp=find((handles.xp_array<(x)& (handles.xp_array>x));
  %temp
  %handles.xp_array(find(handles.xp_array<(x+0.1))& (handles.xp_array>(x-0.1)))=[];
  %handles.yp_array(find(real(handles.yp_array<(y+0.1)))& real((handles.yp_array>(y-0.1))))=[];
  handles.xz_array(find(handles.xz_array==(x)))=[];
  handles.yz_array(find(handles.yz_array==(y)))=[];
  handles.xz_array
  handles.yz_array
  handles.zeros_array=handles.xz_array+i.*handles.yz_array;
  cla(handles.axes1,'reset'); 
  axes(handles.axes1)
  ce = exp(j*2*pi*(0:.01:1)); 
  h = line(real(ce),imag(ce));
  set(h,'linestyle',':','color','b','HitTest','off')
  % draw the cartesian coordinates
  h = line([0 0],[-handles.axes_extention handles.axes_extention]);
  set(h,'linestyle',':','color','b','HitTest','off')
  h = line([-handles.axes_extention handles.axes_extention],[0 0]);
  set(h,'linestyle',':','color','b','HitTest','off')
  axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
  hold on
  grid on
  xlabel('Real(z)');
  ylabel('Imag(z)');
  %   c_draw(hObject, eventdata, handles);
  %    hold on
  plot(handles.xz_array,handles.yz_array,'O','markersize',20);
  plot(handles.xp_array,handles.yp_array,'x','markersize',20);
 %  [a,b,button]=ginput(1);
 % if button==1
%     xz(xz==x)=[];
%     yz(yz==y)=[];
%     plot(xz,yz,'x');
% end 
guidata(hObject,handles);


% --------------------------------------------------------------------
function hardwaremode_Callback(hObject, eventdata, handles)
% hObject    handle to hardwaremode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
%contents = cellstr(get(hObject,'String'));  
handles.contents=get(hObject,'Value');
handles.contents
guidata(hObject,handles);

% if contents==2
%     handles.mode=1;
% end
% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DeletePoles.
function DeletePoles_Callback(hObject, eventdata, handles)
% hObject    handle to DeletePoles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  axes_handle = gca;
  [x,y]=ginput(1);
  x
  y
  handles.xp_array(find(handles.xp_array==(x)))=[];
  handles.yp_array(find(handles.yp_array==(y)))=[];
  handles.xp_array=handles.xp_array;
  handles.yp_array=handles.yp_array;
  'gded'
  handles.xp_array
  handles.yp_array
  handles.poles_array=handles.xp_array+i.*handles.yp_array;
  cla(handles.axes1,'reset'); 
  axes(handles.axes1)
  ce = exp(j*2*pi*(0:.01:1)); 
  h = line(real(ce),imag(ce));
  set(h,'linestyle',':','color','b','HitTest','off')
  % draw the cartesian coordinates
  h = line([0 0],[-handles.axes_extention handles.axes_extention]);
  set(h,'linestyle',':','color','b','HitTest','off')
  h = line([-handles.axes_extention handles.axes_extention],[0 0]);
  set(h,'linestyle',':','color','b','HitTest','off')
  axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
  hold on
  grid on
  xlabel('Real(z)');
  ylabel('Imag(z)');
  %   c_draw(hObject, eventdata, handles);
  %    hold on
  plot(handles.xz_array,handles.yz_array,'O','markersize',20);
  plot(handles.xp_array,handles.yp_array,'x','markersize',20);