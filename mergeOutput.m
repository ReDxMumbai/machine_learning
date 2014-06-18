function [out] = mergeOutput(signal)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
out=zeros(1,length(signal));
base=1:length(signal);
for i=1:length(out)
    if signal(i)
        out=out+exp((-(base-i).^2)/1.27);
    end
end
out=out>0.5;
end

