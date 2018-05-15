classdef BVoutput < matlab.mixin.SetGet
    properties
        aArray = [];  
        bArray = [];   
        cArray = [];
        error = [];
        f;       
        root;
        itr;
    end
    methods
          function obj = BVoutput(aArray, bArray, cArray, f, root, itr, error)         
            obj.aArray = aArray;
            obj.bArray = bArray;
            obj.cArray = cArray;
            obj.f = f;
            obj.root = root;
            obj.itr = itr;
            obj.error = error;
          end
    end
    
end

