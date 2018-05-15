function[g,arrX,arrGofX,root,i,arrError,errorMsg,executionTime] = fixedPoint(f, xi, ess, maxI)
    tic;
    errorMsg = "VALID";
    root = NaN;
    executionTime = 0;
    arrX = zeros(1, maxI);
    arrGofX = zeros(1, maxI);
    arrError = zeros(1, maxI);
%     syms ftemp(x);
%     ftemp(x) = f;
    syms x;
    g = f + x;
    g_dash = diff(g,x);
    i = 1;
    if (abs(feval(g_dash,xi)) > 1)
        disp("can't converge")
        errorMsg = "Fixed Point method failed to converge because |g'(x)| > 1";
        return;
    end  
    %first iteraion
    err = 100;
    arrX(i) = xi;
    arrGofX(i) = g(xi);
    arrError(i) = NaN;
    xi = arrGofX(i);
    i = i+1;
    while (i <= maxI) 
		xi = g(xi);
  		arrX(i) = arrGofX(i-1);
    		arrGofX(i) = xi;
       	err = abs(arrGofX(i) - arrX(i));
   		arrError(i) = err;
        if(err < ess)
            break;
        end
		i= i+1;
    end
    if(i > maxI)
        i = maxI;
    end
	root = arrX(i);
	executionTime = toc;
