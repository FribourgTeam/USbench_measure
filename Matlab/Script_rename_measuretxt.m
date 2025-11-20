%script rename measure files following the max number of digit
clear
ffiles = dir('measure*.txt');

%find the longest txt filename
maxsize = 0;
for i = 1:size(ffiles,1)
    if length(ffiles(i).name) > maxsize
        maxsize = length(ffiles(i).name);
    end
end
dmaxsize = maxsize-8-4;%number of digit needed

for i = 1:size(ffiles,1)
    filename = ffiles(i).name;
    idx1 = find(filename == '_');
    idx2 = find(filename == '.');
    digit0 = filename((idx1+1):(idx2-1));
    digit1 = str2num(digit0);
    
    if length(digit0)<dmaxsize
        %dmaxsize-length(digit0)
        digit0 = [repmat('0',1,dmaxsize-length(digit0)) digit0];
        %dmaxsize = length(digit1);
    end
    newfilename = ['mes_' digit0 '.txt'];
    copyfile(filename,newfilename)
end







