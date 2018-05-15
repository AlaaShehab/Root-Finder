function [root, xls, xus, xrs, error, errorMsg, time, itr] = false_position(f, xl, xu, es, maxit)
tic;
time = 0;
xls = nan(1,maxit);
xus = nan(1,maxit);
xrs = nan(1,maxit);
fxl = nan(1,maxit);
fxu = nan(1,maxit);
    fxr = nan(1,maxit);
error = nan(1,maxit);
xls(1) = xl;
xus(1) = xu;
fxl(1) = feval (f, xls(1));
fxu(1) = feval (f, xus(1));
errorMsg = "VALID";
root = NaN;

if fxl(1) * fxu(1) > 0.0 
    errorMsg = "The function of the two points have the same sign";
end
itr = 1;
for i = 1:maxit
    xrs(i) = xus(i) - fxu(i)*(xus(i) - xls(i)) / (fxu(i) - fxl(i));
    fxr(i) = feval (f, xrs(i));
    root = xrs(i);
    if fxr(i) == 0
        break;
    elseif fxr(i) * fxl(i) > 0
        xus(i+1) = xus(i);
        fxu(i+1) = fxu(i);
        xls(i+1) = xrs(i);
        fxl(i+1) = fxr(i);
    else 
        xls(i+1) = xls(i);
        fxl(i+1) = fxl(i);
        xus(i+1) = xrs(i);
        fxu(i+1) = fxr(i);
    end
         if ( i > 1 )
             error(i) = abs (xrs(i)-xrs(i-1)); 
             if (error(i) < es)
                break;
             end 
         end
         itr = i;
end
time = toc;
if itr > maxit 
    errorMsg = "zero not found to desired tolerance";
end 