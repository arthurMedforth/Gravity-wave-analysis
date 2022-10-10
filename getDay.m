function [day_string] = getDay(time_in_hours)
%getDay Return the day of the ERA5 data sample based on input in form -
%hours since 1900-01-01 00:00:00.0

%[day_string] = getDay(1051872);


base_date_and_time = datetime('01-Jan-1900 00:00:00');

day_string = base_date_and_time + hours(time_in_hours);
day_string = datetime(day_string,'format','MM/dd/yyyy');

end