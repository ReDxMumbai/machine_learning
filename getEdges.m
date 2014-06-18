function [edges] = getEdges(signal,type)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if type==1
    edges=signal&~[0 signal(1:end-1)];
else
    edges=~signal&[0 signal(1:end-1)];
end

end

