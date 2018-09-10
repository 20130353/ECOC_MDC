%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ������ȷ�Ȳ�Ⱥ͸��Ӷȱ任
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function save_csv(cplx,ica,genpath,name)
    csvpath = [genpath,'/acc+cplx'];
    mkdir(csvpath);
    save_acc(cplx,ica,csvpath,name);
    save_cplx(cplx,csvpath,name);
end

function save_acc(cplx,ica,path,name)
    acc=[];
    for i=1:size(cplx,1) %���ݼ�����
        for j=1:size(cplx{i,2},2)%�ڼ������Ӷ�      
            acc=[acc;cplx{i,2}{j}];
        end 
        for j=1:size(ica{i,2},2)
            temp=ica{i,2}{j};
            acc=[acc;temp(1:5)];
        end     
        temp=zeros([1,5]);
        temp(1,:)=-11111;
        acc=[acc;temp];
    end
    csvwrite([path,'/accuracy_',name,'.csv'],acc);  
end

%�������ݼ��ĸ��Ӷ�
function save_cplx(cplx,path,name)
    xx=[];
    for i=1:size(cplx,1) %���ݼ��ĸ���        
       cp=get_fcplx(cplx{i,6});%���ÿ�����ݼ���cplx����       
       if(size(xx,2)<size(cp,2) && isempty(xx)==false)%ԭ�ȵĸ��Ӷ�����С
           temp=zeros([size(xx,1),size(cp,2)-size(xx,2)]);
           temp(1:size(xx,1),:)=-11111;
           xx=[xx temp];%�ӳ���
       elseif(size(xx,2)>size(cp,2))
           temp=zeros([size(cp,1),size(xx,2)-size(cp,2)]);
           temp(1:size(cp,1),:)=-11111;
           cp=[cp temp];%�ӳ���             
       end       
       temp=zeros([1,size(cp,2)]);
       temp(:)=-10000;%ƴ�ӿ��ַ���
       xx=[xx;cp;temp];
    end
    csvwrite([path,'/complexity_',name,'.csv'],xx);  
end

function cp=get_fcplx(tcplx)
    fillnum=-11111;
    maxnum=5;
    cp=[];
    for i=1:size(tcplx,2) %1-8�����ݸ��Ӷ�       
       column=tcplx{i};%ÿһ�����ݸ��Ӷ�
       fcplx=[];
       for j=1:size(column,2)%ÿ�����Ӷȵ����cplx
            new_row=column{j};
            if(size(new_row,2)~=maxnum)%����г��������ӳ���
                temp=zeros([1,maxnum-size(new_row,2)]);
                temp(1,:)=fillnum;
                new_row=[new_row temp];
            end            
            fcplx=[fcplx;new_row];%ƴ��ÿһ��
       end
       new_row=zeros([1,maxnum]);
       new_row(1,:)=i*-11111;
       cp=[cp;fcplx;new_row];%Ϊÿ�����Ӷ����i�ָ�
    end
end
