
loadAndSave('2019','March');
loadAndSave('2019','April');
loadAndSave('2019','May');
loadAndSave('2019','June');



% % Scaffolding function 
% list_A = [];
% for entry = 1:length(A_May_truncated)
%     if mod(entry,2) == 0
%         continue
%     else
%         list_A(length(list_A)+1,:) = A_May_truncated(entry,:);
%     end
% end
% 
% entry = 1;
% list_ind = [];
% for entry = 1:length(ind_data_May_truncated)
%     if mod(entry,2) == 0
%         continue
%     else
%         list_ind(size(list_ind,1)+1,:) = ind_data_May_truncated(entry,:);
%     end
% end
% 

% outputMarchZonalNH = compressOutputStructure(outputMarchZonalNH);
% outputAprilZonalNH = compressOutputStructure(outputAprilZonalNH);
% outputMayZonalNH = compressOutputStructure(outputMayZonalNH);
% outputJuneZonalNH = compressOutputStructure(outputJuneZonalNH);

% [ind_data_March,GW_March] = miningRegionalForLearning(outputMarchZonalNH,'zonal mean');
% [ind_data_April,GW_April] = miningRegionalForLearning(outputAprilZonalNH,'zonal mean');
% [ind_data_May,GW_May] = miningRegionalForLearning(outputMayZonalNH,'zonal mean');
% [ind_data_June,GW_June] = miningRegionalForLearning(outputJuneZonalNH,'zonal mean');

% GW_Spring = [GW_March;GW_April;GW_May;GW_June];
% ind_data_Spring = [ind_data_March;ind_data_April;ind_data_May;ind_data_June];
% 
% 
% lats = unique(ind_data_May(:,1));
% averaged = [];
% for lat = 1:length(lats)
%     inds = find(ind_data_March(:,1) == lats(lat));
%     averaged = [averaged;mean(ind_data_March(inds,2:size(ind_data_March,2)),1)];
% end
% ind_data_March = [lats,averaged];
% 
% averaged = [];
% for lat = 1:length(lats)
%     inds = find(ind_data_April(:,1) == lats(lat));
%     averaged = [averaged;mean(ind_data_April(inds,2:size(ind_data_April,2)),1)];
% end
% ind_data_April = [lats,averaged];
% 
% averaged = [];
% for lat = 1:length(lats)
%     inds = find(ind_data_June(:,1) == lats(lat));
%     averaged = [averaged;mean(ind_data_June(inds,2:size(ind_data_June,2)),1)];
% end
% ind_data_June = [lats,averaged];averaged = [];
% 
% for lat = 1:length(lats)
%     inds = find(ind_data_May(:,1) == lats(lat));
%     averaged = [averaged;mean(ind_data_May(inds,2:size(ind_data_May,2)),1)];
% end
% ind_data_May = [lats,averaged];
% 
% A = GW_Spring(:,1);
%     


% [sorted_list,i] = sort(all_data(:,2));
% all_data  = all_data(i,:);
% 
% 
% [sorted_list,i] = sort(all_data(:,1));
% all_data  = all_data(i,:);
% 

% data = Airs_organised(1).data;
% unique_list = unique(data,'rows');
% for l = 1:length(unique_list)
%     for i =1:length(data)
%         if data(i,:) == unique_list(l)
%             disp(data(i,:))
%         
%             
%             
%         end
%     end
% end
% 
% count = 0;
% for i = 1:161
%     for j = 1:161
%         if Data_struct(1).NH.Lat(i,j) > 0 
%             
%            count = count + 1; 
%         end
%     end
% end
% 
% disp(count)

%% Check all NaNs are gone
% for row = 1:length(output)
%     bool = isnan(output(row).data(:,2));
%     if sum(bool) > 0
%         disp(row)
%     end
% end
% max_num = max(ind_data(:,6));
% for row = 1:length(output)
% %     disp(length(output(row).data(:,13))*row);
%     if max(output(row).data(:,13)) == max_num
%         disp(row)
%     end
% end
% lower_lat_limit = 45;
% upper_lat_limit = 52.5;
% lower_lon_limit = -122.5;
% upper_lon_limit = -107;
% 
% struct_Rockies_from_NH(length(output)) = struct();
% for row = 1:length(output)
%     count = 1;
%     for coord = 1:length(output(row).data)
%         if ((output(row).data(coord,1) <= upper_lat_limit) && (output(row).data(coord,1)  >= lower_lat_limit)) && ((output(row).data(coord,2)  <= upper_lon_limit) && (output(row).data(coord,2)  >= lower_lon_limit))
%             struct_Rockies_from_NH(row).data(count,:) = output(row).data(coord,:);
%             count = count + 1;
%         end
%     end
% end
% day = 1;
% 
% figure(1)
% 
% hold on
% 
% while (0 < day) && (day <= length(output))
%     clf
%     cla
%     string = num2str(day);
% 
%     postProcessing(output(day),string)
%     waitforbuttonpress;
%     value = double(get(gcf,'CurrentCharacter'));
%     if value == 29 && day < length(output)
%         day = day + 1;
%         continue
%     elseif value == 29 && day == length(output)
%         day = 1;
%         continue
%     elseif value == 28 && day == 1
%         day = length(output);
%         continue
%     elseif value == 28 && day > 1
%         day = day - 1;
%     elseif value == 32
%         day = input('Enter value');
%         continue
%     else
%         error('not sure')
%     end
% 
% end
% max_val = 0;
% min_val = 0;
% for day = 1:length(output)
%     for coord = 1:length(output(day).data)
%         if max(output(day).data(:,7)) > max_val
%             max_val = max(output(day).data(:,7));
%         end
% 
%         if min(output(day).data(:,7)) < min_val
%             min_val = min(output(day).data(:,7));
%         end    
%     end
% end