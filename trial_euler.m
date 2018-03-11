function [ roll, pitch ] = trial_euler( s )
%TRIAL_EULER Summary of this function goes here
%   Detailed explanation goes here
fprintf(s,'R');
roll = fscanf(s,'%f');
pitch= fscanf(s,'%f');

end

