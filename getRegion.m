function [day_data] = getRegion(Airs_interpolated,ERA5_organised,region,str)
day_data = struct();
numIterations = length(Airs_interpolated);
maxLength = length(Airs_interpolated(1).data);

if (strcmp(region,'Greenland') || strcmp(region,'North America')) && strcmp(str,'zonal mean')
    error('Data retrieval method not compatible with getRegion function')
end

switch str
    case 'zonal mean'
        lat_lons = zeros(numIterations * maxLength,15);
        switch region
            case 'North Hemisphere'
                lower_lat_limit = 0;
                upper_lat_limit = 90;
                lower_lon_limit = -180;
                upper_lon_limit = 180;
        end
    case 'time average'
        lat_lons = zeros(numIterations * maxLength,16);

        switch region
            case 'Greenland'
                lower_lat_limit = 59;
                upper_lat_limit = 83;
                lower_lon_limit = -74;
                upper_lon_limit = -11;
            case 'North Hemisphere'
                lower_lat_limit = 0;
                upper_lat_limit = 90;
                lower_lon_limit = -180;
                upper_lon_limit = 180;
        
            case 'Rockies'
                lower_lat_limit = 45;
                upper_lat_limit = 52.5;
                lower_lon_limit = -122.5;
                upper_lon_limit = -107;
                
            case 'North America'
                lower_lat_limit = 10;
                upper_lat_limit = 85;
                lower_lon_limit = -170;
                upper_lon_limit = -50;

            case 'Central Plains'
                lower_lat_limit = 25;
                upper_lat_limit = 55;
                lower_lon_limit = -100;
                upper_lon_limit = -70;
            case 'Tibetan Plateau'
                lower_lat_limit = 25;
                upper_lat_limit = 40;
                lower_lon_limit = 75;
                upper_lon_limit = 105;
           case 'UK'
                lower_lat_limit = 40;
                upper_lat_limit = 60;
                lower_lon_limit = -15;
                upper_lon_limit = 10;   
            case 'Europe'
                lower_lat_limit = 44;
                upper_lat_limit = 48;
                lower_lon_limit = 5;
                upper_lon_limit = 14;  

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
end



for day = 1:length(Airs_interpolated)
    count = 1;
    for coord = 1:length(Airs_interpolated(day).data)
       switch str
            case 'time average' 
                if ((Airs_interpolated(day).data(coord,1) <= upper_lat_limit) && (Airs_interpolated(day).data(coord,1)  >= lower_lat_limit)) && ((Airs_interpolated(day).data(coord,2)  <= upper_lon_limit) && (Airs_interpolated(day).data(coord,2)  >= lower_lon_limit))
                    lat_lons(count,1) = Airs_interpolated(day).data(coord,1);
                    lat_lons(count,2) = Airs_interpolated(day).data(coord,2);
                    lat_lons(count,3) = Airs_interpolated(day).data(coord,3);
                    lat_lons(count,4) = Airs_interpolated(day).data(coord,4);
                    lat_lons(count,5) = Airs_interpolated(day).data(coord,5);
                    lat_lons(count,6) = Airs_interpolated(day).data(coord,6);

                    lat_lons(count,7) = ERA5_organised(day).data(coord,3);
                    lat_lons(count,8) = ERA5_organised(day).data(coord,4);
                    lat_lons(count,9) = ERA5_organised(day).data(coord,5);
                    lat_lons(count,10) = ERA5_organised(day).data(coord,6);
                    lat_lons(count,11) = ERA5_organised(day).data(coord,7);
                    lat_lons(count,12) = ERA5_organised(day).data(coord,8);
                    lat_lons(count,13) = ERA5_organised(day).data(coord,9);
                    lat_lons(count,14) = ERA5_organised(day).data(coord,10);
                    lat_lons(count,15) = ERA5_organised(day).data(coord,11);
                    lat_lons(count,16) = ERA5_organised(day).data(coord,12);

                    count = count + 1;
                end
            case 'zonal mean'
                if ((Airs_interpolated(day).data(coord,1) <= upper_lat_limit) && (Airs_interpolated(day).data(coord,1)  >= lower_lat_limit)) 
                    lat_lons(count,1) = Airs_interpolated(day).data(coord,1);
                    lat_lons(count,2) = Airs_interpolated(day).data(coord,2);
                    lat_lons(count,3) = Airs_interpolated(day).data(coord,3);
                    lat_lons(count,4) = Airs_interpolated(day).data(coord,4);
                    lat_lons(count,5) = Airs_interpolated(day).data(coord,5);

                    lat_lons(count,6) = ERA5_organised(day).data(coord,2);
                    lat_lons(count,7) = ERA5_organised(day).data(coord,3);
                    lat_lons(count,8) = ERA5_organised(day).data(coord,4);
                    lat_lons(count,9) = ERA5_organised(day).data(coord,5);
                    lat_lons(count,10) = ERA5_organised(day).data(coord,6);
                    lat_lons(count,11) = ERA5_organised(day).data(coord,7);
                    lat_lons(count,12) = ERA5_organised(day).data(coord,8);
                    lat_lons(count,13) = ERA5_organised(day).data(coord,9);
                    lat_lons(count,14) = ERA5_organised(day).data(coord,10);
                    lat_lons(count,15) = ERA5_organised(day).data(coord,11);

                    count = count + 1;
                end
            
       end
    end
    lat_lons(count:length(lat_lons),:) = [];
    day_data(day).num = day;
    day_data(day).data = lat_lons;
end

end
