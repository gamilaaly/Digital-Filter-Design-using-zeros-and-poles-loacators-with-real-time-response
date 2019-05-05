% there will be 2 modes (combobox to switch between them in GUI)
% play button function (3shan b3d ma adesign el filter a apply it on el
% signal while playing it fe 7alet el live stream or directly fe 7alet el
% offline , so play only can be available for live

 % mode 1 in combobox will indicate offline and mode 2 = live stream
set(handles.slider,'Enable','on'); % in case of using slider
handles.button_state = get(hObject,'Value'); 
if handles.button_state == get(hObject,'Max') % in case play is toggled choosing modes is diabled
    set(handles.modeMenu,'Enable','off');
elseif handles.button_state == get(hObject,'Min')
    set(handles.modeMenu,'Enable','on');
end


if (handles.mode==2) % live stream mode 
while (handles.current<size(handles.signal,1) && handles.button_state == get(hObject,'Max'))
    
    handles.button_state = get(hObject,'Value'); %leeh?
    
    handles.on_screen_dynamic_play(handles.current,1)=handles.signal(handles.current,1);
    set(handles.slider,'Value',handles.current); % in case it's used
    plot(handles.on_screen_dynamic_play,'Color',[0 1 0]);
    
    handles.current=handles.current+1;
    set(handles.axes1,'Color','black');
    set(handles.axes1,'GridColor',[0 204/255 0]);
    set(handles.axes1,'MinorGridAlpha',0.5);
    set(handles.axes1,'XMinorGrid','on');
    set(handles.axes1,'YMinorGrid','on');
    set(handles.axes1,'XColor',[0 204/255 0]);
    set(handles.axes1,'YColor',[0 204/255 0]);
    %kont mstkhdem scaling hena fa mish 3rfa lw shelnash hnzbtha ezay lisa
    set(handles.axes1,'XLim',[handles.current-(size(handles.signal,1)/handles.scaling)/2,handles.current+(size(handles.signal,1)/handles.scaling)/2]);
    set(handles.axes1,'YLim',[min(handles.signal) max(handles.signal)]);
    set(handles.listbox,'String',(handles.current/size(handles.signal,1))/100);
    drawnow limitrate
end
handles.button_state = get(hObject,'Value');
if (handles.button_state == get(hObject,'Min'))
    set(handles.modeMenu,'Enable','on');

    plot(handles.on_screen_dynamic_play,'Color',[0 1 0]);
    
    set(handles.axes1,'Color','black');
    set(handles.axes1,'GridColor',[0 204/255 0]);
    set(handles.axes1,'MinorGridAlpha',0.5);
    set(handles.axes1,'XMinorGrid','on');
    set(handles.axes1,'YMinorGrid','on');
    set(handles.axes1,'XColor',[0 204/255 0]);
    set(handles.axes1,'YColor',[0 204/255 0]);
    %sacaling issue 
    set(handles.axes1,'YLim',[min(handles.signal) max(handles.signal)]);
    set(handles.axes1,'XLim',[handles.current-(size(handles.signal,1)/handles.scaling)/2,handles.current+(size(handles.signal,1)/handles.scaling)/2]);
end
elseif (handles.mode==1)  %offline mode
    
    set(handles.modeMenu,'Enable','on');
   % set(handles.scalingMenu,'Enable','on');
    
    plot(handles.signal,'Color',[0 1 0]);
    set(handles.axes1,'GridColor',[0 204/255 0]);
    set(handles.axes1,'MinorGridAlpha',0.5);
    set(handles.axes1,'XMinorGrid','on');
    set(handles.axes1,'YMinorGrid','on');
    set(handles.axes1,'XColor',[0 204/255 0]);
    set(handles.axes1,'YColor',[0 204/255 0]);
    set(handles.axes1,'Color','black');
    %same issue scaling
    set(handles.axes1,'XLim',[0,(size(handles.signal,1)/handles.scaling)]);
    set(handles.axes1,'YLim',[min(handles.signal) max(handles.signal)]);
end

% ra2yy malosh lazma el scaling 7alyan mish hya target el task w htzwed fel
% fn mish akter

%browse button function
[handles.file,handles.filename]= uigetfile('*.csv;*.xls;*.xlsx');
if ( handles.file ~= 0)
handles.signal= xlsread([handles.filename,handles.file]);
%To reset if any new file is opened
handles.current=1;
set(handles.listbox,'String',{handles.file,handles.filename,size(handles.signal,1)});
% in case if we use slider in offline data mode ( I don't think it's
% necessary here)
set(handles.slider,'Min',0);
set(handles.slider,'Max',size(handles.signal,1));
end