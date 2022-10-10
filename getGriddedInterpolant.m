function griddedInterpolantSurface = getGriddedInterpolant(lat,lon,data)
vec = [-180:0.25:-0.25,0:0.25:179.75];

[X,Y] = ndgrid(unique(lat),vec);
D = zeros(size(X));
count = 1;
for i = 1:size(X,1)
    for j = 1:size(X,2)
        D(i,j) = data(count);
        count = count + 1;
    end
end

% for i = 1:size(D,1)
%     for j = 1:size(D,2)
%         Y(i,j)=rem((Y(i,j)+180),360)-180;
%     end    
% end


griddedInterpolantSurface = griddedInterpolant(X,Y,D);

end