function [root, err, xs0,xs1, xsn, it, time, errorM] = secant(f, xi_1, xi, ess, maxI)
    tic;
    f = char(f);
    errorM = "VALID";
    root = NaN;
    time = 0;
    xs0 = zeros(1, (maxI+1));
    xs1 = zeros(1, (maxI+1));
    xsn = zeros(1, (maxI+1));   
    fxi = zeros (1, maxI+1);
    fxi_1 = zeros (1, maxI+1);  
    err = zeros(1, maxI+1);
    xs0(1) = xi_1;
    xs1(1) = xi;   
    it = 1;
    syms x;
    breakError = false;
    try
    fxi_1(it) = subs(f,x, xs0(it));
    fxi(it) = subs(f,x, xs1(it));
    catch
        errorM = "Invalid equation";
        return;
    end
try
    while(it <= maxI)    
           if(fxi_1(it) - fxi(it) == 0)
                errorM = "division by zero";
                return;
           end
         xsn(it) = xs1(it) - (fxi(it) * (xs0(it) - xs1(it))) / (fxi_1(it) - fxi(it)); 
     
         err(it) = abs(xsn(it) - xs1(it));
          if(err(it) < abs(ess)) 
              breakError = true;
             break;
          end    
         if(subs(f,x,xsn(it)) == 0)
             break;
         end  
         it = it+1;        
         fxi_1(it) = fxi(it-1);
         xs0(it) = xs1(it-1);
         xs1(it) = xsn(it-1);         
         try
         fxi(it) = subs(f,x,xs1(it));
         catch
             errorM = "Invalid equation";
             return;
         end
        
    end
catch
    errorM = "Un-identified error";
    return;
end  

     time = toc;
     if(it > maxI)
         it = maxI;
     end
    if(breakError) 
        root = xsn(it);
    else
        root = xs1(it);
    end
end