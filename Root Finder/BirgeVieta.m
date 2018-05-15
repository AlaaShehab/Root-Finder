function [aArray, bArray, cArray, root, error, errorMsg, itr, time] = BirgeVieta(f,xo,es,maxit);
tic;
syms x
coefficients = coeffs(f(x), 'All');
orderOfPoly = size(coefficients,2);
initialVal = xo;
aArray = zeros(1,orderOfPoly);
for j = 1: orderOfPoly
    aArray(j) = coefficients(j);
end 
bArray(:,:,maxit) = zeros(1,orderOfPoly);
cArray(:,:,maxit) = zeros(1,orderOfPoly);
error = nan(1,maxit);
tempbArray = zeros(1,orderOfPoly);
tempcArray = zeros(1,orderOfPoly);
tempbArray(1) = coefficients(1);
tempcArray(1) = coefficients(1);
itr = 1;
errorMsg = "VALID";
while (itr <= maxit)
for i=2:orderOfPoly
    tempbArray(i) =  tempbArray(i-1)*initialVal + coefficients(i);
    if (i < orderOfPoly)
    tempcArray(i) =  tempcArray(i-1)*initialVal + tempbArray(i);
    end 
end 
root = initialVal - (tempbArray(orderOfPoly) / tempcArray(orderOfPoly - 1));
bArray(:,:,itr) = tempbArray;
cArray(:,:,itr) = tempcArray;
error(itr) = (abs (root-initialVal));
         if (error(itr) < es )     
             break;
         end
initialVal = root;
itr = itr + 1;
end
errorMsg = "Birge Vieta method has diverged";
time = toc;