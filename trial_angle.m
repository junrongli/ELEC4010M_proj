function [ reangleX,reangleY,reangleZ ] = trial_angle(anglex,angley,anglez ,s)
%TRIAL_ANGLE Summary of this function goes here
%   Detailed explanation goes here
fprintf(s,'G');
newAngleX = 0;   
newAngleY = 0;  
newAngleZ = 0;  
tic;

            [ratex,ratey,ratez] = readGyro(s);
            current = toc;
            newAngleX = newAngleX + ratex;
            newAngleY = newAngleY + ratey;
            newAngleZ = newAngleZ + ratez;

reangleX = anglex+newAngleX * current ;
reangleY = angley+newAngleY * current ;
reangleZ = anglez+newAngleZ * current ;

    while reangleX >=360
        reangleX = reangleX-360;
    end
    while reangleX<=-360
        reangleX = reangleX+360;
    end
    while reangleY >=360
        reangleY = reangleY-360;
    end
    while reangleY<=-360
        reangleY = reangleY+360;
    end
    while reangleZ >=360
        reangleZ = reangleZ-360;
    end
    while reangleZ<=-360
        reangleZ = reangleZ+360;
    end
end

