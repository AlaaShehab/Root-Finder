function plottingSecant (graph, f, oldXo,oldX1, newX, root, itr,error, step, type)
if type == 'S'
    plottingSecantStep(graph, f, oldXo,oldX1, newX, root, itr,error, step);
else 
    plottingSecantFast(graph, f, oldXo,oldX1, newX, root, itr, error);
end




function plottingSecantStep (graph, f, oldXo,oldX1, newX, root, itr,error, step)
matrix = [oldXo(1,step),oldX1(1,step), newX(1,step),error(1,step)];
Data = get(graph.table,'Data');
if(step == 1)
	Data = cell2mat(Data);
end
if(isempty(Data))
	npt = matrix;
else
	npt = [Data;matrix];
end
set(graph.table,'Data',npt)

if step > itr 
    return
end

xo = oldXo(1);
margin = abs(xo-root);
if margin < 1
    margin = margin * 4;
else 
    margin = margin + 1;
end

if (xo < root)
    startPoint = xo-margin;
    endPoint = root+margin;
else
    startPoint = root-margin;
    endPoint = xo+margin;
end

axes(graph.axes1);
grid on;


cla;

y = 0;
hold on;
fplot(y,[startPoint endPoint],'color','black')

hold on;
fplot(f,[startPoint endPoint],'color','black')
hold on;

yl = ylim;

oldxo=oldXo(step);
hold on;
plot([oldxo oldxo],yl,'g')

oldx1=oldX1(step);
hold on;
plot([oldx1 oldx1],yl,'y')


pause(0.5);

xdifference = oldX1(step) - oldXo(step);
y1 = feval(f, oldX1(step));
yo = feval(f,oldXo(step));
ydifference = y1 - yo;
slope = ydifference / xdifference;

hold on;
plot([oldXo(step) oldXo(step)], [yo yo], 'x')
hold on;
plot([oldX1(step) oldX1(step)], [y1 y1], 'x')

syms x;
stLine = slope * (x - oldXo(step)) + yo;
hold on;
fplot(stLine,[startPoint endPoint],'b')

pause(1);

newx=newX(step);
plot([newx newx],yl,'r')
hold on;

grid on;


function plottingSecantFast (graph, f, oldXo,oldX1, newX, root, itr, error)

xo = oldXo(1);
margin = abs(xo-root);
if margin < 1
    margin = margin * 4;
else 
    margin = margin + 1;
end

if (xo < root)
    startPoint = xo-margin;
    endPoint = root+margin;
else
    startPoint = root-margin;
    endPoint = xo+margin;
end

axes(graph.axes1);
grid on;

loops = 1;

while loops <= itr
    cla;
    
    y = 0;
    hold on;
    fplot(y,[startPoint endPoint],'color','black')
    
    hold on;
    fplot(f,[startPoint endPoint],'color','black')
    hold on;
    
    yl = ylim;
        
    oldxo=oldXo(loops);
    hold on;
    plot([oldxo oldxo],yl,'g')
    
    oldx1=oldX1(loops);
    hold on;
    plot([oldx1 oldx1],yl,'y')
    
    
    pause(0.5);

    xdifference = oldX1(loops) - oldXo(loops);
    y1 = feval(f, oldX1(loops));
    yo = feval(f,oldXo(loops));
    ydifference = y1 - yo;
    slope = ydifference / xdifference;
    
    hold on;
    plot([oldXo(loops) oldXo(loops)], [yo yo], 'x')
    hold on;
    plot([oldX1(loops) oldX1(loops)], [y1 y1], 'x')
    
    syms x;
    stLine = slope * (x - oldXo(loops)) + yo;
    hold on;
    fplot(stLine,[startPoint endPoint],'b')

    pause(1);
    
    newx=newX(loops);
    plot([newx newx],yl,'r')
    hold on;

    pause(2);
matrix = [oldXo(1,loops),oldX1(1,loops), newX(1,loops), error(1, loops)];
Data = get(graph.table,'Data');
if(loops == 1)
	Data = cell2mat(Data);
end
if(isempty(Data))
	npt = matrix;
else
	npt = [Data;matrix];
end
set(graph.table,'Data',npt)


    loops = loops + 1;
    grid on;
end