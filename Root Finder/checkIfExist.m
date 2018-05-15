function rootExists = checkIfExist (roots, root, es)
rootExists = false;
length = size(roots,2);
for i = 1: length
    %disp(roots(i));
    %disp(root);
    if (abs(root - roots(i)) < es)
        rootExists = true;
        return;
    end 
end 