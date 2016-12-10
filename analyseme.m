%% analyzer
clear all
close all

path='./result';
for pt=[50 100 500 1000 2000]
    clear stats
all_mat=dir(['./result/',num2str(pt),'#*.mat']);
stats.real=[0,0];
realstat=[0,0];
for mat_file =1 :length(all_mat)
    load ([path,'/',all_mat(mat_file).name], 'result')
    Exp_name_found={};
    this_realstat=[0,0];
    for index = 1: length(result)
        [limit]=result(index).limit;
        [xy]=result(index).xy;
        selection=xy./limit;
        locations=regexp(result(index).file,'\w#');
        
        if xy(2)~=0
        else
            if isempty(locations) % real 
                exp_name=['real',result(index).file(1:end-4)];
                k=1024;
                pi=1024;
                this_result=[1,xy(1)/limit(1)];
                stats.real=stats.real+[1,xy(1)/limit(1)];
                this_realstat=this_realstat+[1,xy(1)/limit(1)];
                
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
    H=[[1,1];[0.25 0.75]];
    realstat=[realstat; (inv(H)*this_realstat')'];
end


%% significant test (student's t  test )
realstat=realstat(2:end,:);
realstat=realstat(:,1)./sum(realstat,2);
real_mean=mean(realstat);
real_mu=std(realstat);


all_field=fieldnames(stats);
figure1=figure;
for field=1:length(all_field)
    stats.real=sum(stats.real,1);
    H=[[1,1];[0.25 0.75]];
    Humanandpc= inv(H)*stats.(all_field{field})';
    % ���� axes
    confusion(:,field)=Humanandpc;
    subplot1 = subplot(1,length(all_field),field,'Parent',figure1);
    hold(subplot1,'on');
    bar(Humanandpc,'Parent',subplot1)
    this_prob=Humanandpc/sum(Humanandpc);
    t=-(real_mean-this_prob(1))/sqrt(sum(Humanandpc))/real_mu;
    tcdf(t,sum(Humanandpc));
    box(subplot1,'on');
    % ������������������
    set(subplot1,'XTick',[1 2],'XTickLabel',{'Human','Machine'});
    title(['pt=',num2str(pt),'   ',all_field{field}],'Interpreter','none');
    Hypothesis= inv(H)*stats.real'/sum(inv(H)*stats.real');
    %xlabel(num2str(tcdf(t,sum(Humanandpc)-1)));
end

end
confusion(1,2:end)./confusion(2,2:end)
[m i]=max (confusion(1,2:end)./confusion(2,2:end))
best_machine = confusion(:,i+1);
real= confusion(:,1) ;
t=[ones(1,real(1)) zeros(1,real(2))];
TP=real(1)./sum(real);
FP=real(2)./sum(real);
FN=best_machine(1)./sum(best_machine);
TN=best_machine(1)./sum(best_machine);
clc 
display(['Recall = ', num2str(TP) ]);
display([' Specificity = ',num2str( TN)]);
%sum(confusion(:,2:end),2);

