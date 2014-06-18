function [yn] = overlaps(a,b,c,d)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
if c<b && a<c
   yn=1;
elseif c<b && b<d
   yn=1; 
else
   yn=0;
end
end

