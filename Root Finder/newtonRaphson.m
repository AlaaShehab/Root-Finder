function [fxi, dfxi, oldX, newX, root, itr, error, errorMsg, executionTime] = newtonRaphson (f, xi, es, maxItr)
  tic;
  errorMsg = "VALID";
  syms x
  df = diff(f,x);
  newX = zeros(1, maxItr);
  oldX = zeros(1, maxItr);
  fxi = zeros(1, maxItr);
  dfxi = zeros(1, maxItr);
  error = zeros(1, maxItr);
  itr = 1;
  root = 0.0;
  executionTime = 0.0;
  error(1) = 100.0;
  
  oldX(itr) = xi;
  
  d2f = diff(df,x);
  try
    d2fValue = feval(d2f,oldX(itr));
  catch
      d2fValue = feval(d2f);
  end
  
  dfValue = feval(df,oldX(itr));
  if (abs(d2fValue / (2 * dfValue)) > 1) 
	errorMsg = "Method will diverge";
	return;
  end
  
  while (itr <= maxItr)
    fxi(itr) = feval(f, oldX(itr));
    dfxi(itr) = df(oldX(itr));
    
    if (dfxi == 0)
      errorMsg = "Newton method failed to converge (Division by Zero)";
      break;
    end
    
        newX(itr) = oldX(itr) - (fxi(itr) / dfxi(itr));
        root = newX(itr);

        if (itr ~= 1) 
      error(itr) = abs(newX(itr) - newX(itr - 1));
    end
    if (error(itr) < es || feval(f, root) == 0)
      break;
    end
    itr = itr + 1;
    oldX(itr) = newX(itr - 1);

  end
 if(itr > maxItr)
     itr = maxItr;
 end
executionTime = toc;