function [Airs_amended,ERA5_amended] = zonalMean(Airs_organised,ERA5_organised)
Airs_amended(length(Airs_organised)) = struct();
ERA5_amended(length(ERA5_organised)) = struct();
Airs_interpolated(length(Airs_organised)) = struct();

% Retrieve list of unique lats
for i = 1:length(Airs_organised)
     Airs_interpolated(i).name = Airs_organised(i).name;
     
     interpolated_data = interpolateAirs_2_ERA5(Airs_organised(i).data,ERA5_organised(i).data(:,[1,2]));
     lat_set = unique(interpolated_data(:,1));
     
     Airs_interpolated(i).data = interpolated_data;

     Airs_amended(i).name = Airs_organised(i).name;
     Airs_amended(i).data = zeros(length(lat_set),5);

     ERA5_amended(i).name = ERA5_organised(i).date;
     ERA5_amended(i).data = zeros(length(lat_set),2);

     for lat = 1:length(lat_set)
         lat_inds = find(Airs_interpolated(i).data(:,1) == lat_set(lat));

         zonal_mean_A = nanmean(Airs_interpolated(i).data(lat_inds,3),1);
         zonal_mean_wave_mag = nanmean(Airs_interpolated(i).data(lat_inds,4),1);
         zonal_mean_wave_angle = nanmean(Airs_interpolated(i).data(lat_inds,5),1);
         zonal_mean_v_wave_mag = nanmean(Airs_interpolated(i).data(lat_inds,5),1);

         Airs_amended(i).data(lat,:) = [lat_set(lat),zonal_mean_A,zonal_mean_wave_mag,zonal_mean_wave_angle,zonal_mean_v_wave_mag];
     
         zonal_mean_mat = mean(ERA5_organised(i).data(lat_inds,3:size(ERA5_organised(i).data,2)),1);
         ERA5_amended(i).data(lat,1:size(ERA5_organised(i).data,2)-1) = [lat_set(lat),zonal_mean_mat];
     end

end

end










