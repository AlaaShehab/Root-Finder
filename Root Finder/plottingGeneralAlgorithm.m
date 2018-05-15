function plottingGeneralAlgorithm (graph, f, roots, iter)
syms x
axes(graph.axes1);
grid on;
cla;
fplot(f,'color','b');
hold on;

for i = 1:size(roots,2)
    hold on;
    line([roots(i) roots(i)],get(graph.axes1,'YLim'),'color','r');
end
hold off;

matrix = [roots];
set(graph.table,'Data',matrix);

