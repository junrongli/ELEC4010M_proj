function [ gx,gy,gz ] = readGyro(s)
%READGYRO Summary of this function goes here
%   once the arduino received 'G', it updated the gyroscope data as floating data type
fprintf(s,'G');
gx = fscanf(s,'%f');
gy = fscanf(s,'%f');
gz = fscanf(s,'%f');


end

