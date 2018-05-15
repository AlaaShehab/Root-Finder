classdef output < matlab.mixin.SetGet
    properties
        fxi = [];  %function value
        dfxi = [];  %diff function value
        f;          %function
        xio = [];   %x0 or xlower or x(i-1)
        xi1 = [];   %x1 or x mid or x(i)
        xi2 = [];   %xupper or x(i+1)
        root;
        error = []; %error value
        itr;
    end
    
    methods
          function obj = output(fxi, dfxi, f, xio, xi1, xi2, root, itr, error)         
            obj.fxi = fxi;
            obj.dfxi = dfxi;
            obj.f = f;
            obj.xio = xio;
            obj.xi1 = xi1;
            obj.xi2 = xi2;
            obj.root = root;
            obj.itr = itr;
            obj.error = error;
          end
    end
    
end

