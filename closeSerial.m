% a typical way to close the serial
% Sometimes Matlab doesn't allow to connect the same arduino as two object.
% To eliminate the error
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
close all
disp('serial port closed');
