function [ angleX,angleY,angleZ ] = getAngle( gyroConnection_s , gainX, gainY,gainZ )
%GETANGLES Summary of this function goes here
%   Detailed explanation goes here
    persistent previousRateX;
    persistent previousRateY;
    persistent previousRateZ;
    if(isempty(previousRateX)); previousRateX = 0; end
    if(isempty(previousRateY)); previousRateY = 0; end
    if(isempty(previousRateZ)); previousRateZ = 0; end
    
    persistent previousAngleX;
    persistent previousAngleY;
    persistent previousAngleZ;
    if(isempty(previousAngleX)); previousAngleX = 0; end
    if(isempty(previousAngleY)); previousAngleY = 0; end
    if(isempty(previousAngleZ)); previousAngleZ = 0; end
    
    persistent previousTime;
    if(isempty(previousTime)); previousTime = 0; tic; end
    
    [rateX,rateY,rateZ] = readGyro(gyroConnection_s);
    currentTime = toc;
    
    newAngleX = calculateAngle(previousRateX,rateX,gainX);
    angleX = updateAngle(previousAngleX +newAngleX);
    newAngleY = calculateAngle(previousRateY,rateY,gainY);
    angleY = updateAngle(previousAngleY +newAngleY);
    newAngleZ = calculateAngle(previousRateZ,rateZ,gainZ);
    angleZ = updateAngle(previousAngleZ +newAngleZ);
    
    previousRateX = rateX;
    previousRateY = rateY;
    previousRateZ = rateZ;
    previousAngleX = angleX;
    previousAngleY = angleY;
    previousAngleZ = angleZ;
    previousTime = currentTime;
    
    function [ angle ]  = calculateAngle(previousRate, rate,gain)
        angle = ((previousRate/2 + rate/2)*...
            (currentTime - previousTime)*gain)/100;
        angle = floor(angle);
    end
    function [ angle ] = updateAngle(angle)
        if ( angle<0)
            angle = angle +360;
        else if (angle>=360)
                angle = angle -360;
            end
        end
    end
end

