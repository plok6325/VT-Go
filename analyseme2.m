%analyseme 2

close all
clear all
tic
t=cputime;
total_result=[];

path='./result';
for pt=[50 100 500 1000 2000]
    clear stats
    all_mat=dir(['./result/',num2str(pt),'#*.mat']);
    stats.real=[0,0];
    realstat=[0,0];
    for mat_file =1 :length(all_mat)
        load ([path,'/',all_mat(mat_file).name], 'result')
        total_result=[total_result result];
    end
end

all_image_name= {total_result.file};
all_image_name=unique(all_image_name);

clean_result=[];

for index = 1 :length(all_image_name)
    this_image_name=all_image_name(index);
    clean_result(index).('Name')=this_image_name;
    clean_result(index).('Human')=0;
    clean_result(index).('Machine')=0;
     for second_index = 1: length(total_result)
        if strcmp(clean_result(index).Name,total_result(second_index).file) && ...
                total_result(second_index).xy(2) ==0 && total_result(second_index).xy(2) ==0 && ...
                total_result(second_index).xy(1)/total_result(second_index).limit(1) == 0.25
            clean_result(index).Human=1+clean_result(index).Human;
            
        elseif strcmp(clean_result(index).Name,total_result(second_index).file) && ...
                total_result(second_index).xy(2) ==0 && total_result(second_index).xy(2) ==0 && ...
                total_result(second_index).xy(1)/total_result(second_index).limit(1) == 0.75
            clean_result(index).Machine=1+clean_result(index).Machine;
            
        end
    end
end

display(num2str(toc));
all_Human=[clean_result.Human];
all_Machine=[clean_result.Machine];

bar([all_Human, all_Machine ] );

