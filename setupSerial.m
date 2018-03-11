function [ s,flag ] = setupSerial( comPort )
%SETUPSERIAL Summary of this function goes here
%   Detailed explanation goes here
flag = 1;
s = serial(comPort);

set(s,'BaudRate',115200);
fopen(s);

a='b';
while(a~='a')
    a = fread(s,1,'uchar');
end
if (a=='a')
    disp('serial read');
end
fprintf(s,'%c','a');
mbox = msgbox('Serial communication setup.');
uiwait(mbox);
fscanf(s,'%u');
end


