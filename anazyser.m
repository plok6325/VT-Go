%% analyzer
clear all
path='./result'
all_mat=dir('**/*.mat');
stats.real=[0,0]; 
for mat_file =1 :length(all_mat)
    load ([path,'/',all_mat(mat_file).name], 'result')
    Exp_name_found={};
    for index = 1: length(result)
        [limit]=result(index).limit;
        [xy]=result(index).xy;
        selection=xy./limit;
        locations=regexp(result(index).file,'\w#');
        if xy(2)~=0
        else
            if isempty(locations)
                exp_name=['real',result(index).file(1:end-4)];
                k=1024;
                pi=1024;
                this_result=[1,xy(1)/limit(1)];
                stats.real=stats.real+[1,xy(1)/limit(1)]; 
            else
                exp_name=result(index).file(1:locations(1));
                k=result(index).file(locations(1)+1:locations(2));
                pi=result(index).file(locations(2)+1:locations(3));
                if fieldexist(fieldnames(stats),exp_name)
                else
                    stats.(exp_name)=[0,0];
                end
                this_result=[1,xy(1)/limit(1)];
                stats.(exp_name)=stats.(exp_name)+[1,xy(1)/limit(1)];
                
            end
        end
        Exp_name_found={Exp_name_found,exp_name};
        
       
        
    end
    
end

stats

%% black tech 

all_field=fieldnames(stats);
figure1=figure;
for field=1:length(all_field)
H=[[1,1];[0.25 0.75]];
Humanandpc= inv(H)*stats.(all_field{field})';
% 创建 axes
subplot1 = subplot(1,length(all_field),field,'Parent',figure1);
hold(subplot1,'on');
bar(Humanandpc,'Parent',subplot1)
box(subplot1,'on');
% 设置其余坐标轴属性
set(subplot1,'XTick',[1 2],'XTickLabel',{'Humna','PC'});
title(all_field{field})
end 