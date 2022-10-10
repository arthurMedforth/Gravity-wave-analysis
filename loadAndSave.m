function [] = loadAndSave(year,month)

%% Load data
% Output structures of date-substruct form
Airs_struct = AirsLoader(year,month);
Airs_organised = structureData(Airs_struct);

ERA5_organised = ERA5Loader(year,month);

Airs_str = ['Retrieved data/Airs/',year,'/',month,'/','Airs_organised.mat'];
ERA5_str = ['Retrieved data/ERA5/',year,'/',month,'/','ERA5_organised.mat'];
% interp_precip_str = ['Retrieved data/Precip/',year,'/',month,'/','interpolated_precip.mat'];
% zonal_precip_str = ['Retrieved data/Precip/',year,'/',month,'/','zonal_precip_mean.mat'];
precip_str = ['Retrieved data/Precip/',year,'/',month,'/','precip_organised.mat'];

ERA5_coords = ERA5_organised(1).data(:,[1,2]);
SH_indices = ERA5_coords(:,1) < 0;
ERA5_coords(SH_indices,:) = [];

precip_organised = precipLoader(year,month);
% [zonal_precip_mean,interpolated_precip] = getPrecip(ERA5_coords,year,month);

save(Airs_str,"Airs_organised")
save(ERA5_str,"ERA5_organised",'-v7.3')
save(precip_str,"precip_organised",'-v7.3')

% save(interp_precip_str,"interpolated_precip",'-v7.3')
% save(zonal_precip_str,"zonal_precip_mean",'-v7.3')

end