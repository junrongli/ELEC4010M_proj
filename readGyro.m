function [ gx,gy,gz ] = readGyro(s)
%READGYRO Summary of this function goes here
%   Detailed explanation goes here
fprintf(s,'G');
gx = fscanf(s,'%f');
gy = fscanf(s,'%f');
gz = fscanf(s,'%f');


end

