function [day_data] = regionalMeansOutput(Airs_interpolated,ERA5_organised)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
day_data = struct();
numIterations = length(Airs_interpolated);
maxLength = length(Airs_interpolated(1).data);

for day = 1:length(Airs_interpolated)
    lat_lons = zeros(numIterations * maxLength,12);
    count = 1;
    for coord = 1:length(Airs_interpolated(day).data)
        lat_lons(count,1) = Airs_interpolated(day).data(coord,1);
        lat_lons(count,2) = Airs_interpolated(day).data(coord,2);
        lat_lons(count,3) = Airs_interpolated(day).data(coord,3);
        lat_lons(count,4) = Airs_interpolated(day).data(coord,4);

        lat_lons(count,6) = ERA5_organised(day).data(coord,2);
        lat_lons(count,7) = ERA5_organised(day).data(coord,3);
        lat_lons(count,8) = ERA5_organised(day).data(coord,4);
        lat_lons(count,9) = ERA5_organised(day).data(coord,5);
        lat_lons(count,10) = ERA5_organised(day).data(coord,6);
        lat_lons(count,11) = ERA5_organised(day).data(coord,7);
        lat_lons(count,12) = ERA5_organised(day).data(coord,8);

        count = count + 1;
    end
    lat_lons(count:length(lat_lons),:) = [];
    day_data(day).num = day;
    day_data(day).data = lat_lons;
end

end

