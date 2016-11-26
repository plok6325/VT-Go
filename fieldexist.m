function result=fieldexist(cell,string)
result=0;
for x =1:length(cell)

    if strcmp(cell{x},string)
    result=result+1;
    end

end