function [sorted_struct] = sortStructByDate(data_struct,str)

if strcmp(str,'Airs')
    date_list =[data_struct.name];
else
    date_list =[data_struct.date];
end

    
[~,order]=sort(date_list);
sorted_struct = data_struct(order);


end

