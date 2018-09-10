%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ���������е�����ָ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fres=get_fscore(testlabel,prelabel)
    res=[];
    class=unique(testlabel);
    %�����������б�׼ȷ��Ŀ
    for i=1:size(class,1)
        TN=0;
        TP=0;
        FN=0;
        FP=0;
        %��������label
        temptl=zeros([size(testlabel,1),1]);%test label
        temppl=zeros([size(testlabel,1),1]);%predict label
        
        it=find(testlabel==class(i));
        temptl(it)=1;
        ip=find(prelabel==class(i));
        temppl(ip)=1;
        
        for j=1:size(temptl,1)
            if(temppl(j)==0 && temptl(j)==0) 
                TN=TN+1;
            elseif(temppl(j)==0 && temptl(j)==1) 
                FN=FN+1;
            elseif(temppl(j)==1 && temptl(j)==0) 
                FP=FP+1;
            elseif(temppl(j)==1 && temptl(j)==1) 
                TP=TP+1;
            end
        end
        
        %�������еĲ���
        P=size(it,1);
        N=size(testlabel,1)-P;
        accurary=(TP+TN)/(P+N);
        error=(FP+FN)/(P+N);
        sensitivity=TP/P;
        specifity=TN/N;
        if(TP+FP==0)
            precision=0;
        else
            precision=TP/(TP+FP);%����
        end
        if(precision+sensitivity~=0)
            f=(2*precision*sensitivity)/(precision+sensitivity);%���;�ֵ
        else
            f=0;
        end      
        res(i,:)=[accurary,sensitivity,specifity,precision,f];       
    end
    
    
    %���÷�ȡ��ֵ
    for i=1:size(res,2)
        fres(i)=mean(res(:,i));
    end

end


