function [Roots, iter, berrorMsg] = generalAlgorithm(f, startInterval, endInterval, es)
equ = inline(f,'x');
syms x
c = coeffs(equ(x), 'All');
number = size(c,2);
Roots = nan(1,number - 1);
berrorMsg = 'VALID';
iter = 1;
isPoly = checkIfPoly(f);
if (isPoly)
    points = linspace(startInterval, endInterval,50);
else
    points = linspace(startInterval, endInterval, 3);
end 
numOfPoints = size(points,2);
if (isPoly)
for i = 1:numOfPoints - 1
    if (iter <= number - 1)
    [root, xls, xus, xrs, itr, error, errorMsg, time] = bisection(equ,points(i),points(i + 1),es,50);
    berrorMsg = errorMsg;
    bRoot = root;
    if (~isnan(bRoot))
        if (~checkIfExist(Roots, bRoot, es))
            Roots(iter) = bRoot;
            iter = iter + 1;
        end
    end 
    else
        break;
    end 
end
else 
for i = 1:numOfPoints - 1
    if (iter <= number - 1)
        [root, err, xs0,xs1, xsn, it, time, errorM] = secant(f,points(i),points(i + 1),es,3); 
        berrorMsg = errorM;
        sRoot = root;
        if (~isnan(sRoot))
           if (sRoot < endInterval && sRoot > startInterval && ~checkIfExist(Roots, sRoot, es))
             Roots(iter) = sRoot;
             iter = iter + 1;
           end 
        end
    else 
        break;
    end 
end 
end 

%f = 'x^2-17*x+60';
%startInterval = 4;
%endInterval = 11;
%es = 0.001;
%generalAlgorithm(f, startInterval, endInterval, es)