if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
close all
disp('serial port closed');