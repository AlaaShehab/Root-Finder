function plottingNewton (graph, fxi, dfxi, f, oldX, newX, root, itr,error, step, type)
if type == 'S'
    plottingNewtonStep(graph, fxi, dfxi, f, oldX, newX, root, itr,error ,step);
else 
    plottingNewtonFast(graph, fxi, dfxi, f, oldX, newX, root, itr, error);
end




function plottingNewtonStep (graph, fxi, dfxi, f, oldX, newX, root, itr,error, step)

matrix = [fxi(1,step),dfxi(1,step),oldX(1,step),newX(1,step), error(1, step)];
Data = get(graph.table,'Data')
if(step == 1)
	Data = cell2mat(Data)
end
if(isempty(Data))
	npt = matrix
else
	npt = [Data;matrix];
end
set(graph.table,'Data',npt)

if step > itr 
    return
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
fplot(f,[startPoint endPoint],'color','black')
hold on;

yl = ylim;

oldx=oldX(step);
hold on;
plot([oldx oldx],yl,'g')

xtangent = oldX(step);
ytangent = fxi(step);
syms x;
slope = dfxi(step);
tangent = slope * (x - xtangent) + ytangent;
hold on;
fplot(tangent,[startPoint endPoint],'b')


newx=newX(step);
hold on;
plot([newx newx],yl,'y')

grid on;

function plottingNewtonFast (graph, fxi, dfxi, f, oldX, newX, root, itr, error)

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
    
    xlim([startPoint endPoint]);
    y = 0;
    hold on;
    fplot(y,[startPoint endPoint],'color','black')
    
    hold on;
    fplot(f,[startPoint endPoint],'color','black')
    hold on;
    
    yl = ylim;
        
    oldx=oldX(loops);
    plot([oldx oldx],yl,'g')
    hold on;
    
    xtangent = oldX(loops);
    ytangent = fxi(loops);
    syms x;
    slope = dfxi(loops);
    tangent = slope * (x - xtangent) + ytangent;
    hold on;
    fplot(tangent,[startPoint endPoint],'b')

    pause(1);
    
    newx=newX(loops);
    plot([newx newx],yl,'y')
    hold on;

    pause(2);

matrix = [fxi(1,loops),dfxi(1,loops),oldX(1,loops),newX(1,loops), error(1, loops)]
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
