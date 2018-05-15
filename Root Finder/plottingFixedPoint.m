function plottingFixedPoint (graph, g, oldX, newX, root, itr,error, step, type)
if type == 'S'
    plottingFixedPointStep(graph, g, oldX, newX, root, itr,error,  step);
else 
    
    plottingFixedPointFast(graph, g, oldX, newX, root, itr, error);
end




function plottingFixedPointStep (graph, g, oldX, newX, root, itr,error, step)

matrix = [oldX(1,step),newX(1,step), error(1,step)];
Data = get(graph.table,'Data');
if(step == 1)
	Data = cell2mat(Data);
end
if(isempty(Data))
	npt = matrix;
else
	npt = [Data;matrix];
end
set(graph.table,'Data',npt);

if step > itr 
    return;
end
xo = oldX(1);
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
fplot(g,[startPoint endPoint],'color','black')
hold on;

syms y(x)
y(x) = x;
hold on;
fplot(y,[startPoint endPoint],'color','black')

yl = ylim;

oldx=oldX(step);
plot([oldx oldx],yl,'g')
hold on;

horizontalY = feval(g, oldX(step));

y = horizontalY;
hold on;
fplot(y,[startPoint endPoint],'b')

pause(1);

newx=newX(step);
plot([newx newx],yl,'y')
hold on;

grid on;


function plottingFixedPointFast(graph, g, oldX, newX, root, itr, error)

xo = oldX(1);
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
    fplot(g,[startPoint endPoint],'color','black')
    hold on;
    
    syms y(x)
    y(x) = x;
    hold on;
    fplot(y,[startPoint endPoint],'color','black')
    
    yl = ylim;
        
    oldx=oldX(loops);
    plot([oldx oldx],yl,'g')
    hold on;
    
    pause(0.5);
    horizontalY = feval(g, oldX(loops));
    
    y = horizontalY;
    hold on;
    fplot(y,[startPoint endPoint],'b')

    pause(1);
    
    newx=newX(loops);
    plot([newx newx],yl,'y')
    hold on;

    pause(2);

matrix = [oldX(1,loops),newX(1,loops), error(1, loops)]
Data = get(graph.table,'Data')
if(loops == 1)
	Data = cell2mat(Data)
end
if(isempty(Data))
	npt = matrix
else
	npt = [Data;matrix];
end
set(graph.table,'Data',npt)

    loops = loops + 1;
    grid on;
end
