function [ R_H ] = trial_heading(s)
%TRIAL_ANGLE Summary of this function goes here
%   Detailed explanation goes here
fprintf(s,'H');
R_H = fscanf(s,'%f');
end

