function [angles_Wind_137,angles_Wind_100,angles_Wind_50,angles_Wind_23,angle_prop] = getAngles(ind_data,GW)
angles_Wind_137 = atan2d(ind_data(:,7),ind_data(:,3));
angles_Wind_100 = atan2d(ind_data(:,8),ind_data(:,4));
angles_Wind_50 = atan2d(ind_data(:,9),ind_data(:,5));
angles_Wind_23 = atan2d(ind_data(:,10),ind_data(:,6));
angle_prop = rad2deg(GW(:,3));

end