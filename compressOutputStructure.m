function [output] = compressOutputStructure(output)

indices = [];
for coord = 1:length(output(1).data)
    if mod(coord,2) == 0
        indices(length(indices)+1) = coord;
    end
end

for day = 1:length(output)
    output(day).data(indices,:) = [];
end


end