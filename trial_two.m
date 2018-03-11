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

if(~exist('resetRadioButton','var'))
    resetRadioButton = uicontrol('Style','radiobutton','String','Reset','pos',[500 0 50 25],'parent',figureHandle);
end
if(~exist('stopButton','var'))
    stopButton = uicontrol('Style','togglebutton','String','Stop & Close Serial Port','pos',[0 0 200 25],'parent',figureHandle);
end


if(~exist('labelRoll','var'))
    labelRoll = uicontrol('Style','checkbox','String','X: 0 m/s','pos',[450 125 100 23],'parent',figureHandle);
end

if(~exist('labelPitch','var'))
    labelPitch= uicontrol('Style','checkbox','String','Y:0 m/s','pos',[450 150 100 23],'parent',figureHandle);
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
hgTransformArray(5) = surface(xc,1.5*yc-1.3,zb,'FaceColor','magenta');%purple






hgTransform = hgtransform('Parent',graphAxes);

set(hgTransformArray,'Parent',hgTransform);
drawnow();
pause(0.25);

roll = 0;
ptich = 0;
while( get(stopButton,'Value') ==0)
    view(3);
    [roll,pitch] = trial_euler(gyroConnection_s);
    if(get(resetRadioButton,'Value')==1)
        roll=0;
        pitch = 0;
        set(resetRadioButton,'Value',0);
    end
    set(labelRoll,'String',['roll: ' num2str((roll)) 'degrees'])
    set(labelPitch,'String',['pitch: ' num2str((pitch)) 'degrees'])
    %pitch headdown is negative
    %roll left down is negative
%cable in front, standing normally
    R = makehgtform('xrotate', pitch*pi/180,...
        'yrotate', roll*pi/180);
    set(hgTransform,'Matrix',R);

    
    drawnow;
end
closeSerial();
        
        
        
    
    
    




