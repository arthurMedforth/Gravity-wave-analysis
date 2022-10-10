function postProcessing(output)
addpath(genpath('Plotting')); % add plotting library and sub libraries to path

for row = 1:length(output)
    if ~isnan(output(row).data(1,7))
        max_val_wind = sqrt(output(row).data(1,7)^2 +output(row).data(1,11)^2);
        min_val_wind = sqrt(output(row).data(1,7)^2 +output(row).data(1,11)^2);
        max_val_precip = output(row).data(1,13);
        min_val_precip = output(row).data(1,13);
        max_val_u = output(row).data(1,7);
        min_val_u = output(row).data(1,7);

    else 
        continue
    end

    if ~isnan(output(row).data(14,3))
        max_val_A = output(row).data(14,3);
        min_val_A = output(row).data(14,3);
        max_val_mag = output(row).data(14,4);
        min_val_mag = output(row).data(14,4);
        max_val_angle = output(row).data(14,5);
        min_val_angle = output(row).data(14,5);
    else 
        continue
    end
end

for day = 1:length(output)
    if max(sqrt(output(row).data(:,7).^2 + output(row).data(:,11).^2)) > max_val_wind
        max_val_wind = max(sqrt(output(row).data(:,7).^2 + output(row).data(:,11).^2));
    end
    if min(sqrt(output(row).data(:,7).^2 + output(row).data(:,11).^2)) < min_val_wind
        min_val_wind = min(sqrt(output(row).data(:,7).^2 + output(row).data(:,11).^2));
    end    
    if max(output(day).data(:,13)) > max_val_precip
        max_val_precip = max(output(day).data(:,13));
    end

    if min(output(day).data(:,13)) < min_val_precip
        min_val_precip = min(output(day).data(:,13));
    end


    if max(output(day).data(:,7)) > max_val_u
        max_val_u = max(output(day).data(:,7));
    end

    if min(output(day).data(:,7)) < min_val_u
        min_val_u = min(output(day).data(:,7));
    end

%     if max(output(day).data(:,3)) > max_val_A
%         max_val_A = max(output(day).data(:,3));
%     end
% 
%     if min(output(day).data(:,3)) < min_val_A
%         min_val_A = min(output(day).data(:,3));
%     end    
    if max(output(day).data(:,3)) > max_val_A
        max_val_A = max(output(day).data(:,3));
    end

    if min(output(day).data(:,3)) < min_val_A
        min_val_A = min(output(day).data(:,3));
    end    

    if max(output(day).data(:,4)) > max_val_mag
        max_val_mag = max(output(day).data(:,4));
    end

    if min(output(day).data(:,4)) < min_val_mag
        min_val_mag = min(output(day).data(:,4));
    end    
    if max(output(day).data(:,5)) > max_val_angle
        max_val_angle = max(output(day).data(:,5));
    end

    if min(output(day).data(:,5)) < min_val_angle
        min_val_angle = min(output(day).data(:,5));
    end    
end
dat_u = output(16).data(:,7);
dat_v = output(16).data(:,11);
dat_mag = sqrt(dat_u.^2 + dat_v.^2);


max_val_wind = max(dat_mag);
min_val_wind = min(dat_mag);



lim_precip = [min_val_wind,max_val_wind];
lim_A = [min_val_A max_val_A];

day = 1;
figure(1)
hold on
while (0 < day) && (day <= length(output))
    clf
    cla
    string = num2str(day);

    
    plotter(output(day),string,lim_precip,lim_A)
    waitforbuttonpress;
    value = double(get(gcf,'CurrentCharacter'));
    if value == 29 && day < length(output)
        day = day + 1;
        continue
    elseif value == 29 && day == length(output)
        day = 1;
        continue
    elseif value == 28 && day == 1
        day = length(output);
        continue
    elseif value == 28 && day > 1
        day = day - 1;
    elseif value == 32
        day = input('Enter value');
        continue
    else
        error('not sure')
    end

end

end

