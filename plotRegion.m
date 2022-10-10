function [] = plotRegion(region_data,plot,region)
addpath(genpath('plotting')); % add plotting library and sub libraries to path

lats = unique(region_data(:,1));
lons = unique(region_data(:,2).');

latitudes = unique(region_data(:,1));
longitudes = unique(region_data(:,2).');

latitudes = repmat(latitudes,1,length(latitudes));
longitudes = repmat(longitudes,length(longitudes),1);

GW_A = reshape(region_data(:,3),[length(lats),length(lons)]);
GW_mf = reshape(region_data(:,4),[length(lats),length(lons)]);

u_137 = reshape(region_data(:,6),[length(lats),length(lons)]);
u_100 = reshape(region_data(:,7),[length(lats),length(lons)]);
u_50 = reshape(region_data(:,8),[length(lats),length(lons)]);
u_23 = reshape(region_data(:,9),[length(lats),length(lons)]);
v = reshape(region_data(:,10),[length(lats),length(lons)]);
t = reshape(region_data(:,11),[length(lats),length(lons)]);
precip = reshape(region_data(:,12),[length(lats),length(lons)]);

switch plot
    case 'u_137'
        plotting1(lats,lons,u_137,region)

    case 'u_100'
        plotting1(lats,lons,u_100,region)

    case 'u_50'
        plotting1(lats,lons,u_50,region)

    case 'u_23'
        plotting1(lats,lons,u_23,region)

    case 'v'
        plotting1(lats,lons,v,region)

    case 't'
        plotting1(lats,lons,t,region)

    case 'topo'
        plotting1(lats,lons,topo,region)

    case 'precip'
        plotting1(lats,lons,precip,region)

    case 'GW_A'
        plotting1(lats,lons,GW_A,region)

    case 'GW_mf'
        plotting1(lats,lons,GW_mf,region)

end

end
