  function [interpolated_Airs] = interpolateAirs_2_ERA5(Airs,ERA5_coords)
%interpolateERA5_2_Airs Use interpolation to get same sample locations across Airs and ERA5 
% First go: truncate overlap of Airs data

%% Handle NaN values
Airs_A = Airs;

% Create interpolated surface
Airs_surface_amplitude = scatteredInterpolant(Airs_A(:,1),Airs_A(:,2),Airs_A(:,3));
Airs_surface_wave_mag = scatteredInterpolant(Airs_A(:,1),Airs_A(:,2),Airs_A(:,4));
Airs_surface_wave_angle = scatteredInterpolant(Airs_A(:,1),Airs_A(:,2),Airs_A(:,5));
Airs_surface_v_wave_angle = scatteredInterpolant(Airs_A(:,1),Airs_A(:,2),Airs_A(:,5));

interpolated_values_amplitude = Airs_surface_amplitude(ERA5_coords);
interpolated_values_wave_mag = Airs_surface_wave_mag(ERA5_coords);
interpolated_values_wave_angle = Airs_surface_wave_angle(ERA5_coords);
interpolated_values_v_wave_angle = Airs_surface_v_wave_angle(ERA5_coords);

interpolated_Airs = [ERA5_coords,interpolated_values_amplitude,interpolated_values_wave_mag,interpolated_values_wave_angle,interpolated_values_v_wave_angle];



end