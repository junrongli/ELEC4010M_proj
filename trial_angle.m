function [ reangleX,reangleY,reangleZ ] = trial_angle(anglex,angley,anglez ,s)
%TRIAL_ANGLE Summary of this function goes here
%   Detailed explanation goes here
fprintf(s,'G');
%originally, all is zero degree
newAngleX = 0;   
newAngleY = 0;  
newAngleZ = 0;  

%count the time.
tic;
%to be noticed, the data from gyroscope is of unit 'degrees per second'
[ratex,ratey,ratez] = readGyro(s);
current = toc;

%this code may be a bit confusing, the newAngleX and other two are actually the rate instead of angle. lazy to change
newAngleX = newAngleX + ratex;
newAngleY = newAngleY + ratey;
newAngleZ = newAngleZ + ratez;

%now, the variables are all angles rather than angular velocity any more.
reangleX = anglex+newAngleX * current ;
reangleY = angley+newAngleZ * current ;
reangleZ = anglez+newAngleZ * current ;

%keep the degrees inside (-360,360) to make it easy to understand
    while reangleX >=360
        reangleX = reangleX-360;
    end
    while reangleX<=-360
        reangleX = reangleX-360;
    end
    while reangleY >=360
        reangleY = reangleY-360;
    end
    while reangleY<=-360
        reangleY = reangleY-360;
    end
        while reangleZ >=360
        reangleZ = reangleZ-360;
    end
    while reangleZ<=-360
        reangleZ = reangleZ-360;
    end
end

