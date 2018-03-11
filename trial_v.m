clc;
close all;
clear all;

comPort = 'COM3';
if(~exist('serialFlag','var'))
    [gyroConnection_s,serialFlag] = setupSerial(comPort);
end

if(~exist('figureHandle','var') || ~ishandle(figureHandle))
    figureHandle = figure(1);
end

if(~exist('stopButton','var'))
    stopButton = uicontrol('Style','togglebutton','String','Stop & Close Serial Port','pos',[0 0 200 25],'parent',figureHandle);
end
if(~exist('velocityLabelX','var'))
    velocityLabelX = uicontrol('Style','checkbox','String','X: 0 m/s','pos',[450 125 100 23],'parent',figureHandle);
end

if(~exist('velocityLabelY','var'))
    velocityLabelY= uicontrol('Style','checkbox','String','Y:0 m/s','pos',[450 150 100 23],'parent',figureHandle);
end
if(~exist('velocityLabelZ','var'))
    velocityLabelZ= uicontrol('Style','checkbox','String','Z: 0 m/s','pos',[450 175 100 23],'parent',figureHandle);
end

graphAxes = axes('XLim',[-2,2],'YLim',[-2,2],'ZLim',[-2,2]);
view(3);
axis off;
axis equal;

[xc, yc, zc] = cylinder([0.1 0.0]); %cone
[xb, yb, zb] = cylinder([0.2 0.2]);

hgTransformArray(1) = surface(xc,zc,-yc,'FaceColor','red');
hgTransformArray(2) = surface(zb,yb,0.5*xb,'FaceColor','green');
hgTransformArray(3) = surface(-zb,yb,0.5*xb,'FaceColor','blue');
hgTransformArray(4) = surface(xb,-1.5*zb,0.5*yb,'FaceColor','cyan');
hgTransformArray(5) = surface(xc,1.5*yc-1.3,zb,'FaceColor','magenta');

hgTransform = hgtransform('Parent',graphAxes);

set(hgTransformArray,'Parent',hgTransform);
drawnow();
pause(0.25);
V_X=0;
V_Y=0;
V_Z=0;
while( get(stopButton,'Value') ==0)
     [V_X, V_Y,V_Z] = trial_velocity(gyroConnection_s);
    set(velocityLabelX,'String',['X: ' num2str((V_X)) ',m/s'])
    set(velocityLabelY,'String',['Y: ' num2str((V_Y)) 'm/s'])
    set(velocityLabelZ,'String',['Z: ' num2str((V_Z)) 'm/s'])
    pause(1);
end
closeSerial();