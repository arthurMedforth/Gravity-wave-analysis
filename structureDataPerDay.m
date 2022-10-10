function [day_string,data_triplet] = structureDataPerDay(Data_struct)
%structureAirs Restructure data as [lat - lon - data] in data_struct output

for ERA5_entry = 1:length(Data_struct)

    entries = length(Data_struct.Data.latitude) * length(Data_struct.Data.longitude);% Get size of output vector

    data_triplet = zeros(entries,8); % Initialise vector

    count = 1; % Initialise counter to load output vector


    for lon = 1:length(Data_struct.Data.longitude)

        for lat = 1:length(Data_struct.Data.latitude)
            data_triplet(count,1) = Data_struct.Data.latitude(lat);
            data_triplet(count,2) = Data_struct.Data.longitude(lon);

            % Get ERA5 data from 36km altitude
            % Corwin confirmed that taking lowest pressure
            % level is allowed
            data_triplet(count,3) = sum(Data_struct.Data.u(lon,lat,137,:))/8; % Get zonal wind
            data_triplet(count,4) = sum(Data_struct.Data.u(lon,lat,100,:))/8; % Get zonal wind
            data_triplet(count,5) = sum(Data_struct.Data.u(lon,lat,50,:))/8; % Get zonal wind
            data_triplet(count,6) = sum(Data_struct.Data.u(lon,lat,23,:))/8; % Get zonal wind

            data_triplet(count,7) = sum(Data_struct.Data.v(lon,lat,137,:))/8; % Meridional wind
            data_triplet(count,8) = sum(Data_struct.Data.t(lon,lat,137,:))/8; % Temperature

            count = count + 1; % Increment counter
        end
    end
    % Compute day before adding to output structure
    day_string = getDay(Data_struct.Data.time(1));
end

end