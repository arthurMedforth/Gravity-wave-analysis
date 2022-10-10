function [precip_struct] = precipLoader(year,month)
%ERA5Loader Pass every file 

cd_path = ['Data files/Precip files/',year,'/',month];
cd(cd_path)

base_path = [cd_path,'/'];
dir_long = dir;
precip_files = dir_long(~ismember({dir_long.name},{'.','..','.DS_Store','nph_getnet.m','getDay.m','structurePrecipDataPerDay.m'}));% For each .nc file in the directory
precip_struct(length(precip_files)) = struct();
for i = 1:length(precip_files)
    filepath = [base_path,precip_files(i).name];
    precip = nph_getnet(filepath);

    day_string = getDay(precip.Data.time(1));
    data_triplet = structurePrecipDataPerDay(precip);
    
    precip_struct(i).date = day_string;
    precip_struct(i).data = data_triplet;
end

% cd 'C:\Users\am3235\OneDrive - University of Bath\MATLAB working'
% cd '/Users/arthurmedforth/OneDrive - University of Bath/MATLAB working'
cd ..
cd ..
cd ..
cd ..

end

