function [offsets] = extractOffsets()
%Extracts offsets from datasets
%   Detailed explanation goes here
base='ucddb';
ext='.rec';
files={'002','003','005','006','007','008','009','010','011','012','013','014','015','017','018','019','020','021','022','023','024','025','026','027','028'};
offsets=zeros(1,length(files));
for i=1:length(files)
   filename=[base,cell2mat(files(i)),ext];
   disp(filename);
   h=edfread(filename);
   start=h.starttime;
   hrs=int64(sym(start(1:2)));
   mins=int64(sym(start(4:5)));
   secs=int64(sym(start(7:8)));
   if hrs>18%arbit number
      hrs=-(23-hrs);
      mins=-(59-mins);
      secs=-(60-secs);
   end
   offsets(i)=hrs*3600+mins*60+secs;
end

end

