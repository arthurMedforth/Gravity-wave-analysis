function [daily_average_triplet] = structurePrecipDataPerDay(precip)
% Create a time average precip, a zonal mean precip --> both interpolate
% to ERA5 grid

new_lon = precip.Data.longitude(:);
for i = 1:length(precip.Data.longitude(:))
    new_lon(i)=rem((precip.Data.longitude(i)+180),360)-180;
end
precip.Data.longitude(:) = new_lon;

daily_average_data = mean(precip.Data.tp,3);

count = 1;
num_entries = size(daily_average_data,1)*size(daily_average_data,2);
daily_average_triplet = zeros(num_entries,3);
% Restructure data into lat-lon-precip triples
for lon = 1:size(daily_average_data,1)
    for lat = 1:size(daily_average_data,2)
        daily_average_triplet(count,:) = [precip.Data.latitude(lat),precip.Data.longitude(lon),daily_average_data(lon,lat)];
        count = count + 1;
    end
end


        

end

