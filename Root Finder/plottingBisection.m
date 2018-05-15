function plottingBisection(graph, Xupper, Xlower, Xmid, f, itr,error, step, type)
if type == 'S'
    plottingBisectionStep(graph,  Xupper, Xlower, Xmid, f, itr,error, step);
else 
    plottingBisectionFast(graph, Xupper, Xlower, Xmid, f, itr, error);
end



function plottingBisectionStep (graph,  Xupper, Xlower, Xmid, f, itr, error, step)

matrix = [Xlower(1,step), Xupper(1,step),Xmid(1,step), error(1, step)];
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

xo = Xlower(1);
xend = Xupper(1);
margin = abs(xo-xend);

margin = margin/6;

if (xo < xend)
    startPoint = xo-margin;
    endPoint = xend+margin;
else
    startPoint = xend-margin;
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

xu=Xupper(step);
hold on;       
plot([xu xu],yl,'g')

xl=Xlower(step);
hold on;       
plot([xl xl],yl,'y')  

pause(1);

mid=Xmid(step);
hold on;       
plot([mid mid],yl,'r')

grid on;


function plottingBisectionFast (graph,  Xupper, Xlower, Xmid, f,itr, error)

xo = Xlower(1);
xend = Xupper(1);
margin = abs(xo-xend);

margin = margin/6;

if (xo < xend)
    startPoint = xo-margin;
    endPoint = xend+margin;
else
    startPoint = xend-margin;
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
    
    xu=Xupper(loops);
    hold on;       
    plot([xu xu],yl,'g')

    xl=Xlower(loops);
    hold on;       
    plot([xl xl],yl,'y')  
    
    pause(1);

    mid=Xmid(loops);
    hold on;       
    plot([mid mid],yl,'r')
    pause(2);

    
    matrix = [Xlower(1,loops), Xupper(1,loops),Xmid(1,loops), error(1, loops)];
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