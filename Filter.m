
function varargout = Filter(varargin)
% FILTER MATLAB code for Filter.fig
%      FILTER, by itself, creates a new FILTER or raises the existing
%      singleton*.
%
%      H = FILTER returns the handle to a new FILTER or the handle to
%      the existing singleton*.
%
%      FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTER.M with the given input arguments.
%
%      FILTER('Property','Value',...) creates a new FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Filter

% Last Modified by GUIDE v2.5 09-Jun-2019 23:21:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Filter_OpeningFcn, ...
                   'gui_OutputFcn',  @Filter_OutputFcn, ...
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


% --- Executes just before Filter is made visible.
function Filter_OpeningFcn(hObject, eventdata, handles, varargin)
clc
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Filter (see VARARGIN)

% Choose default command line output for Filter
handles.output = hObject;
handles.xp_array=[];
handles.zeros_array=[];%imaginary
handles.poles_array=[];
handles.zeros_array_column=[];
handles.poles_array_column=[];
handles.zero_clicks = [];
handles.pole_clicks = [];
handles.yp_array=[];
handles.yp2=[];%software mood bs myrsmsh
handles.xp2=[];
handles.xz2=[];
handles.yz2=[];
handles.xz_array=[];
handles.yz_array=[];
handles.axes_extention = 1.2;
handles.mode=1;
handles.FS=150;
handles.signal=0;
handles.pole_clicks=[];
handles.zero_clicks=[];
handles.clicked=0;
handles.clickedM=0;
handles.up=0;
handles.down=0;
handles.left=0;
handles.right=0;
handles.browsecounter=0;
handles.x=0;
handles.y=0;
handles.counter=0;
handles.off_on=1;
handles.dragmode=1;
handles.current=1;
handles.currentfilter=1;
%set(handles.axes1,'ButtonDownFcn',@OnMouse);
%plot(handles.filtered_signal(1:1000,1))
% set(ax(1),'xData',handles.clicked_x);
% set(ax(1),'ydata',handles.clicked_y);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
handles = guidata(gca);
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
guidata(hObject, handles);


% --- Executes on button press in Browse_button.
function Browse_button_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.browsecounter=handles.browsecounter+1;

% [file,filename]= uigetfile('.csv;.xls;*.xlsx');
% handles.signal= xlsread([filename,file]);
% axes(handles.axes4);
% plot(handles.signal(1:1000,1))
% hold on;
handles.browsecounter=handles.browsecounter+1;

% [file,filename]= uigetfile('.csv;.xls;*.xlsx');
% handles.signal= xlsread([filename,file]);
% axes(handles.axes4);
% plot(handles.signal(1:1000,1))
% hold on;
if handles.browsecounter>0
cla(handles.axes4,'reset');
[file,filename]= uigetfile('*.csv;*.xls;*.xlsx');
handles.signal= xlsread([filename,file]);
  if (handles.off_on ==1)
  axes(handles.axes4);
    plot(handles.signal(1:1000,1))
    hold on;

  else if (handles.off_on ==2)
    
       while (handles.current<size(handles.signal,1))
    
    
          handles.on_screen_dynamic_play(handles.current,1)=handles.signal(handles.current,1);
          axes(handles.axes4);
          plot(handles.on_screen_dynamic_play,'Color',[0 1 0]);
          hold on;
%           handles.on_screen_dynamic_playfilter(handles.currentfilter,1)=handles.filtered_signal(handles.currentfilter,1);
%           axes(handles.axes4);
%           plot(handles.on_screen_dynamic_playfilter,'Color',[1 0 0]);
    
          handles.current=handles.current+1;
          handles.currentfilter=handles.currentfilter+1;
%     set(handles.axes1,'Color','black');
%     set(handles.axes1,'GridColor',[0 204/255 0]);
%     set(handles.axes1,'MinorGridAlpha',0.5);
%     set(handles.axes1,'XMinorGrid','on');
%     set(handles.axes1,'YMinorGrid','on');
%     set(handles.axes1,'XColor',[0 204/255 0]);
%     set(handles.axes1,'YColor',[0 204/255 0]);
         set(handles.axes4,'XLim',[handles.current-(size(handles.signal,1)/20)/2,handles.current+(size(handles.signal,1)/20)/2]);
         set(handles.axes4,'YLim',[min(handles.signal) max(handles.signal)]);
    %set(handles.axes1,'CameraTarget',[handles.current,0,0]);
    %set(handles.axes1,'DataAspectRatio',[handles.current/handles.scaling,1,1]);
         drawnow limitrate
%          set(handles.axes4,'XLim',[handles.currentfilter-(size(handles.filtered_signal,1)/20)/2,handles.currentfilter+(size(handles.filtered_signal,1)/20)/2]);
%          set(handles.axes4,'YLim',[min(handles.filtered_signal) max(handles.filtered_signal)]);
%          drawnow limitrate
%set(handles.browseEdit,'String',handles.filename)
      end
end
end
end
guidata(hObject,handles);


% --- Executes on button press in AddZero.
function AddZero_Callback(hObject, eventdata, handles)
% hObject    handle to AddZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     if  handles.mode==1 
         [x,y]=ginput(1);
%          axes_handle = gca;
%          handles.h=impoint(gca, []);
%          handles.h2=handles.h;
         %pos=getPosition(handles.h);
         %setString(handles.h,'o');
%          handles.points = get(axes_handle,'currentpoint');
%          x=handles.points(1);
%          y=handles.points(1,2);
%          x
%          y  
         handles.xz  = x;
         handles.yz  = y;
         handles.xz2(end+1)=handles.xz;
         handles.yz2(end+1)=handles.yz;
         handles.xz2(end+1)=handles.xz;
         handles.yz2(end+1)=-handles.yz;
         handles.xz_array(end+1)=handles.xz;
         handles.zero_clicks(end+1)= handles.xz;
         handles.zero_clicks(end+2) = handles.yz;
         handles.zero_clicks(end-1) =[];
         
         handles.yz_array(end+1)=handles.yz;
         
         handles.zeros_array=handles.xz2+i.*handles.yz2;
        
         handles.zeros_array_column=transpose(handles.zeros_array);
        
         axes(handles.axes1);
         plot(handles.xz_array,handles.yz_array,'O','markersize',20);
         else if handles.mode==2
           
         [x,y]=ginput(1);
       
         handles.xz  = x;
         handles.yz  = y;
         handles.xz_array(end+1)=handles.xz;
         handles.yz_array(end+1)=handles.yz;
         handles.zero_clicks(end+1)=handles.xz;
         handles.zero_clicks(end+1)=handles.yz;
         handles.zero_clicks(end+1)=handles.xz;
         handles.zero_clicks(end+1)=-handles.yz;
 handles.xz_array(end+1)=handles.xz;
         handles.yz_array(end+1)=-handles.yz;
         handles.zeros_array=handles.xz_array+i.*handles.yz_array;
         handles.zeros_array_column=transpose(handles.zeros_array);
         
         axes(handles.axes1);
         plot( handles.zeros_array,'O','markersize',20); 
      end
     end 

    theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for j=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(j));
         end
     end
     
     for t=1:length(z_coordinate)
         for j=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(j)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
guidata(hObject, handles);

% --- Executes on button press in AddPoles.
function AddPoles_Callback(hObject, eventdata, handles)
% hObject    handle to AddPoles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  handles.mode==1 
    [x,y]=ginput(1);
    handles.xp  = x;
    handles.yp  = y;
    handles.xp_array(end+1)=handles.xp;%ZEROES_X
    handles.yp_array(end+1)=handles.yp;%ZEROS_Y
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=handles.yp;
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=-handles.yp;
    handles.pole_clicks(end+1)= handles.xp;
    handles.pole_clicks(end+2) = handles.yp;
    handles.pole_clicks(end-1) =[];
    
    handles.poles_array=handles.xp2+i.*handles.yp2;
    handles.poles_array_column=transpose(handles.poles_array);
    axes(handles.axes1);
    plot(handles.xp_array,handles.yp_array,'X','markersize',20);
    else if handles.mode==2

          [x,y]=ginput(1);
          handles.xp  = x;
          handles.yp  = y;
          handles.xp_array(end+1)=handles.xp;
          handles.yp_array(end+1)=handles.yp;
          handles.xp_array(end+1)=handles.xp;
          handles.yp_array(end+1)=-handles.yp;
          handles.pole_clicks(end+1)=handles.xp;
          handles.pole_clicks(end+2)=handles.yp;
          handles.pole_clicks(end+3)=handles.xp;
          handles.pole_clicks(end+4)=-handles.yp;
          
          handles.pole_clicks
          "Poles X-Coordinates"
          handles.xp_array
          "Poles Y-Coordinates"
          handles.yp_array
          handles.poles_array=handles.xp_array+i.*handles.yp_array;
          handles.poles_array_column=transpose(handles.poles_array);
         %handles.zeros_array(end+1)=handles.xp_array -i.*handles.yp_array;
          axes(handles.axes1);
          plot(handles.poles_array,'X','markersize',20); 
    end
end
 theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for j=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(j));
         end
     end
     
     for t=1:length(z_coordinate)
         for j=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(j)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))

guidata(hObject, handles);



         
% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if  handles.mode==1 

[x,y]=ginput(1);
indexOfXPoles = find(handles.pole_clicks>(x-0.05) & handles.pole_clicks<(x+0.05));
indexOfXZeros = find(handles.zero_clicks>(x-0.05) & handles.zero_clicks<(x+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);
indexOfZeroValues = find(handles.pole_clicks == 0);
indexOfXZeros
          for iterator= 1:size(indexOfZeroValues,2)
              index = indexOfZeroValues(iterator);
              handles.pole_clicks(index) = [];
              indexOfZeroValues = indexOfZeroValues - 1;
          end
handles.pole_clicks


for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>(y-0.05) & handles.pole_clicks<(y+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>(y-0.05) & handles.zero_clicks<(y+0.05));
counterYZeros = size(indexOfYZeros,2);
indexOfYZeros
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    if handles.mode == 2
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yp_array(ceil(indexOfYPoles/4))= [];
    handles.xp_array(ceil(indexOfXPoles/4))= [];
    end
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
    

    
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    if handles.mode == 2
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yp_array(ceil(indexOfYPoles/4))= [];
    handles.xp_array(ceil(indexOfXPoles/4))= [];
    handles.yp_array(ceil(indexOfYPoles/4))= [];
    handles.xp_array(ceil(indexOfXPoles/4))= [];
    end
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];

elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    if handles.mode == 2
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yp_array(ceil(indexOfYPoles/4))= [];
    handles.xp_array(ceil(indexOfXPoles/4))= [];
    handles.yp_array(ceil(indexOfYPoles/4))= [];
    handles.xp_array(ceil(indexOfXPoles/4))= [];
    end
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


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

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);

theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for jj=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(jj));
         end
     end
     
     for t=1:length(z_coordinate)
         for jj=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(jj)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
% end 


% if handles.mode==2
%     [xx,yy]=ginput(2);
%     x=xx(1,1);
%     y=yy(1,1);
%     x1=xx(2,1);
%     y1=yy(2,1)
% indexOfXPoles = find(handles.pole_clicks>(x-0.05) & handles.pole_clicks<(x+0.05));
% indexOfXZeros = find(handles.zero_clicks>(x-0.05) & handles.zero_clicks<(x+0.05));
% counterXPoles = size(indexOfXPoles,2);
% counterXZeros = size(indexOfXZeros,2);
% 
% for iterator = 1:counterXPoles-1
%     if mod(indexOfXPoles(iterator),2) == 0
%         indexOfXPoles(iterator) =[];
%         counterXPoles = counterXPoles - 1;
%     end
% end
% for iterator = 1:counterXZeros-1
%     if mod(indexOfXZeros(iterator),2) == 0
%         indexOfXZeros(iterator) =[];
%         counterXZeros = counterXZeros - 1;
%     end
% end
% indexOfYPoles = find(handles.pole_clicks>(y-0.05) & handles.pole_clicks<(y+0.05));
% counterYPoles = size(indexOfYPoles,2);
% indexOfYZeros = find(handles.zero_clicks>(y-0.05) & handles.zero_clicks<(y+0.05));
% counterYZeros = size(indexOfYZeros,2);
% for iterator = 1:counterYPoles-2
%     if mod(indexOfYPoles(iterator),2) ~= 0
%         indexOfYPoles(iterator) =[];
%         counterYPoles = counterYPoles - 1;
%     end
% end
% for iterator = 1:counterYZeros-2
%     if mod(indexOfYZeros(iterator),2) ~= 0
%         indexOfYZeros(iterator) =[];
%         counterYZeros = counterYZeros - 1;
%     end
% end
% 
% if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
%     indexOfXPoles = indexOfYPoles-1;
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
%     indexOfYPoles = indexOfXPoles+1;
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% elseif indexOfYPoles == indexOfXPoles+1
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% end
% 
% 
% if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
%     indexOfXZeros = indexOfYZeros-1;
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
%     indexOfYZeros = indexOfXZeros+1;
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% elseif indexOfYZeros == indexOfXZeros+1
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% end
% 
% 
% cla(handles.axes1,'reset');
% axes(handles.axes1)
% ce = exp(j*2*pi*(0:.01:1));
% h = line(real(ce),imag(ce));
% set(h,'linestyle',':','color','b','HitTest','off')
% % draw the cartesian coordinates
% h = line([0 0],[-handles.axes_extention handles.axes_extention]);
% set(h,'linestyle',':','color','b','HitTest','off')
% h = line([-handles.axes_extention handles.axes_extention],[0 0]);
% set(h,'linestyle',':','color','b','HitTest','off')
% axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
% hold on
% grid on
% xlabel('Real(z)');
% ylabel('Imag(z)');
% 
% plot(handles.xp_array,handles.yp_array,'x','markersize',20);
% plot(handles.xz_array,handles.yz_array,'o','markersize',20);
% handles.zeros_array=handles.xz_array+i.*handles.yz_array;
% handles.zeros_array_column=transpose(handles.zeros_array);
% handles.poles_array=handles.xp_array+i.*handles.yp_array;
% handles.poles_array_column=transpose(handles.poles_array);
% %"Poles"
% handles.xp_array
% handles.yp_array
% %"Zeros"
% handles.xz_array
% handles.yz_array
% theta = 0:0.01:pi;
% theta=transpose(theta);
% z_coordinate=ones(315,1);
% length(z_coordinate)
% a=z_coordinate.*sin(theta);
% b=z_coordinate.*cos(theta);
% z_coordinate=a+b*i;
% fs=handles.FS;
% Frequency= linspace(0,fs./2,315);
% [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
% Polynomial_tf= tf(num_coeff,den_coeff);
% 
% for k =1:length(z_coordinate)
%     substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
%     substitution_in_tf=substitution_in_tf(:);
%     gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
% end
% axes(handles.axes3);
% plot (Frequency,gain_matlab)
% %Gain_manual();
% distance=ones(315,1);
% %handles.zeros_array_column
% for t=1:length(z_coordinate)
%     for w=1:length(handles.zeros_array_column)
%         distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
%     end
% end
% 
% for t=1:length(z_coordinate)
%     for w=1:length(handles.poles_array_column)
%         distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
%     end
% end
% manual_gain=20*log10(distance);
% axes(handles.axes2);
% plot(Frequency, manual_gain);
% handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
% cla(handles.axes4,'reset');
% axes(handles.axes4)
% %plot(handles.signal(1:1000,1))
% hold on;
% %plot(handles.filtered_signal(1:1000,1))
% indexOfXPoles = find(handles.pole_clicks>(x1-0.05) & handles.pole_clicks<(x1+0.05));
% indexOfXZeros = find(handles.zero_clicks>(x1-0.05) & handles.zero_clicks<(x1+0.05));
% counterXPoles = size(indexOfXPoles,2);
% counterXZeros = size(indexOfXZeros,2);
% 
% for iterator = 1:counterXPoles-1
%     if mod(indexOfXPoles(iterator),2) == 0
%         indexOfXPoles(iterator) =[];
%         counterXPoles = counterXPoles - 1;
%     end
% end
% for iterator = 1:counterXZeros-1
%     if mod(indexOfXZeros(iterator),2) == 0
%         indexOfXZeros(iterator) =[];
%         counterXZeros = counterXZeros - 1;
%     end
% end
% indexOfYPoles = find(handles.pole_clicks>(y1-0.05) & handles.pole_clicks<(y1+0.05));
% counterYPoles = size(indexOfYPoles,2);
% indexOfYZeros = find(handles.zero_clicks>(y1-0.05) & handles.zero_clicks<(y1+0.05));
% counterYZeros = size(indexOfYZeros,2);
% for iterator = 1:counterYPoles-2
%     if mod(indexOfYPoles(iterator),2) ~= 0
%         indexOfYPoles(iterator) =[];
%         counterYPoles = counterYPoles - 1;
%     end
% end
% for iterator = 1:counterYZeros-2
%     if mod(indexOfYZeros(iterator),2) ~= 0
%         indexOfYZeros(iterator) =[];
%         counterYZeros = counterYZeros - 1;
%     end
% end
% 
% if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
%     indexOfXPoles = indexOfYPoles-1;
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
%     indexOfYPoles = indexOfXPoles+1;
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% elseif indexOfYPoles == indexOfXPoles+1
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% end
% 
% 
% if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
%     indexOfXZeros = indexOfYZeros-1;
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
%     indexOfYZeros = indexOfXZeros+1;
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% elseif indexOfYZeros == indexOfXZeros+1
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% end
% 
% 
% cla(handles.axes1,'reset');
% axes(handles.axes1)
% ce = exp(j*2*pi*(0:.01:1));
% h = line(real(ce),imag(ce));
% set(h,'linestyle',':','color','b','HitTest','off')
% % draw the cartesian coordinates
% h = line([0 0],[-handles.axes_extention handles.axes_extention]);
% set(h,'linestyle',':','color','b','HitTest','off')
% h = line([-handles.axes_extention handles.axes_extention],[0 0]);
% set(h,'linestyle',':','color','b','HitTest','off')
% axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
% hold on
% grid on
% xlabel('Real(z)');
% ylabel('Imag(z)');
% 
% plot(handles.xp_array,handles.yp_array,'x','markersize',20);
% plot(handles.xz_array,handles.yz_array,'o','markersize',20);
% handles.zeros_array=handles.xz_array+i.*handles.yz_array;
% handles.zeros_array_column=transpose(handles.zeros_array);
% handles.poles_array=handles.xp_array+i.*handles.yp_array;
% handles.poles_array_column=transpose(handles.poles_array);
% %"Poles"
% handles.xp_array
% handles.yp_array
% %"Zeros"
% handles.xz_array
% handles.yz_array
% theta = 0:0.01:pi;
% theta=transpose(theta);
% z_coordinate=ones(315,1);
% length(z_coordinate)
% a=z_coordinate.*sin(theta);
% b=z_coordinate.*cos(theta);
% z_coordinate=a+b*i;
% fs=handles.FS;
% Frequency= linspace(0,fs./2,315);
% [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
% Polynomial_tf= tf(num_coeff,den_coeff);
% 
% for k =1:length(z_coordinate)
%     substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
%     substitution_in_tf=substitution_in_tf(:);
%     gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
% end
% axes(handles.axes3);
% plot (Frequency,gain_matlab)
% %Gain_manual();
% distance=ones(315,1);
% %handles.zeros_array_column
% for t=1:length(z_coordinate)
%     for w=1:length(handles.zeros_array_column)
%         distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
%     end
% end
% 
% for t=1:length(z_coordinate)
%     for w=1:length(handles.poles_array_column)
%         distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
%     end
% end
% manual_gain=20*log10(distance);
% axes(handles.axes2);
% plot(Frequency, manual_gain);
% handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
% cla(handles.axes4,'reset');
% axes(handles.axes4)
% %plot(handles.signal(1:1000,1))
% hold on;
% %plot(handles.filtered_signal(1:1000,1))
% end 
guidata(hObject, handles);

% --- Executes on selection change in MODE.
function MODE_Callback(hObject, eventdata, handles)
% hObject    handle to MODE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns MODE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MODE
handles.contents=get(hObject,'Value');
handles.contents
if handles.contents==1
    handles.mode=1;
else if handles.contents==2
        handles.mode=2;
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function MODE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MODE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Freq_Callback(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.FS=str2double(get(hObject,'String'));
handles.FS
% Hints: get(hObject,'String') returns contents of Freq as text
%        str2double(get(hObject,'String')) returns contents of Freq as a double
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DZZ.
function DZZ_Callback(hObject, eventdata, handles)
% hObject    handle to DZZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DZZ
[handles.x,handles.y]=ginput(2);
handles.x
handles.y
x=handles.x(2,1);%lel rasm
y=handles.y(2,1);
xx=handles.x(1,1);
yy=handles.y(1,1);
xx
yy

indexOfXPoles = find(handles.pole_clicks>(xx-0.05) & handles.pole_clicks<(xx+0.05));
indexOfXZeros = find(handles.zero_clicks>((xx)-0.05) & handles.zero_clicks<((xx)+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>(yy-0.05) & handles.pole_clicks<(yy+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>(yy-0.05) & handles.zero_clicks<(yy+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


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

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))


    handles.xz  = x;
    handles.yz  = y;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=handles.yz;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=-handles.yz;
    handles.xz_array(end+1)=handles.xz;
    handles.zero_clicks(end+1)= handles.xz;
    handles.zero_clicks(end+2) = handles.yz;
    handles.zero_clicks(end-1) =[];
    'xpoints'
    handles.xz_array
    handles.yz_array(end+1)=handles.yz;
    'ypoints'
    handles.yz_array
    handles.zeros_array=handles.xz2+i.*handles.yz2;
    'array'
    handles.zeros_array
    handles.zeros_array_column=transpose(handles.zeros_array);
    'arraytrans'
    handles.zeros_array_column
    axes(handles.axes1);
    axes(handles.axes1);
    plot(handles.xz_array,handles.yz_array,'O','markersize',20);
    theta = 0:0.01:pi;
    theta=transpose(theta);
    z_coordinate=ones(315,1);
    length(z_coordinate)
    x=z_coordinate.*cos(theta);
    y=z_coordinate.*sin(theta);
    z_coordinate=x+y*i;
    fs=handles.FS;
    Frequency= linspace(0,fs./2,315);
    [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
    Polynomial_tf= tf(num_coeff,den_coeff);
    for k =1:length(z_coordinate)
        substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
        substitution_in_tf=substitution_in_tf(:);
        gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
    end
    axes(handles.axes3);
    plot (Frequency,gain_matlab)
    %Gain_manual();
    distance=ones(315,1);
    %handles.zeros_array_column
    for t=1:length(z_coordinate)
        for jj=1:length(handles.zeros_array_column)
            distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(jj));
        end
    end
    
    for t=1:length(z_coordinate)
        for jj=1:length(handles.poles_array_column)
            distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(jj)));
        end
    end
    manual_gain=20*log10(distance);
    axes(handles.axes2);
    plot(Frequency, manual_gain);
    handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
    cla(handles.axes4,'reset');
    axes(handles.axes4)
    %plot(handles.signal(1:1000,1))
    hold on;
    %plot(handles.filtered_signal(1:1000,1))

 guidata(hObject,handles);


% --- Executes on button press in drag.
function drag_Callback(hObject, eventdata, handles)
% hObject    handle to drag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drag
[handles.x,handles.y]=ginput(1);
indexOfXPoles = find(handles.pole_clicks>(handles.x-0.05) & handles.pole_clicks<(handles.x+0.05));
indexOfXZeros = find(handles.zero_clicks>(handles.x-0.05) & handles.zero_clicks<(handles.x+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>(handles.y-0.05) & handles.pole_clicks<(handles.y+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>(handles.y-0.05) & handles.zero_clicks<(handles.y+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


% cla(handles.axes1,'reset');
% axes(handles.axes1)
% ce = exp(j*2*pi*(0:.01:1));
% h = line(real(ce),imag(ce));
% set(h,'linestyle',':','color','b','HitTest','off')
% % draw the cartesian coordinates
% h = line([0 0],[-handles.axes_extention handles.axes_extention]);
% set(h,'linestyle',':','color','b','HitTest','off')
% h = line([-handles.axes_extention handles.axes_extention],[0 0]);
% set(h,'linestyle',':','color','b','HitTest','off')
% axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
% hold on
% grid on
% xlabel('Real(z)');
% ylabel('Imag(z)');

%plot(handles.xp_array,handles.yp_array,'x','markersize',20);
%plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
fs=handles.FS;
Frequency= linspace(0,fs./2,315);
[num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
    substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
    substitution_in_tf=substitution_in_tf(:);
    gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
%Gain_manual();
distance=ones(315,1);
%handles.zeros_array_column
for t=1:length(z_coordinate)
    for w=1:length(handles.zeros_array_column)
        distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
    end
end

for t=1:length(z_coordinate)
    for w=1:length(handles.poles_array_column)
        distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
    end
end
manual_gain=20*log10(distance);
%axes(handles.axes2);
%plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
%cla(handles.axes4,'reset');
%axes(handles.axes4)
%plot(handles.signal(1:1000,1))
%hold on;
%plot(handles.filtered_signal(1:1000,1))
guidata(hObject, handles);


% --- Executes on button press in Left.
function Left_Callback(hObject, eventdata, handles)
% hObject    handle to Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.counter=handles.counter+0.1;
c2=handles.counter-0.1;
if handles.counter>0.1
indexOfXPoles = find(handles.pole_clicks>((handles.x-c2)-0.05) & handles.pole_clicks<((handles.x-c2)+0.05));
indexOfXZeros = find(handles.zero_clicks>((handles.x-c2)-0.05) & handles.zero_clicks<((handles.x-c2)+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>(handles.y-0.05) & handles.pole_clicks<(handles.y+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>(handles.y-0.05) & handles.zero_clicks<(handles.y+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


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

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))

if  handles.dragmode==1;
    'innn'
    handles.xz  = handles.x-handles.counter;
    handles.yz  = handles.y;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=handles.yz;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=-handles.yz;
    handles.xz_array(end+1)=handles.xz;
    handles.zero_clicks(end+1)= handles.xz;
    handles.zero_clicks(end+2) = handles.yz;
    handles.zero_clicks(end-1) =[];
    'xpoints'
    handles.xz_array
    handles.yz_array(end+1)=handles.yz;
    'ypoints'
    handles.yz_array
    handles.zeros_array=handles.xz2+i.*handles.yz2;
    'array'
    handles.zeros_array
    handles.zeros_array_column=transpose(handles.zeros_array);
    'arraytrans'
    handles.zeros_array_column
    axes(handles.axes1);
    axes(handles.axes1);
    plot(handles.xz_array,handles.yz_array,'O','markersize',20);
   theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
elseif  handles.dragmode==2;
   'inpole'
    handles.xp = handles.x-handles.counter;
    handles.yp  = handles.y;
    handles.xp_array(end+1)=handles.xp;%ZEROES_X
    handles.yp_array(end+1)=handles.yp;%ZEROS_Y
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=handles.yp;
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=-handles.yp;
    handles.pole_clicks(end+1)= handles.xp;
    handles.pole_clicks(end+2) = handles.yp;
    handles.pole_clicks(end-1) =[];
    handles.poles_array=handles.xp2+i.*handles.yp2;
    handles.poles_array
    handles.poles_array_column=transpose(handles.poles_array);
    axes(handles.axes1);
    plot(handles.xp_array,handles.yp_array,'X','markersize',20);
     theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
end
end
guidata(hObject, handles);


% --- Executes on button press in Down.
function Down_Callback(hObject, eventdata, handles)
% hObject    handle to Down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.counter=handles.counter+0.1;
c2=handles.counter-0.1;
if handles.counter>0.1
indexOfXPoles = find(handles.pole_clicks>((handles.x)-0.05) & handles.pole_clicks<((handles.x)+0.05));
indexOfXZeros = find(handles.zero_clicks>((handles.x)-0.05) & handles.zero_clicks<((handles.x)+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>((handles.y-c2)-0.05) & handles.pole_clicks<((handles.y-c2)+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>((handles.y-c2)-0.05) & handles.zero_clicks<((handles.y-c2)+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


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

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
fs=handles.FS;
Frequency= linspace(0,fs./2,315);
[num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
    substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
    substitution_in_tf=substitution_in_tf(:);
    gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
%Gain_manual();
distance=ones(315,1);
%handles.zeros_array_column
for t=1:length(z_coordinate)
    for w=1:length(handles.zeros_array_column)
        distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
    end
end

for t=1:length(z_coordinate)
    for w=1:length(handles.poles_array_column)
        distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
    end
end
manual_gain=20*log10(distance);
axes(handles.axes2);
plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
cla(handles.axes4,'reset');
axes(handles.axes4)
plot(handles.signal(1:1000,1))
hold on;


    if  handles.dragmode==1;
    'innn'
    handles.xz  = handles.x;
    handles.yz  = handles.y-handles.counter;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=handles.yz;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=-handles.yz;
    handles.xz_array(end+1)=handles.xz;
    handles.zero_clicks(end+1)= handles.xz;
    handles.zero_clicks(end+2) = handles.yz;
    handles.zero_clicks(end-1) =[];
    'xpoints'
    handles.xz_array
    handles.yz_array(end+1)=handles.yz;
    'ypoints'
    handles.yz_array
    handles.zeros_array=handles.xz2+i.*handles.yz2;
    'array'
    handles.zeros_array
    handles.zeros_array_column=transpose(handles.zeros_array);
    'arraytrans'
    handles.zeros_array_column
    axes(handles.axes1);
    axes(handles.axes1);
    plot(handles.xz_array,handles.yz_array,'O','markersize',20);
   theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
elseif  handles.dragmode==2;
     'inpole'
    handles.xp = handles.x;
    handles.yp  = handles.y-handles.counter;
    handles.xp_array(end+1)=handles.xp;%ZEROES_X
    handles.yp_array(end+1)=handles.yp;%ZEROS_Y
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=handles.yp;
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=-handles.yp;
    handles.pole_clicks(end+1)= handles.xp;
    handles.pole_clicks(end+2) = handles.yp;
    handles.pole_clicks(end-1) =[];
    handles.poles_array=handles.xp2+i.*handles.yp2;
    handles.poles_array
    handles.poles_array_column=transpose(handles.poles_array);
    axes(handles.axes1);
    plot(handles.xp_array,handles.yp_array,'X','markersize',20);
     theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
   end



    
end
guidata(hObject, handles);


% --- Executes on button press in Up.
function Up_Callback(hObject, eventdata, handles)
% hObject    handle to Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.counter=handles.counter+0.1;
c2=handles.counter-0.1;
if handles.counter>0.1
indexOfXPoles = find(handles.pole_clicks>(handles.x-0.05) & handles.pole_clicks<(handles.x+0.05));
indexOfXZeros = find(handles.zero_clicks>(handles.x-0.05) & handles.zero_clicks<(handles.x+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>((handles.y+c2)-0.05) & handles.pole_clicks<((handles.y+c2)+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>((handles.y+c2)-0.05) & handles.zero_clicks<((handles.y+c2)+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


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

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
fs=handles.FS;
Frequency= linspace(0,fs./2,315);
[num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
    substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
    substitution_in_tf=substitution_in_tf(:);
    gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
%Gain_manual();
distance=ones(315,1);
%handles.zeros_array_column
for t=1:length(z_coordinate)
    for w=1:length(handles.zeros_array_column)
        distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
    end
end

for t=1:length(z_coordinate)
    for w=1:length(handles.poles_array_column)
        distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
    end
end
manual_gain=20*log10(distance);
axes(handles.axes2);
plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
cla(handles.axes4,'reset');
axes(handles.axes4)
plot(handles.signal(1:1000,1))
hold on;


   if  handles.dragmode==1;
    'innn'
    handles.xz  = handles.x;
    handles.yz  = handles.y+handles.counter;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=handles.yz;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=-handles.yz;
    handles.xz_array(end+1)=handles.xz;
    handles.zero_clicks(end+1)= handles.xz;
    handles.zero_clicks(end+2) = handles.yz;
    handles.zero_clicks(end-1) =[];
    'xpoints'
    handles.xz_array
    handles.yz_array(end+1)=handles.yz;
    'ypoints'
    handles.yz_array
    handles.zeros_array=handles.xz2+i.*handles.yz2;
    'array'
    handles.zeros_array
    handles.zeros_array_column=transpose(handles.zeros_array);
    'arraytrans'
    handles.zeros_array_column
    axes(handles.axes1);
    axes(handles.axes1);
    plot(handles.xz_array,handles.yz_array,'O','markersize',20);
   theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
elseif  handles.dragmode==2;
    'inpole'
    handles.xp = handles.x;
    handles.y  = handles.y+handles.counter;
    handles.xp_array(end+1)=handles.xp;%ZEROES_X
    handles.yp_array(end+1)=handles.yp;%ZEROS_Y
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=handles.yp;
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=-handles.yp;
    handles.pole_clicks(end+1)= handles.xp;
    handles.pole_clicks(end+2) = handles.yp;
    handles.pole_clicks(end-1) =[];
    handles.poles_array=handles.xp2+i.*handles.yp2;
    handles.poles_array
    handles.poles_array_column=transpose(handles.poles_array);
    axes(handles.axes1);
    plot(handles.xp_array,handles.yp_array,'X','markersize',20);
     theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
   end


    
end
guidata(hObject, handles);


% --- Executes on button press in Right.
function Right_Callback(hObject, eventdata, handles)
% hObject    handle to Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.counter=handles.counter+0.1;
c2=handles.counter-0.1;
if handles.counter>0.1
indexOfXPoles = find(handles.pole_clicks>((handles.x+c2)-0.05) & handles.pole_clicks<((handles.x+c2)+0.05));
indexOfXZeros = find(handles.zero_clicks>((handles.x+c2)-0.05) & handles.zero_clicks<((handles.x+c2)+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>(handles.y-0.05) & handles.pole_clicks<(handles.y+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>(handles.y-0.05) & handles.zero_clicks<(handles.y+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


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

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
fs=handles.FS;
Frequency= linspace(0,fs./2,315);
[num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
    substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
    substitution_in_tf=substitution_in_tf(:);
    gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
%Gain_manual();
distance=ones(315,1);
%handles.zeros_array_column
for t=1:length(z_coordinate)
    for w=1:length(handles.zeros_array_column)
        distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
    end
end

for t=1:length(z_coordinate)
    for w=1:length(handles.poles_array_column)
        distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
    end
end
manual_gain=20*log10(distance);
axes(handles.axes2);
plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
cla(handles.axes4,'reset');
axes(handles.axes4)
plot(handles.signal(1:1000,1))
hold on;

if  handles.dragmode==1;
    'innn'
    handles.xz  = handles.x+handles.counter;
    handles.yz  = handles.y;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=handles.yz;
    handles.xz2(end+1)=handles.xz;
    handles.yz2(end+1)=-handles.yz;
    handles.xz_array(end+1)=handles.xz;
    handles.zero_clicks(end+1)= handles.xz;
    handles.zero_clicks(end+2) = handles.yz;
    handles.zero_clicks(end-1) =[];
    'xpoints'
    handles.xz_array
    handles.yz_array(end+1)=handles.yz;
    'ypoints'
    handles.yz_array
    handles.zeros_array=handles.xz2+i.*handles.yz2;
    'array'
    handles.zeros_array
    handles.zeros_array_column=transpose(handles.zeros_array);
    'arraytrans'
    handles.zeros_array_column
    axes(handles.axes1);
    axes(handles.axes1);
    plot(handles.xz_array,handles.yz_array,'O','markersize',20);
   theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
elseif  handles.dragmode==2;
    'inpole'
    handles.xp = handles.x+handles.counter;
    handles.yp  = handles.y;
    handles.xp_array(end+1)=handles.xp;%ZEROES_X
    handles.yp_array(end+1)=handles.yp;%ZEROS_Y
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=handles.yp;
    handles.xp2(end+1)=handles.xp;
    handles.yp2(end+1)=-handles.yp;
    handles.pole_clicks(end+1)= handles.xp;
    handles.pole_clicks(end+2) = handles.yp;
    handles.pole_clicks(end-1) =[];
    handles.poles_array=handles.xp2+i.*handles.yp2;
    handles.poles_array
    handles.poles_array_column=transpose(handles.poles_array);
    axes(handles.axes1);
    plot(handles.xp_array,handles.yp_array,'X','markersize',20);
     theta = 0:0.01:pi;
     theta=transpose(theta);
     z_coordinate=ones(315,1);
     length(z_coordinate)
     x=z_coordinate.*cos(theta);
     y=z_coordinate.*sin(theta);
     z_coordinate=x+y*i;
     fs=handles.FS;
     Frequency= linspace(0,fs./2,315);
     [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
     [gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
     gain_matlab=20*log10(abs(gain_matlab));
     axes(handles.axes3);
     plot (Frequency,gain_matlab)
     %Gain_manual();
     distance=ones(315,1);
     %handles.zeros_array_column
     for t=1:length(z_coordinate)
         for w=1:length(handles.zeros_array_column)
             distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
         end
     end
     
     for t=1:length(z_coordinate)
         for w=1:length(handles.poles_array_column)
             distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
         end
     end
     manual_gain=20*log10(distance);
     axes(handles.axes2);
     plot(Frequency, manual_gain);
     handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
     cla(handles.axes4,'reset');
     axes(handles.axes4)
     plot(handles.signal(1:1000,1))
     hold on;
     plot(handles.filtered_signal(1:1000,1))
end
end
guidata(hObject, handles);


% --- Executes on button press in DPP.
function DPP_Callback(hObject, eventdata, handles)
% hObject    handle to DPP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DPP
% [handles.x,handles.y]=ginput(2);
% handles.x
% handles.y
% x=handles.x(2,1);%lel rasm
% y=handles.y(2,1);
% xx=handles.x(1,1);
% yy=handles.y(1,1);
% xx
% yy
% 
% indexOfXPoles = find(handles.pole_clicks>(xx-0.05) & handles.pole_clicks<(xx+0.05));
% indexOfXZeros = find(handles.zero_clicks>((xx)-0.05) & handles.zero_clicks<((xx)+0.05));
% counterXPoles = size(indexOfXPoles,2);
% counterXZeros = size(indexOfXZeros,2);
% 
% for iterator = 1:counterXPoles-1
%     if mod(indexOfXPoles(iterator),2) == 0
%         indexOfXPoles(iterator) =[];
%         counterXPoles = counterXPoles - 1;
%     end
% end
% for iterator = 1:counterXZeros-1
%     if mod(indexOfXZeros(iterator),2) == 0
%         indexOfXZeros(iterator) =[];
%         counterXZeros = counterXZeros - 1;
%     end
% end
% indexOfYPoles = find(handles.pole_clicks>(yy-0.05) & handles.pole_clicks<(yy+0.05));
% counterYPoles = size(indexOfYPoles,2);
% indexOfYZeros = find(handles.zero_clicks>(yy-0.05) & handles.zero_clicks<(yy+0.05));
% counterYZeros = size(indexOfYZeros,2);
% for iterator = 1:counterYPoles-2
%     if mod(indexOfYPoles(iterator),2) ~= 0
%         indexOfYPoles(iterator) =[];
%         counterYPoles = counterYPoles - 1;
%     end
% end
% for iterator = 1:counterYZeros-2
%     if mod(indexOfYZeros(iterator),2) ~= 0
%         indexOfYZeros(iterator) =[];
%         counterYZeros = counterYZeros - 1;
%     end
% end
% 
% if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
%     indexOfXPoles = indexOfYPoles-1;
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
%     indexOfYPoles = indexOfXPoles+1;
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% elseif indexOfYPoles == indexOfXPoles+1
%     handles.pole_clicks(indexOfYPoles)=[];
%     handles.pole_clicks(indexOfXPoles)=[];
%     handles.yp_array(ceil(indexOfYPoles/2))= [];
%     handles.xp_array(ceil(indexOfXPoles/2))= [];
% end
% 
% 
% if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
%     indexOfXZeros = indexOfYZeros-1;
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
%     indexOfYZeros = indexOfXZeros+1;
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% elseif indexOfYZeros == indexOfXZeros+1
%     handles.zero_clicks(indexOfYZeros)=[];
%     handles.zero_clicks(indexOfXZeros)=[];
%     handles.yz_array(ceil(indexOfYZeros/2))= [];
%     handles.xz_array(ceil(indexOfXZeros/2))= [];
% end
% 
% 
% cla(handles.axes1,'reset');
% axes(handles.axes1)
% ce = exp(j*2*pi*(0:.01:1));
% h = line(real(ce),imag(ce));
% set(h,'linestyle',':','color','b','HitTest','off')
% % draw the cartesian coordinates
% h = line([0 0],[-handles.axes_extention handles.axes_extention]);
% set(h,'linestyle',':','color','b','HitTest','off')
% h = line([-handles.axes_extention handles.axes_extention],[0 0]);
% set(h,'linestyle',':','color','b','HitTest','off')
% axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
% hold on
% grid on
% xlabel('Real(z)');
% ylabel('Imag(z)');
% 
% plot(handles.xp_array,handles.yp_array,'x','markersize',20);
% plot(handles.xz_array,handles.yz_array,'o','markersize',20);
% handles.zeros_array=handles.xz_array+i.*handles.yz_array;
% handles.zeros_array_column=transpose(handles.zeros_array);
% handles.poles_array=handles.xp_array+i.*handles.yp_array;
% handles.poles_array_column=transpose(handles.poles_array);
% %"Poles"
% handles.xp_array
% handles.yp_array
% %"Zeros"
% handles.xz_array
% handles.yz_array
% theta = 0:0.01:pi;
% theta=transpose(theta);
% z_coordinate=ones(315,1);
% length(z_coordinate)
% a=z_coordinate.*sin(theta);
% b=z_coordinate.*cos(theta);
% z_coordinate=a+b*i;
% fs=handles.FS;
% Frequency= linspace(0,fs./2,315);
% [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
% Polynomial_tf= tf(num_coeff,den_coeff);
% 
% for k =1:length(z_coordinate)
%     substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
%     substitution_in_tf=substitution_in_tf(:);
%     gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
% end
% axes(handles.axes3);
% plot (Frequency,gain_matlab)
% %Gain_manual();
% distance=ones(315,1);
% %handles.zeros_array_column
% for t=1:length(z_coordinate)
%     for w=1:length(handles.zeros_array_column)
%         distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
%     end
% end
% 
% for t=1:length(z_coordinate)
%     for w=1:length(handles.poles_array_column)
%         distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
%     end
% end
% manual_gain=20*log10(distance);
% axes(handles.axes2);
% plot(Frequency, manual_gain);
% handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
% cla(handles.axes4,'reset');
% axes(handles.axes4)
% %plot(handles.signal(1:1000,1))
% hold on;
%     handles.xp  = x;
%     handles.yp  = y;
%     handles.xp_array(end+1)=handles.xp;%ZEROES_X
%     handles.xp_array
%     handles.yp_array(end+1)=handles.yp;%ZEROS_Y
%     handles.yp_array
%     handles.xp2(end+1)=handles.xp;
%     handles.yp2(end+1)=handles.yp;
%      handles.xp2(end+1)=handles.xp;
%     handles.yp2(end+1)=-handles.yp;
%     handles.pole_clicks(end+1)= handles.xp;
%     handles.pole_clicks(end+2) = handles.yp;
%     handles.pole_clicks(end-1) =[];
%     handles.pole_clicks
%     handles.yp_array
%     handles.poles_array=handles.xp2+i.*handles.yp2;
%     'poles'
%     handles.poles_array
%     handles.poles_array_column=transpose(handles.poles_array);
%     axes(handles.axes1);
%     plot(handles.xp_array,handles.yp_array,'X','markersize',20);
% end 



% --- Executes on selection change in Onlinemode.
function Onlinemode_Callback(hObject, eventdata, handles)
% hObject    handle to Onlinemode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Onlinemode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Onlinemode
handles.contents=get(hObject,'Value');
handles.contents
if handles.contents==1
    handles.off_on=1;
else if handles.contents==2
        handles.off_on=2;
        
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Onlinemode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Onlinemode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
[handles.x,handles.y]=ginput(1);
indexOfXPoles = find(handles.pole_clicks>(handles.x-0.05) & handles.pole_clicks<(handles.x+0.05));
indexOfXZeros = find(handles.zero_clicks>(handles.x-0.05) & handles.zero_clicks<(handles.x+0.05));
counterXPoles = size(indexOfXPoles,2);
counterXZeros = size(indexOfXZeros,2);

for iterator = 1:counterXPoles-1
    if mod(indexOfXPoles(iterator),2) == 0
        indexOfXPoles(iterator) =[];
        counterXPoles = counterXPoles - 1;
    end
end
for iterator = 1:counterXZeros-1
    if mod(indexOfXZeros(iterator),2) == 0
        indexOfXZeros(iterator) =[];
        counterXZeros = counterXZeros - 1;
    end
end
indexOfYPoles = find(handles.pole_clicks>(handles.y-0.05) & handles.pole_clicks<(handles.y+0.05));
counterYPoles = size(indexOfYPoles,2);
indexOfYZeros = find(handles.zero_clicks>(handles.y-0.05) & handles.zero_clicks<(handles.y+0.05));
counterYZeros = size(indexOfYZeros,2);
for iterator = 1:counterYPoles-2
    if mod(indexOfYPoles(iterator),2) ~= 0
        indexOfYPoles(iterator) =[];
        counterYPoles = counterYPoles - 1;
    end
end
for iterator = 1:counterYZeros-2
    if mod(indexOfYZeros(iterator),2) ~= 0
        indexOfYZeros(iterator) =[];
        counterYZeros = counterYZeros - 1;
    end
end

if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
    indexOfXPoles = indexOfYPoles-1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
    indexOfYPoles = indexOfXPoles+1;
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
elseif indexOfYPoles == indexOfXPoles+1
    handles.pole_clicks(indexOfYPoles)=[];
    handles.pole_clicks(indexOfXPoles)=[];
    handles.yp_array(ceil(indexOfYPoles/2))= [];
    handles.xp_array(ceil(indexOfXPoles/2))= [];
end


if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
    indexOfXZeros = indexOfYZeros-1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
    indexOfYZeros = indexOfXZeros+1;
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
elseif indexOfYZeros == indexOfXZeros+1
    handles.zero_clicks(indexOfYZeros)=[];
    handles.zero_clicks(indexOfXZeros)=[];
    handles.yz_array(ceil(indexOfYZeros/2))= [];
    handles.xz_array(ceil(indexOfXZeros/2))= [];
end


% cla(handles.axes1,'reset');
% axes(handles.axes1)
% ce = exp(j*2*pi*(0:.01:1));
% h = line(real(ce),imag(ce));
% set(h,'linestyle',':','color','b','HitTest','off')
% % draw the cartesian coordinates
% h = line([0 0],[-handles.axes_extention handles.axes_extention]);
% set(h,'linestyle',':','color','b','HitTest','off')
% h = line([-handles.axes_extention handles.axes_extention],[0 0]);
% set(h,'linestyle',':','color','b','HitTest','off')
% axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
% hold on
% grid on
% xlabel('Real(z)');
% ylabel('Imag(z)');

%plot(handles.xp_array,handles.yp_array,'x','markersize',20);
%plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
fs=handles.FS;
Frequency= linspace(0,fs./2,315);
[num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
    substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
    substitution_in_tf=substitution_in_tf(:);
    gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
% axes(handles.axes3);
% plot (Frequency,gain_matlab)
% %Gain_manual();
distance=ones(315,1);
%handles.zeros_array_column
for t=1:length(z_coordinate)
    for w=1:length(handles.zeros_array_column)
        distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));
    end
end

for t=1:length(z_coordinate)
    for w=1:length(handles.poles_array_column)
        distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
    end
end
manual_gain=20*log10(distance);
% axes(handles.axes2);
% plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
% cla(handles.axes4,'reset');
% axes(handles.axes4)
%plot(handles.signal(1:1000,1))
hold on;
%plot(handles.filtered_signal(1:1000,1))
handles.contents=get(hObject,'Value');
handles.contents
if handles.contents==1
   handles.dragmode=1;
else if handles.contents==2
        handles.dragmode=2;
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
