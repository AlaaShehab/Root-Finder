function varargout = GUINum2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUINum2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUINum2_OutputFcn, ...
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

% --------------------------------------------------------------------

function GUINum2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.counter = 1;
guidata(hObject, handles);
% --------------------------------------------------------------------

function varargout = GUINum2_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;

% --------------------------------------------------------------------

function stepByStep_Callback(hObject, eventdata, handles)
global o;
global bvo;
result = get(o);
step = handles.counter;
popup_sel_index = get(handles.popupmenu1, 'Value');
type = 'S';
if handles.counter > result.itr
    set(handles.stepByStep, 'Enable','off');
    return
end
handles.counter = handles.counter + 1;
guidata(hObject, handles);
axes(handles.axes1);
title(char(result.f));
xlabel('X-axis');
ylabel('Y-axis');
switch popup_sel_index
    case 1
	set(handles.table, 'columnName', {'f(x)', "f'(x)", 'f', 'xio','error'});
	set(handles.table,'Visible','on');
    	plottingNewton(handles, result.fxi, result.dfxi, result.f, result.xio, result.xi1, result.root, result.itr,result.error, step, type);
    case 2
        result = get(bvo);
        plottingBirgeVieta (handles, result.f, result.root, result.aArray, result.bArray, result.cArray, result.itr)
    case 3
        set(handles.table, 'columnName', {'xl', "xu", 'xr','error'});
        set(handles.table,'Visible','on');
        plottingBisection(handles, result.xi2, result.xio, result.xi1, result.f, result.itr, result.error, step, type);
    case 4
        set(handles.table, 'columnName', {'xl', "xu", 'xr', 'error'});
        set(handles.table,'Visible','on');
        plottingFalsePosition(handles, result.xi1, result.xio, result.xi2, result.f, result.itr,result.error, step, type);
    case 5
	set(handles.table, 'columnName', {'g(x)', 'Xr','error'});
	set(handles.table,'Visible','on');
        plottingFixedPoint(handles, result.f, result.xio, result.xi1, result.root, result.itr,result.error, step, type);
    case 6
          set(handles.table, 'columnName', {'xi-1', 'xi', 'xi+1', 'error'});
	     set(handles.table,'Visible','on');
        plottingSecant(handles, result.f, result.xio, result.xi1, result.xi2, result.root, result.itr,result.error, step, type);
    case 7
        set(handles.table, 'columnName', {'roots'});
	     set(handles.table,'Visible','on');
        plottingGeneralAlgorithm (handles, result.f, result.xio, result.itr);
end

% --------------------------------------------------------------------

function fastMode_Callback(hObject, eventdata, handles)
global o;
global bvo;
%missing plotting the table of output
set(handles.table, 'Data', cell(size(get(handles.table,'Data'))));
type = 'F';
step = 0;
popup_sel_index = get(handles.popupmenu1, 'Value');
set(handles.solve, 'Enable','off');
set(handles.stepByStep, 'Enable','off');
result = get(o);
axes(handles.axes1);
title(char(result.f));
xlabel('X-axis');
ylabel('Y-axis');
switch popup_sel_index
    case 1
	set(handles.table, 'columnName', {'f(x)', "f'(x)", 'f', 'xio','error'});
	set(handles.table,'Visible','on');
    	plottingNewton(handles, result.fxi, result.dfxi, result.f, result.xio, result.xi1, result.root, result.itr,result.error, step, type);
    case 2
		result = get(bvo);
        plottingBirgeVieta (handles, result.f, result.root, result.aArray, result.bArray, result.cArray, result.itr)
    case 3
        set(handles.table, 'columnName', {'xl', "xu", 'xr','error'});
        set(handles.table,'Visible','on');
        plottingBisection(handles, result.xi2, result.xio, result.xi1, result.f, result.itr,result.error, step, type);
    case 4
       set(handles.table, 'columnName', {'xl', "xu", 'xr', 'error'});
        set(handles.table,'Visible','on');
        plottingFalsePosition(handles, result.xi1, result.xio, result.xi2, result.f, result.itr,result.error, step, type);
    case 5
	set(handles.table, 'columnName', {'g(x)', 'Xr','error'});
	set(handles.table,'Visible','on');
        plottingFixedPoint(handles, result.f, result.xio, result.xi1, result.root, result.itr,result.error, step, type);
    case 6
        set(handles.table, 'columnName', {'xi-1', 'xi', 'xi+1','error'});
	     set(handles.table,'Visible','on');
        plottingSecant(handles, result.f, result.xio, result.xi1, result.xi2, result.root, result.itr,result.error, step, type);
    case 7
        set(handles.table, 'columnName', {'roots'});
	     set(handles.table,'Visible','on');
       plottingGeneralAlgorithm (handles, result.f, result.xio, result.itr)
end
set(handles.solve, 'Enable','on');
set(handles.stepByStep, 'Enable','on');

% --------------------------------------------------------------------


function popupmenu1_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla;
set(handles.solve, 'enable', 'on');
popup_sel_index = get(handles.popupmenu1, 'Value');
if (popup_sel_index == 1 || popup_sel_index == 2 || popup_sel_index == 5) 
    set(handles.editX1, 'enable', 'off');
else 
    set(handles.editX1, 'enable', 'on');
end

% --------------------------------------------------------------------

function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {"Newton Raphson", "Bierge Vieta", "Bisection", "False Position","Fixed Point", "Secant", "General Algorithm"});

% --------------------------------------------------------------------

function editXo_Callback(hObject, eventdata, handles)

function editXo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------

function editX1_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------

function editX1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------

function editFunc_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------

function editFunc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------

function editTolerance_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------

function editTolerance_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------

function editMaxItr_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------

function editMaxItr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------


function solve_Callback(hObject, eventdata, handles)
disbaleButtons(handles);
set(handles.table, 'Data', cell(size(get(handles.table,'Data'))));
syms f(x);
try
    f(x) = get(handles.editFunc, 'String');
    validEq = true;
catch
    msgbox('InValid Equation!!');
    return;
end

x1 = str2double(get(handles.editX1, 'String'));
x0 = str2double(get(handles.editXo, 'String'));

x1Enabled = strcmp(handles.editX1.Enable, 'on');
if (~isnan(x0) && ((~isnan(x1) && x1Enabled)|| ~x1Enabled) && validEq)
    getRoot(hObject, handles);
else 
	msgbox('InValid Input!! Make sure Initial values are correct');
end

%-----------------------------------------------------------------------
function disbaleButtons(handles)
    set(handles.root,'Visible','off');
    set(handles.Es,'Visible','off');
    set(handles.exTime,'Visible','off');
    set(handles.itr,'Visible','off');
    set(handles.stepByStep, 'Enable','off');
    set(handles.fastMode, 'Enable','off');
%----------------------------------------------------------------------

function getRoot(hObject, handles)
handles.counter = 1;
guidata(hObject, handles);

axes(handles.axes1);
cla;

global o;
global bvo;

popup_sel_index = get(handles.popupmenu1, 'Value');

syms f(x);
f(x) = get(handles.editFunc, 'String');
Es = str2double(get(handles.editTolerance, 'String'));
MaxItr = str2double(get(handles.editMaxItr, 'String'));
x1 = str2double(get(handles.editX1, 'String'));
x0 = str2double(get(handles.editXo, 'String'));

if (isnan(Es) || Es < 0) 
Es = 0.0001;
end

if (isnan(MaxItr) || MaxItr <= 0) 
MaxItr = 50;
end

switch popup_sel_index
    case 1
    	[fxi,dfxi,oldX,newX,root,itr,error,errorMsg,time] = newtonRaphson(f, x0, Es, MaxItr);
        o = output(fxi, dfxi, f, oldX, newX, [], root, itr, error);
        
            if errorMsg ~= "VALID"
                 msgbox(char(errorMsg));
            return;
            end
      
        setTextField(handles, error, root, time, itr);
    case 2
          [aArray, bArray, cArray, root, error, errorMsg, itr, time] = BirgeVieta(f,x0,Es,MaxItr);
        bvo = BVoutput(aArray, bArray, cArray, f, root, itr, error);
         if errorMsg ~= "VALID"
                 msgbox(char(errorMsg));
            return;
         end
        setTextField(handles, error, root, time, itr);
    case 3
		[root, xls, xus, xrs, itr, error, errorMsg, time] = bisection(f,x0, x1, Es, MaxItr);
        o = output([], [], f, xls, xrs,xus,root,itr, error);
         if errorMsg ~= "VALID"
                 msgbox(char(errorMsg));
            return;
         end
        setTextField(handles, error, root, time, itr);
    case 4
		[root, xls, xus, xrs, error, errorMsg, time, itr] = false_position(f, x0, x1, Es, MaxItr);
        o = output([], [], f, xls,xus, xrs, root, itr, error);
           if errorMsg ~= "VALID"
                 msgbox(char(errorMsg));
            return;
            end
        setTextField(handles, error, root, time, itr);
    case 5
	[gx,oldX,newX,root,itr,error,errorMsg,time] = fixedPoint(f, x0, Es, MaxItr);
        o = output([], [], gx, oldX, newX, [], root, itr, error);
        
            if errorMsg ~= "VALID"
                 msgbox(char(errorMsg));
            return;
            end
        
        setTextField(handles, error, root, time, itr);
    case 6
        [root,error,x0, x1, newX, itr ,time,errorMsg] = secant(f, x0, x1,Es, MaxItr);
        o = output([], [], f, x0, x1, newX, root, itr, error);       
            if errorMsg ~= "VALID"
                  msgbox(char(errorMsg));
               return;
            end
        setTextField(handles, error, root, time, itr);
    case 7
        [roots, iter, errorMsg] = generalAlgorithm(get(handles.editFunc, 'String'), x0, x1, Es);
        o = output([], [], f, roots, [], [], NaN, iter, []);
        if errorMsg ~= "VALID"
                  msgbox(char(errorMsg));
               return;
            end
        set(handles.stepByStep, 'Enable','on');
        set(handles.fastMode, 'Enable','on');
end
%-------------------------------------------------------
function setTextField(handles, error, root, time, itr)
    string = 'Root : ';
    string = strcat(string, num2str(root));
    set(handles.root,'string',string);
    set(handles.root,'Visible','On');

    string = 'Error : ';
    string = strcat(string, num2str(error(itr)));
    set(handles.Es,'string',string);
    set(handles.Es,'Visible','On');

    string = 'Exe Time : ';
    string = strcat(string, num2str(time));
    set(handles.exTime,'string',string);
    set(handles.exTime,'Visible','On');

    string = 'Iteration : ';
    string = strcat(string, num2str(itr));
    set(handles.itr,'string',string);
    set(handles.itr,'Visible','On');

    set(handles.stepByStep, 'Enable','on');
    set(handles.fastMode, 'Enable','on');
%-----------------------------------------------------------------------

function root_Callback(hObject, eventdata, handles)

function root_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------------------------------------------------------------


function Es_Callback(hObject, eventdata, handles)

function Es_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------------------------------------------------------------

function exTime_Callback(hObject, eventdata, handles)

function exTime_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%-----------------------------------------------------------------------

function itr_Callback(hObject, eventdata, handles)

function itr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%-------------------------------------%
function LF_Callback(hObject, eventdata, handles)
[filename1,filepath1]=uigetfile({'*.txt','All Files'},...
  'Select Data File 1');
  [equation, x0, x1, ess, iter, method] = readFile(filename1);
  
  if (~isnan(x0))
      (set(handles.editTolerance, 'String',ess));
  (set(handles.editMaxItr, 'String', iter));
  if(~isnan(x1))
  (set(handles.editX1, 'String', x1));
  end
 (set(handles.editXo, 'String', x0));
 set(handles.editFunc, 'String', equation);
 set(handles.popupmenu1, 'Value', str2double(method));
    getRoot(hObject, handles);
  else 
	msgbox('InValid Input!! Make sure Initial values are correct');
  end
    
