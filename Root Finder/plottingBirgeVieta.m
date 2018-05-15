function plottingBirgeVieta (graph, f, root, aArray, bArray, cArray, itr)
syms x
%plotting function with found root
axes(graph.axes1);
grid on;
cla;
fplot(f,'color','b');
hold on;
line([root root],get(graph.axes1,'YLim'),'color','r');
hold off;
%plotting table
coefficients = coeffs(f(x), 'All');
orderOfPoly = size(coefficients,2);
colNames = zeros(1,orderOfPoly);
for j = 1: orderOfPoly
    aArray(j) = coefficients(j);
    colNames(j) = orderOfPoly - j;
end 
f = figure;
a = uitable(f,'Data',aArray,'Position',[280 100 262 204]);
b = uitable(f,'Position',[10 220 262 204]);
c = uitable(f,'Position',[10 10 262 204]);
a.ColumnName = {colNames};
b.ColumnName = {colNames};
c.ColumnName = {colNames};
for i = 1:itr
existingData = get(b,'Data');
newData = [existingData; bArray(:,:,i)];
set(b,'Data',newData);

existingData = get(c,'Data');
newData = [existingData; cArray(:,:,i)];
set(c,'Data',newData);
end