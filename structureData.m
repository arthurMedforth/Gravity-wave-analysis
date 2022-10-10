function [data_struct] = structureData(Data_struct)
%structureAirs Restructure data as [lat - lon - data] in data_struct output

% Initialise the output structure
data_struct(length(Data_struct)) = struct();

% Loop Airs structure
for Airs_entry = 1:length(Data_struct)

    % Get lat and lons (consider removing as computationally heavy)
    [Data_struct(Airs_entry).X,Data_struct(Airs_entry).Y] = ndgrid(Data_struct(Airs_entry).x,Data_struct(Airs_entry).y); [Data_struct(Airs_entry).NH.Lat,Data_struct(Airs_entry).NH.Lon] = reckon( 89.999,0,km2deg(quadadd(Data_struct(Airs_entry).X,Data_struct(Airs_entry).Y)),atan2d(Data_struct(Airs_entry).X,Data_struct(Airs_entry).Y)); [Data_struct(Airs_entry).SH.Lat,Data_struct(Airs_entry).SH.Lon] = reckon(-89.999,0,km2deg(quadadd(Data_struct(Airs_entry).X,Data_struct(Airs_entry).Y)),atan2d(Data_struct(Airs_entry).X,Data_struct(Airs_entry).Y)); 

%             data_triplet = zeros(entries,4); % Initialise vector
    data_triplet =[];
    altitude_level = 2; % Choose altitude level from Airs (currently on 36km)

%     comb_data_A = combineDayDay(Data_struct(Airs_entry),'A');
%     comb_data_k = combineDayDay(Data_struct(Airs_entry),'k');
%     comb_data_l = combineDayDay(Data_struct(Airs_entry),'l');

%     Data_struct(Airs_entry).NH.Day.A = comb_data_A;
%     Data_struct(Airs_entry).NH.Day.k = comb_data_k;
%     Data_struct(Airs_entry).NH.Day.l = comb_data_l;

    Data_struct(Airs_entry).NH.Day.w_vector_mag =  sqrt(Data_struct(Airs_entry).NH.Day.k.^2+Data_struct(Airs_entry).NH.Day.l.^2);
    Data_struct(Airs_entry).NH.Day.w_vector_angle = atan2(Data_struct(Airs_entry).NH.Day.l,Data_struct(Airs_entry).NH.Day.k);

    count = 1; % Initialise counter to load output vector
    for i = 1:length(Data_struct(Airs_entry).x) 

        for j = 1:length(Data_struct(Airs_entry).y)
            % Append into list lat,lon,data
            if Data_struct(Airs_entry).NH.Lat(i,j) < 0
                continue
            end
            data_triplet(size(data_triplet,1)+1,:) = zeros(1,6);
            data_triplet(size(data_triplet,1),1) = Data_struct(Airs_entry).NH.Lat(i,j);
            data_triplet(size(data_triplet,1),2) = Data_struct(Airs_entry).NH.Lon(i,j); 

            % Average day and Day where they are both present
            % and use 
            data_triplet(size(data_triplet,1),3) = Data_struct(Airs_entry).NH.Day.A(i,j,altitude_level); % amplitude

            data_triplet(size(data_triplet,1),4) = Data_struct(Airs_entry).NH.Day.w_vector_mag(i,j,altitude_level);
            data_triplet(size(data_triplet,1),5) = Data_struct(Airs_entry).NH.Day.w_vector_angle(i,j,altitude_level);
            % AM just added
            data_triplet(size(data_triplet,1),6) = Data_struct(Airs_entry).NH.Day.m(i,j,altitude_level);

            count = count + 1; % Increment counter
        end
    end
% Place date and data into output structure for this day of the
% Airs struct
data_struct(Airs_entry).name = datetime(Data_struct(Airs_entry).Date,'format','MM/dd/yyyy');
data_struct(Airs_entry).data = data_triplet;
end
end

