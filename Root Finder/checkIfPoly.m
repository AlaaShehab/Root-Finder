function isPoly = checkIfPoly(f)
isPoly = true;
equations = ["sin", "cos", "tan", "e", "log", "ln"];
length = size(equations,2);
for i = 1: length
    if (contains(f,equations(i)))
        isPoly = false;
        return;
    end
end
