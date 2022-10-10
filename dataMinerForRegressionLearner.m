function [GW_mf,GW_amplitude,independent_var_data] = dataMinerForRegressionLearner(Airs_interpolated_struct,ERA5_organised_struct,operation)
%DATAMINERFORREGRESSIONLEARNER 

switch operation
    case 'lumped'
        GW_amplitude = Airs_interpolated_struct(1).zonal_A_mean(:,2);
        GW_mf = Airs_interpolated_struct(1).zonal_m_mean(:,2);
        lats = ERA5_organised_struct(1).zonal_wind_137_mean(:,1);
        zonal_137_wind = ERA5_organised_struct(1).zonal_wind_137_mean(:,2);
        zonal_100_wind = ERA5_organised_struct(1).zonal_wind_100_mean(:,2);
        zonal_50_wind = ERA5_organised_struct(1).zonal_wind_50_mean(:,2);
        zonal_23_wind = ERA5_organised_struct(1).zonal_wind_23_mean(:,2);
      
        meridional_wind = ERA5_organised_struct(1).meridional_wind_mean(:,2);
        mean_temp = ERA5_organised_struct(1).temp_mean(:,2);
        mean_topo = ERA5_organised_struct(1).zonal_topo_mean(:,2);
        mean_precip = ERA5_organised_struct(1).zonal_precip_mean(:,2);

       
        for day = 2:length(Airs_interpolated_struct)
            
            GW_amplitude = [GW_amplitude;Airs_interpolated_struct(day).zonal_A_mean(:,2)];
            
            GW_mf = [GW_mf;Airs_interpolated_struct(day).zonal_m_mean(:,2)];

            lats = [lats;ERA5_organised_struct(day).zonal_wind_137_mean(:,1)];
            
            zonal_137_wind = [zonal_137_wind;ERA5_organised_struct(day).zonal_wind_137_mean(:,2)];
            zonal_100_wind = [zonal_100_wind;ERA5_organised_struct(day).zonal_wind_100_mean(:,2)];
            zonal_50_wind = [zonal_50_wind;ERA5_organised_struct(day).zonal_wind_50_mean(:,2)];
            zonal_23_wind = [zonal_23_wind;ERA5_organised_struct(day).zonal_wind_23_mean(:,2)];
            
            meridional_wind = [meridional_wind;ERA5_organised_struct(day).meridional_wind_mean(:,2)];
            
            mean_temp = [mean_temp;ERA5_organised_struct(day).temp_mean(:,2)];
            
            mean_precip = [mean_precip;ERA5_organised_struct(day).zonal_precip_mean(:,2)];
            
            mean_topo = [mean_topo;ERA5_organised_struct(day).zonal_topo_mean(:,2)];

            
        end
%         independent_var_data = [lats,zonal_wind,meridional_wind,mean_temp];

%%      19/04/22 data format
        independent_var_data = [lats,zonal_137_wind,zonal_100_wind,zonal_50_wind,zonal_23_wind,mean_temp,mean_precip,mean_topo];

    case 'lat-by-lat'

        latitude_data(length(Airs_interpolated_struct(1).zonal_A_mean(:,1))) = struct();

        for lat = 1:length(Airs_interpolated_struct(1).zonal_A_mean(:,1))

            current_latitude = Airs_interpolated_struct(1).zonal_A_mean(lat,1);
            latitude_data(lat).latitude = current_latitude;
            latitude_data(lat).amplitude = zeros(length(Airs_interpolated_struct),1);
            latitude_data(lat).zonal_wind = zeros(length(Airs_interpolated_struct),1);
            latitude_data(lat).meridional_wind = zeros(length(Airs_interpolated_struct),1);
            latitude_data(lat).mean_temp = zeros(length(Airs_interpolated_struct),1);

            for day = 1:length(Airs_interpolated_struct)

                latitude_data(lat).amplitude(day) = Airs_interpolated_struct(day).zonal_A_mean(lat,2);
                latitude_data(lat).zonal_wind(day) = ERA5_organised_struct(day).zonal_wind_mean(lat,2);
                latitude_data(lat).meridional_wind(day) = ERA5_organised_struct(day).meridional_wind_mean(lat,2);
                latitude_data(lat).mean_temp(day) = ERA5_organised_struct(day).temp_mean(lat,2);

            end

        end

        GW_amplitude = latitude_data(49).amplitude;

        zonal_wind = latitude_data(49).zonal_wind;

        meridional_wind = latitude_data(49).meridional_wind;

        mean_temp = latitude_data(49).mean_temp;

end

end
