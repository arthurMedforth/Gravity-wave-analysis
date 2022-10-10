function [Airs_struct] = AirsLoader(year,month)
%inputLoader Iterate through available Airs and ERA5 data to produce 1xm
%structs for the data

% OUT: 
% Airs - structure containing all Airs data

% cd 'Data files\Airs files\Trial two months'
path = ['Data files/Airs files/',year,'/',month];
cd(path)

dir_long = dir;
Airs_files = dir_long(~ismember({dir_long.name},{'.','..'}));% For each .mat file in the directory
load(Airs_files(1).name);
Airs_struct = Airs;
for i = 2:length(Airs_files)
    load(Airs_files(i).name);
    Airs_struct(length(Airs_struct)+1) = Airs;
end

cd ..
cd ..
cd ..
cd ..
end
