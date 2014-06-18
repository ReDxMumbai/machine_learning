function [yn] = overlaps(a,b,c,d)
%UNTITLED9 Summary of this function goes here
%   a c b d or c a d b
if c<=b && a<=c
   yn=1;
elseif c<=a && a<=d
   yn=1; 
else
   yn=0;
end
end

