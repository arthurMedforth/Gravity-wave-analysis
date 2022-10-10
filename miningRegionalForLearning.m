function [ind_data,GW] = miningRegionalForLearning(region_data,data_included)

lats = [];
lons = [];
A = [];
wave_mag = [];
wave_angle = [];
u_137 = [];
u_100 = [];
u_50 = [];
u_23 = [];
v_137 = [];
v_100 = [];
v_50 = [];
v_23 = [];
t_137 = [];
precip = [];
switch data_included
    case 'zonal mean'
        for day = 1:length(region_data)
            lats = [lats;region_data(day).data(:,1)];

            A = [A;region_data(day).data(:,2)];
            wave_mag = [wave_mag;region_data(day).data(:,3)];
            wave_angle = [wave_angle;region_data(day).data(:,4)];
            
            u_137 = [u_137;region_data(day).data(:,6)];
            u_100 = [u_100;region_data(day).data(:,7)];
            u_50 = [u_50;region_data(day).data(:,8)];
            u_23 = [u_23;region_data(day).data(:,9)];

            v_137 = [v_137;region_data(day).data(:,10)];
            t_137 = [t_137;region_data(day).data(:,11)];
            v_100 = [v_100;region_data(day).data(:,12)];
            v_50 = [v_50;region_data(day).data(:,13)];
            v_23 = [v_23;region_data(day).data(:,14)];
            precip = [precip;region_data(day).data(:,15)];


        end
        GW = [A,wave_mag,wave_angle];
        ind_data = [lats,u_137,u_100,u_50,u_23,v_137,v_100,v_50,v_23,t_137,precip];
        
    case 'time average'
        for day =1:length(region_data)
            lats = [lats;region_data(day).data(:,1)];
            lons = [lons;region_data(day).data(:,2)];

            A = [A;region_data(day).data(:,3)];
            wave_mag = [wave_mag;region_data(day).data(:,4)];
            wave_angle = [wave_angle;region_data(day).data(:,5)];
            
            u_137 = [u_137;region_data(day).data(:,7)];
            u_100 = [u_100;region_data(day).data(:,8)];
            u_50 = [u_50;region_data(day).data(:,9)];
            u_23 = [u_23;region_data(day).data(:,10)];

            v_137 = [v_137;region_data(day).data(:,11)];
            t_137 = [t_137;region_data(day).data(:,12)];
            v_100 = [v_100;region_data(day).data(:,13)];
            v_50 = [v_50;region_data(day).data(:,14)];
            v_23 = [v_23;region_data(day).data(:,15)];
            precip = [precip;region_data(day).data(:,16)];

        end
        GW = [A,wave_mag,wave_angle];
        ind_data = [lats,lons,u_137,u_100,u_50,u_23,v_137,v_100,v_50,v_23,t_137,precip];

end