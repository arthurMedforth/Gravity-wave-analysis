function [] =plotAngles(wind_angles,prop_angles)


edges = [-180 -90 0 90 180];
[N1,edges] = histcounts(wind_angles,edges);
[N2,edges] = histcounts(prop_angles,edges);
N = [N1(1),N2(1);N1(2),N2(2);N1(3),N2(3);N1(4),N2(4)];

x = 1:4;
bar(x,N)

end