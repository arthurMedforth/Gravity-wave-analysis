function [Airs_interpolated,ERA5_amended] = timeAverage(Airs_organised,ERA5_organised,ERA5_coords)
Airs_interpolated(length(Airs_organised)-1) = struct();
ERA5_amended(length(ERA5_organised)-1) = struct();

count = 1;
for e = 1:length(Airs_organised)
    multi_dim_array_for_nanmean = zeros(size(Airs_organised(1).data,1),size(Airs_organised(1).data,2),2);
   if e+1 > length(Airs_organised)
       break
   end
   multi_dim_array_for_nanmean(:,:,1) = Airs_organised(e).data;
   multi_dim_array_for_nanmean(:,:,2) = Airs_organised(e+1).data;
    
   new_mat = mean(multi_dim_array_for_nanmean(:,:,:),3,'omitnan');

   Airs_interpolated(count).data = interpolateAirs_2_ERA5(new_mat,ERA5_coords);
   count = count + 1;
   
end

count = 1;
for f = 1:length(ERA5_organised)
   multi_dim_array_for_nanmean = zeros(size(ERA5_organised(1).data,1),size(ERA5_organised(1).data,2),2);
   if f+1 > length(ERA5_organised)
       break
   end
   multi_dim_array_for_nanmean(:,:,1) = ERA5_organised(f).data;
   multi_dim_array_for_nanmean(:,:,2) = ERA5_organised(f+1).data;
    
   new_mat = mean(multi_dim_array_for_nanmean(:,:,:),3);

   ERA5_amended(count).data = new_mat;
   count = count + 1;
end

end

