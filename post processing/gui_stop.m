function varargout = gui_stop(varargin)
%GUI_STOP M-file for gui_stop.fig
%      GUI_STOP, by itself, creates a new GUI_STOP or raises the existing
%      singleton*.
%
%      H = GUI_STOP returns the handle to a new GUI_STOP or the handle to
%      the existing singleton*.
%
%      GUI_STOP('Property','Value',...) creates a new GUI_STOP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to gui_stop_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_STOP('CALLBACK') and GUI_STOP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_STOP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_stop

% Last Modified by GUIDE v2.5 04-Nov-2014 14:09:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_stop_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_stop_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before gui_stop is made visible.
function gui_stop_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for gui_stop
 
load('data_gui.mat');

handles.dataStopsAvgWait   = data_avgwait;
handles.dataStopsBusArrive = data_busarrive;
handles.current_data = handles.dataStopsAvgWait{1};
handles.current_time = handles.dataStopsBusArrive{1};

plot(handles.axes1,handles.current_time,handles.current_data);

handles.data_boxplot    = data_boxplot;
handles.date_boxplot_id = data_boxplot_id;

boxplot(handles.axes2,handles.data_boxplot,handles.date_boxplot_id)

handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_stop wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_stop_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in plot_popup.
function plot_popup_Callback(hObject, eventdata, handles)
% hObject    handle to plot_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plot_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot_popup

stopId = get(hObject, 'Value');
handles.current_data = handles.dataStopsAvgWait{stopId};
handles.current_time = handles.dataStopsBusArrive{stopId};
plot(handles.axes1,handles.current_time,handles.current_data);

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function plot_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
