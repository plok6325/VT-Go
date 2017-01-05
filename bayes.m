x=0:0.0001:1; 
close all
%% prior uniform  A credible interval 95%
credible_interval=90 ;
null_hyp=[50,150];
real_index=find(strcmp(all_field,'real'));
real_alpha_beta= 1+Human_pc(:,real_index);
real_mean=(real_alpha_beta(1))/sum(real_alpha_beta(:)); % max != mean
prior_beta= betapdf(real_mean,real_alpha_beta(1),real_alpha_beta(2)); % prepar

figure
plot(x,betapdf(x,1,1),'Linewidth',3); % assume real is prior 
for index = 1:length(all_field)
    alp=1+Human_pc(1,index);
    bet=1+Human_pc(2,index);
    alpha_beta_summary(:,index)= [alp;bet];
    theta_summary(:,index)=betapdf(x,alp,bet)';
    plot(x,betapdf(x,alp,bet),'LineWidth',3);
    BF(index)=prior_beta/betapdf(real_mean,alp,bet); % postrior / prior
    hold on
end
all_field1=all_field;
all_field1{1}='Omniglot';
all_field1{2}='\pi=0.9';
all_field1{3}='\pi=0.1';
all_field1{4}='\pi=0.5';
all_field1{5}='uniform prior'
plot(x,betapdf(x,1,1),'--','Linewidth',3,'color',[0.8 0.8 0.8]); % assume real is prior 


legend(all_field1,'Fontsize',24);
xlabel('\theta','Fontsize',24) 
[rate,theta_index]=max(theta_summary(:,real_index))
theta=x(theta_index)
 credible_interval=credible_interval/100;
 upper=find(betacdf(x,alpha_beta_summary(1,real_index),alpha_beta_summary(2,real_index))>(1-(1-credible_interval)/2));
 lower=find(betacdf(x,alpha_beta_summary(1,real_index),alpha_beta_summary(2,real_index))<((1-credible_interval)/2));
x([lower(end),upper(1)]);
vert_max=max(max(theta_summary));
line([x(lower(end)) x(lower(end))],[0 vert_max+1],'Color',[0.8 0.8 0.8],'LineWidth',2)
line([x(upper(1)) x(upper(1))],[0 vert_max+1],'Color',[0.8 0.8 0.8],'LineWidth',2)
 
display(num2str(BF))

%% real as prior 
figure 
real_alpha_beta=alpha_beta_summary(:,real_index);

plot(x,betapdf(x,real_alpha_beta(1)+null_hyp(1),real_alpha_beta(2)+null_hyp(2)),'Linewidth',3); % assume real is prior 



real_mean=(real_alpha_beta(1)+null_hyp(1))/sum(null_hyp(:)+real_alpha_beta(:)); % max != mean
prior_beta= betapdf(real_mean,real_alpha_beta(1)+null_hyp(1),real_alpha_beta(2)+null_hyp(2)); % prepare to calc bayes factor
hold on
for index =1:length(all_field) 
    if index ~= real_index
    alp=null_hyp(1)+alpha_beta_summary(1,index);
    bet=null_hyp(2)+alpha_beta_summary(2,index);
    plot(x,betapdf(x,alp,bet),'LineWidth',3);
    BF(index)=betapdf(real_mean,alp,bet)/prior_beta; % postrior / prior
    hold on
    
    end
end 
legend(all_field,'Fontsize',15);
xlabel('\theta','Fontsize',24)


plot(x,betapdf(x,null_hyp(1),null_hyp(2)),'Linewidth',3,'Color',[0.8 0.8 0.8]);
