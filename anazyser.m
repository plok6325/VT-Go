%% analyzer
path='./result'
all_mat=dir('**/*.mat')
for mat_file =1 :length(all_mat)
    load ([path,'/',all_mat(mat_file).name], 'result')
    Exp_name_found={};
    for index = 1: length(result)
        [limit]=result(index).limit;
        
        [xy]=result(index).xy;
        selection=xy./limit;
        locations=regexp(result(index).file,'\w#');
        if isempty(locations)
            exp_name=['real',result(index).file(1:end-4)]
            k=1024;
            pi=1024;
        else
            
            exp_name=result(index).file(1:locations(1));
            k=result(index).file(locations(1)+1:locations(2));
            pi=result(index).file(locations(2)+1:locations(3));
        end
        
        Exp_name_found={Exp_name_found,exp_name}
        
        
        %eval([exp_name,'=[]'])
        
        if selection(1)<0.4
            eval([exp_name,'=[',exp_name,';1,0]'])
        else
            eval([exp_name,'=[',exp_name,';0,1]'])
            
        end
        
    end
    
end