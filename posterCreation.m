function [] = posterCreation()

load topo60c
latlim = [58 90];
lonlim = [-75 -12];
[Z,R] = geocrop(topo60c,topo60cR,latlim,lonlim);

figure
axesm('lambertstd','MapLatLimit',latlim,'MapLonLimit',lonlim)
tightmap
axis off
contour3m(Z,R,'k','LevelStep',50)
colorbar

geoshow(Z,R,'DisplayType','surface')
demcmap(Z)
title({'Topography and Bathymetry', ...
   'with 500 m Contours'});


set(gca,'DataAspectRatio',[1 1 50000])
view(3)
end