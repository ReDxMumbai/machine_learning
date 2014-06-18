function [ta,th,da,dh,conf] = getBracketConfusion(signal,target)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
signal
target
p=[0 diff(signal(2,:)) 0];
q=[0 diff(signal(1,:)) 0];
pedgesa=find(p==1);
nedgesa=find(p==-1);
pedgesh=find(q==1);
nedgesh=find(q==-1);
r=[0 diff(target(2,:)) 0];
s=[0 diff(target(1,:)) 0];
pedgesat=find(r==1);
nedgesat=find(r==-1);
pedgesht=find(s==1);
nedgesht=find(s==-1);
aa=0;
ah=0;
an=0;
ha=0;
hh=0;
hn=0;
na=0;
nh=0;
nn=-1;
for i=1:length(pedgesa)
    for j=1:length(pedgesat)
       if overlaps(pedgesa(i),nedgesa(i),pedgesat(j),nedgesat(j))
           aa=aa+1;
           break;
       end
    end
end
for i=1:length(pedgesa)
    for j=1:length(pedgesht)
        if overlaps(pedgesa(i),nedgesa(i),pedgesht(j),nedgesht(j))
            ah=ah+1;
            break;
        end
    end
end
an=length(pedgesa)-aa-ah;
for i=1:length(pedgesh)
   for j=1:length(pedgesat)
      if overlaps(pedgesh(i),nedgesh(i),pedgesat(j),nedgesat(j))
          ha=ha+1;
          break;
      end
   end
end
for i=1:length(pedgesh)
   for j=1:length(pedgesht)
      if overlaps(pedgesh(i),nedgesh(i),pedgesht(j),nedgesht(j))
         hh=hh+1;
         break;
      end
   end
end
hn=length(pedgesh)-ha-hh;
conf=[aa,ah,an;
      ha,hh,hn];
ta=length(pedgesat);
th=length(pedgesht);
da=length(pedgesa);
dh=length(pedgesh);
end

