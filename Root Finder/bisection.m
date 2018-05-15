function [root, xls, xus, xrs, itr, error, errorMsg, time] = bisection(f,xl, xu, es, imax)
tic;
errorMsg = "VALID";
ea = 100000;
itr = 0;
time = 0;
xls = nan(1,imax);
xus = nan(1,imax);
xrs = nan(1,imax);
error = nan(1,imax);
if  feval(f,xl) * feval(f, xu)>0 % if guesses do not bracket, exit
    root = NaN;
    errorMsg = "the function of the two points have the same sign";
    return
end
for i=1:1:imax
    xls(i) = xl;
    xus(i) = xu;
    xr = (xu+xl)/2;
    xrs(i)= xr;% compute the midpoint xr
    if (i > 1)
        ea = abs((xrs(i)-xrs(i - 1))); % approx. relative error
        error(i)= ea;
    end
    test = feval(f,xl) * feval(f, xr); % compute f(xl)*f(xr)
    if (test < 0)
        xu = xr;
    else
       xl = xr;
    end
    if (test == 0)
       ea=0;
    end
    if (ea < es) 
       break;
    end
    itr = i;
end
root = xr;
time = toc;