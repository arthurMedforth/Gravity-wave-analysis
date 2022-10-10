function [] = dynamicPLot(data_struct,region)

day = 1;

figure(1)

hold on
while (0 < day) && (day <= length(data_struct))
    clf
    cla
    string = num2str(day);
    
    subplot(2,2,1)
    plotRegion(data_struct(day).data,'GW_A',region);
    xlabel('Amplitude');

    subplot(2,2,2)
    plotRegion(data_struct(day).data,'u_137',region);
    xlabel('u 137');

    subplot(2,2,3)
    plotRegion(data_struct(day).data,'t',region);
    xlabel('t');

    subplot(2,2,4)
    plotRegion(data_struct(day).data,'precip',region);
    xlabel('precip');
    sgtitle(string) 

    waitforbuttonpress;
    value = double(get(gcf,'CurrentCharacter'));
    if value == 29 && day < length(data_struct)
        day = day + 1;
        continue
    elseif value == 29 && day == length(data_struct)
        day = 1;
        continue
    elseif value == 28 && day == 1
        day = length(data_struct);
        continue
    elseif value == 28 && day > 1
        day = day - 1;
    elseif value == 32
        day = input('Enter val');
        continue
    else
        error('not sure')
    end
        
end

end