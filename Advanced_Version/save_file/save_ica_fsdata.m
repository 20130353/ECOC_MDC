%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����ica_fs�任�������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function save_ica_fsdata(genpath,order)
    filename=[genpath,'/data_ica_1--10/data_ica_',num2str(order)];
    
    respath = [genpath,'/data_ica_fs_50/data_ica_',num2str(order)];
    mkdir(respath);
    
    datanames={'Breast','Cancers','DLBCL','GCM','Leukemia2','Leukemia3','Lung1','Lung2','SRBCT'};    
    %��Ϊ������˹������Ҫ���е��ϵ���㣬��ͬ�ĵ��ϵ�����ɲ�ͬ��feature
    %selection����Ϊ��ȷ��ѧ��ʹ�������ֹ�ϵ���������ﲻʹ��������˹��������ѡ��
    fs_method = {'bhattacharyya','entropy','roc','ttest','wilcoxon'};    
    feature_size = 50;
    
    for fs_option = 1:size(fs_method,2)
        
        subrespath = [respath,'/',fs_method{fs_option}];
        mkdir(subrespath);           
        
        for dataset_option=1:size(datanames,2)          
            
             %read ica data
             dtype={'traindata','trainlabel','testdata','testlabel'};                  
             for j=1:size(dtype,2)
                matname=[filename,'/',datanames{dataset_option},'_',dtype{j},'.mat'];
                load(matname);
             end %end of dtype  
             
             len = size(unique(dl),1);
             Z = zeros(size(td,2),1);
             for label_option = 1:len
                BC = dl == label_option;
                %feature selection -- �������� ����feature
                [index,z] = rankfeatures(td',BC','Criterion',fs_method{fs_option});
                for k = 1:size(index,1)
                   Z(index(k),1) =  Z(index(k),1) + z(k,1);
                end                
             end
             [~,importance_order] = sort(Z,'descend');
             
             td = td(:,importance_order(1:feature_size));
             testdata = testdata(:,importance_order(1:feature_size));
           
             dname={'td','dl','testdata','data_test_label'};         
             for j=1:size(dtype,2)
                matname=[subrespath,'/',datanames{dataset_option},'_',dtype{j},'.mat'];
                save(matname,dname{j});
             end %end of dtype   
             
        end%end of fs_method
        
    end%end of dataset    
    
end%end of function

