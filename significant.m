function [ output_args ] = significance ( Hypothesis, Humanandpc  )
% calculate probability under this hyopthesis 
ss=[];
commu = [0:Humanandpc(1);sum(Humanandpc)-0:-1:Humanandpc(2)];
for x = 1 :length(commu(1,:))
    ss=[ ss ,prob(Hypothesis,commu(:,x))];
end
output_args=sum(ss);

end

