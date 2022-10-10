% function [Airs_interpolated_struct,ERA5_organised_struct,GW_mf,GW_amplitude,independent_var_data,interpolated_precip] = MASTER()
function [output,ind_data,GW] = MASTER(year,month,region,str)
%MASTER 

%% Load data
% Output structures of date-substruct form
% Airs_struct = AirsLoader();
% ERA5_struct = ERA5Loader();
Airs_str = ['Retrieved data/Airs/',year,'/',month,'/','Airs_organised.mat'];
ERA5_str = ['Retrieved data/ERA5/',year,'/',month,'/','ERA5_organised.mat'];
precip_str = ['Retrieved data/Precip/',year,'/',month,'/','precip_organised.mat'];

load(Airs_str)
load(ERA5_str)
load(precip_str)

% precip_organised(length(precip_organised)) = [];
%% Sort each structure to make sure dates are in correct order
[ERA5_organised] = sortStructByDate(ERA5_organised,'ERA5');
[Airs_organised] = sortStructByDate(Airs_organised,'Airs');
[precip_organised] = sortStructByDate(precip_organised,'precip');

% Truncate ERA5 to get only NH by removing latitudes below 0
 for day_num = 1:length(ERA5_organised)
    % Use gridded interpolant to get precip to ERA5 grid
    [sorted_list,i] = sort(precip_organised(day_num).data(:,2));
    precip_organised(day_num).data  = precip_organised(day_num).data(i,:);
    [sorted_list,i] = sort(precip_organised(day_num).data(:,1));
    precip_organised(day_num).data  = precip_organised(day_num).data(i,:);

    griddedInterpolantSurface = getGriddedInterpolant(precip_organised(day_num).data(:,1),precip_organised(day_num).data(:,2),precip_organised(day_num).data(:,3));
    ERA5_organised(day_num).data(:,size(ERA5_organised(day_num).data,2)+1) = griddedInterpolantSurface(ERA5_organised(day_num).data(:,[1 2]));
    SH_ind_ERA5 = find(ERA5_organised(day_num).data(:,1) < 0);
    ERA5_organised(day_num).data(SH_ind_ERA5,:) = [];

end

%% Handle NaNs - pick one of the following
switch str
    case 'time average'
        % 1) Average over two day sliding window
        [Airs_interpolated,ERA5_organised] = timeAverage(Airs_organised,ERA5_organised,ERA5_organised(1).data(:,[1 2]));
        Airs_str = ['Outputs/Two day Average/Airs_interpolated-',year,'-',month,'.mat'];
        ERA5_str = ['Outputs/Two day Average/ERA5_organised-',year,'-',month,'.mat'];
        
        save(Airs_str,"Airs_interpolated")
        save(ERA5_str,"ERA5_organised")
    case 'zonal mean'
        % 2) Average all quantities longitudinally
        if strcmp(region,'North Hemisphere')
            [Airs_interpolated,ERA5_organised] = zonalMean(Airs_organised,ERA5_organised);
            Airs_str = ['Outputs/Zonal means/North hemisphere/Airs_interpolated-',year,'-',month,'.mat'];
            ERA5_str = ['Outputs/Zonal means/North hemisphere/ERA5_organised-',year,'-',month,'.mat'];

            save(Airs_str,"Airs_interpolated")
            save(ERA5_str,"ERA5_organised")
        else
            [Airs_interpolated,ERA5_organised] = zonalMeanForRegion(Airs_organised,ERA5_organised,region);
            % Set output
            Airs_str = ['Outputs/Zonal means/Regional/Airs_interpolated-',region,'-',year,'-',month,'.mat'];
            ERA5_str = ['Outputs/Zonal means/Regional/ERA5_organised-',region,'-',year,'-',month,'.mat'];

            save(Airs_str,"Airs_interpolated")
            save(ERA5_str,"ERA5_organised")
            
            [output] = regionalMeansOutput(Airs_interpolated,ERA5_organised); 
            [ind_data,GW] = miningRegionalForLearning(output,str);
            return
        end
    case 'polar latitudes'
        % 3) Only look at polar latitudes where there is good coverage
        % Apply interpolation in next step but only use the polar swathes
end


%% Retrieve specific region
output = getRegion(Airs_interpolated,ERA5_organised,region,str);
[ind_data,GW] = miningRegionalForLearning(output,str);


end

