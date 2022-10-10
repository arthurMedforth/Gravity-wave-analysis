function [ERA5_struct] = ERA5Loader(year,month)
%ERA5Loader Pass every file 

cd_path = ['Data files/ERA5 files/',year,'/',month];
cd(cd_path)

base_path = [cd_path,'/'];
dir_long = dir;
ERA5_files = dir_long(~ismember({dir_long.name},{'.','..','.DS_Store','nph_getnet.m','getDay.m','structureDataPerDay.m'}));% For each .nc file in the directory

ERA5_struct(length(ERA5_files)) = struct();
for i = 1:length(ERA5_files)
    filepath = [base_path,ERA5_files(i).name];
    ERA5 = nph_getnet(filepath);
%     ERA5_struct(length(ERA5_struct)+1) = ERA5;
    % call structureData here
    [day_string,data_triplet] = structureDataPerDay(ERA5);
    ERA5_struct(i).date = day_string;
    ERA5_struct(i).data = data_triplet;
end

% cd 'C:\Users\am3235\OneDrive - University of Bath\MATLAB working'
% cd '/Users/arthurmedforth/OneDrive - University of Bath/MATLAB working'
cd ..
cd ..
cd ..
cd ..

end

