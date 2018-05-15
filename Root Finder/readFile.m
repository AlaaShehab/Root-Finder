function [equation, x0, x1, ess, iter, method] = readFile(path)
 filename = fullfile(char(path));
 t = readtable(filename);
 
 t0 = t{height(t) ,width(t)-1};
 t1 = t{height(t) -1 ,width(t)-1};
 t2 = t{height(t) -2 ,width(t)-1};
 t3 = t{height(t) -3 ,width(t)-1};
 t4 = t{height(t) -4,width(t)-1};

 
 c0 = strsplit(char(t0));
 c1 = strsplit(char(t1));
 c2 = strsplit(char(t2));
 c2 = removeBrackets(c2);
 c3 = strsplit(char(t3));
 c4 = strsplit(char(t4));
 
 c0(strcmp('',c0)) = [];
 c1(strcmp('',c1)) = [];
 c2(strcmp('',c2)) = [];
 c3(strcmp('',c3)) = [];
 c4(strcmp('',c4)) = [];

equation = c3{1};
method = c4{1};
iter = c0{1};
ess = c1{1};
x0 = c2{1};
if(length(c2) > 1)
    x1 = c2{2};
else
    x1 = NaN;
end
end

function value = removeBrackets(c)
for i = 1 :1: length(c)  
    c{i} = erase(c{i},"[");
    c{i} = erase(c{i},"]");
end
value = c;
end
% function [x0,x1] = getInterval(c)
% i = find(~cellfun(@isempty,c));
% if(length(i) > 1) 
% x0 = c{i(1)};
% x1 = c{i(2)};
% else
% x0 =  c{i(1)};
% x1 = NaN;
% end
% 
% end
% function value = getValue(c)
%  i = 1;
% while(isspace(c{i}))
%  i = i+1;
% end
% value = char(c{i});
% end