function [comb_data] = combineDayNight(Data_struct,str)

% Combine day and night
switch str
    case 'A'
        day_data = Data_struct.NH.Day.A;
        night_data = Data_struct.NH.Night.A;
    case 'k'
        day_data = Data_struct.NH.Day.k;
        night_data = Data_struct.NH.Night.k;    
    case 'l'
        day_data = Data_struct.NH.Day.l;
        night_data = Data_struct.NH.Night.l;    
end

comb_data = day_data;

day_bool = isnan(day_data);
comb_data(day_bool) = night_data(day_bool);
end

