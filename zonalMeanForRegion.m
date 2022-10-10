function [Airs_amended,ERA5_amended] = zonalMeanForRegion(Airs_organised,ERA5_organised,region)
Airs_amended(length(Airs_organised)) = struct();
ERA5_amended(length(ERA5_organised)) = struct();
Airs_interpolated(length(Airs_organised)) = struct();

switch region
    case 'North America'
        lower_lat_limit = 45;
        upper_lat_limit = 52.5;
        lower_lon_limit = -122.5;
        upper_lon_limit = -107;
    case 'Greenland'
        lower_lat_limit = 59;
        upper_lat_limit = 83;
        lower_lon_limit = -74;
        upper_lon_limit = -11;
   case 'Tibetan Plateau'
        lower_lat_limit = 25;
        upper_lat_limit = 40;
        lower_lon_limit = 75;
        upper_lon_limit = 105;   
   case 'UK'
        lower_lat_limit = 40;
        upper_lat_limit = 60;
        lower_lon_limit = 10;
        upper_lon_limit = -15;  
   case 'Europe'
        lower_lat_limit = 44;
        upper_lat_limit = 48;
        lower_lon_limit = 5;
        upper_lon_limit = 14;  

    case 'Central Plains'
        lower_lat_limit = 25;
        upper_lat_limit = 55;
        lower_lon_limit = -100;
        upper_lon_limit = -70;
   case 'India'
        lower_lat_limit = 5;
        upper_lat_limit = 30;
        lower_lon_limit = 70;
        upper_lon_limit = 110;  
    case 'FI'
        lower_lat_limit = 50;
        upper_lat_limit = 75;
        lower_lon_limit = 70;
        upper_lon_limit = 110;  
end

% Retrieve list of unique lats
for i = 1:length(Airs_organised)
     Airs_interpolated(i).name = Airs_organised(i).name;
     
     interpolated_data = interpolateAirs_2_ERA5(Airs_organised(i).data,ERA5_organised(i).data(:,[1,2]));
     lat_set = unique(interpolated_data(:,1));
     % Remove latitudes out of regional area
     lat_set = lat_set(lat_set > lower_lat_limit);
     lat_set = lat_set(lat_set < upper_lat_limit);

     Airs_interpolated(i).data = interpolated_data;

     Airs_amended(i).name = Airs_organised(i).name;
     Airs_amended(i).data = zeros(length(lat_set),5);

     ERA5_amended(i).name = ERA5_organised(i).date;
     ERA5_amended(i).data = zeros(length(lat_set),2);

     for lat = 1:length(lat_set)
         lat_inds = find(interpolated_data(:,1) == lat_set(lat));
         
         % Remove lat occurrences that have corresponding longs out of
         % regional area
         longs = Airs_interpolated(i).data(:,2);
         relevant_longs = longs(lat_inds);
         
         lat_inds = lat_inds(relevant_longs > lower_lon_limit);
         relevant_longs = longs(lat_inds);
         lat_inds = lat_inds(relevant_longs < upper_lon_limit);

         zonal_mean_A = nanmean(interpolated_data(lat_inds,3),1);
         zonal_mean_wave_mag = nanmean(interpolated_data(lat_inds,4),1);
         zonal_mean_wave_angle = nanmean(interpolated_data(lat_inds,5),1);
         zonal_mean_v_wave_angle = nanmean(interpolated_data(lat_inds,6),1);

         Airs_amended(i).data(lat,:) = [lat_set(lat),zonal_mean_A,zonal_mean_wave_mag,zonal_mean_wave_angle,zonal_mean_v_wave_angle];
     
         zonal_mean_mat = mean(ERA5_organised(i).data(lat_inds,3:size(ERA5_organised(i).data,2)),1);
         ERA5_amended(i).data(lat,1:size(ERA5_organised(i).data,2)-1) = [lat_set(lat),zonal_mean_mat];
     end

end

end










