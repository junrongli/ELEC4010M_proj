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

if(~exist('dynamicButton','var'))
    dynamicButton = uicontrol('Style','checkbox','String','drag and zoom','pos',[0 25 200 25],'parent',figureHandle);
end

if(~exist('axisSwitchX','var'))
    axisSwitchX = uicontrol('Style','checkbox','String','X axis','pos',[300 0 50 23],'parent',figureHandle);
end

if(~exist('axisSwitchY','var'))
    axisSwitchY = uicontrol('Style','checkbox','String','Y axis','pos',[350 0 50 23],'parent',figureHandle);
end
if(~exist('axisSwitchZ','var'))
    axisSwitchZ = uicontrol('Style','checkbox','String','Z axis','pos',[400 0 50 23],'parent',figureHandle);
end

if(~exist('degreeLabelheading','var'))
    degreeLabelheading = uicontrol('Style','checkbox','String','H: 0 degrees','pos',[450 200 100 23],'parent',figureHandle);
end

if(~exist('degreeLabelX','var'))
    degreeLabelX = uicontrol('Style','checkbox','String','X: 0 degrees','pos',[450 100 100 23],'parent',figureHandle);
end

if(~exist('degreeLabelY','var'))
    degreeLabelY= uicontrol('Style','checkbox','String','Y:0 degrees','pos',[450 75 100 23],'parent',figureHandle);
end
if(~exist('degreeLabelZ','var'))
    degreeLabelZ= uicontrol('Style','checkbox','String','Z: 0 degrees','pos',[450 50 100 23],'parent',figureHandle);
end

if(~exist('resetRadioButton','var'))
    resetRadioButton = uicontrol('Style','radiobutton','String','Reset','pos',[500 0 50 25],'parent',figureHandle);
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

AngleX = 0;
AngleY = 0;
AngleZ = 0;
heading =0;

currentstatus = get(dynamicButton,'Value'); 
while( get(stopButton,'Value') ==0)
    
    [AngleX, AngleY,AngleZ] = trial_angle(AngleX,AngleY,AngleZ,gyroConnection_s);
     if currentstatus ~= get(dynamicButton,'Value')        
        if get(dynamicButton,'Value') ==1
            dragzoom('on');
            currentstatus = get(dynamicButton,'Value'); 
        else
            dragzoom('off');
            currentstatus = get(dynamicButton,'Value'); 
        end
     end
     
     if get(axisSwitchX,'Value') ==0
        AngleX =0;
     end
    
    if get(axisSwitchY,'Value') ==0
        AngleY =0;
    end
    if get(axisSwitchZ,'Value') ==0
        AngleZ = 0;
     end
    
    if(get(resetRadioButton,'Value')==1)
        AngleX=0;
        AngleY=0;
        AngleZ=0;
        set(resetRadioButton,'Value',0);
    end
    
    heading = trial_heading(gyroConnection_s);
    set(degreeLabelheading,'String',['H: ' num2str((heading)) 'degrees'])
    
    
   
    
    set(degreeLabelX,'String',['X: ' num2str((AngleX)) 'degrees'])
    set(degreeLabelY,'String',['Y: ' num2str((AngleY)) 'degrees'])
    set(degreeLabelZ,'String',['Z: ' num2str((AngleZ)) 'degrees'])
    R = makehgtform('xrotate', -AngleY*pi/180,...
        'yrotate', AngleX*pi/180,...
        'zrotate', AngleZ*pi/180);
    set(hgTransform,'Matrix',R);
%
    
    drawnow;
end
closeSerial();
        
        
        
    
    
    




