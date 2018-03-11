function [ V_X,V_Y,V_Z ] = trial_velocity(s)
%TRIAL_ANGLE Summary of this function goes here
%   Detailed explanation goes here
fprintf(s,'A');
tic;
nvx = fscanf(s,'%f');
nvy = fscanf(s,'%f');
nvz = fscanf(s,'%f');
current = toc;
V_X = nvx * current ;
V_Y = nvy * current ;
V_Z = nvz * current ;

end

