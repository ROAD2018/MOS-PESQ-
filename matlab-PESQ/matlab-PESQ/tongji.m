%%%%%%%%%%%%%%%%%%%%ͳ��QQ����ͨ������(��)%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%kingma-----2015-9-8��%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% clc
% clear all
% close all
%%
%��ȡ�ļ�����ʼ��
N =60;                                  %�ļ�����
t=10;                                    %����
% [code,pesq,X,Y] = read('E:\�Զ�������\ucpaasӢ����ʱ�������ʶ�\', N);

data_ying_nan=wavread('Ӣ��������.wav');          %��ȡ�ο�����
% data_ying_nv=wavread('Ӣ��Ů����.wav');
% data_han_nan=wavread('����������.wav');
% data_han_nv=wavread('����Ů����.wav');

[X_ying_nan,Y_ying_nan]=vad(data_ying_nan);        %����ο������ϵ�
[X_ying_nv,Y_ying_nv]=vad(data_ying_nan); 
[X_han_nan,Y_han_nan]=vad(data_ying_nan); 
[X_han_nv,Y_han_nv]=vad(data_ying_nan); 

pseq1=zeros(1,N);
code1=zeros(length(code),N);
%code1(:,1)=0;
%XX(:,1)=0;             %��ʼ��VAD�洢�ռ�
%YY(:,1)=0;
%pesq1(:,1)=0;
%PESQ=zeros(48,5);


 XX_ying_nan=zeros(1,N);
XX_ying_nv=zeros(1,N);
XX_han_nan=zeros(1,N);
XX_han_nv=zeros(1,N);

%%
%ȥ����������
 for k=1:N
%        if(rem(k,5)==1)
%            code1(:,k)=0;
%            pesq1(:,k)=0;
%            XX(:,k)=0;
%            YY(:,k)=0;
%        else
           code1(:,k)=code(:,k);
           pesq1(:,k)=pesq(:,k);
           XX(:,k)=X(:,k);
           YY(:,k)=Y(:,k);
%        end
 end
 
 
  %%
%  %�ж���Чֵ
%  for k=1:N
%      if(pesq1(:,k)<1)
%      pesq1(:,k)=0.5*(pesq1(:,k+1)+pesq1(:,k-1));
% %         pesq1(:,k)=pesq1(:,k-1);
%      else
%          pesq1(:,k)=pesq1(:,k);
%      end
%  end

 % pesq1(1,65)=0.5*(pesq1(1,64)+pesq1(1,63));
  %pesq1(1,30)=pesq1(1,31);
%%    
  xlswrite('D:\matlab\����\zidonghuaceshi\924921636speechQuality\UCPAAS_ying_nan_shidingmabian.xls',pesq1);%���ݴ洢��D�̸�Ŀ¼��
% D:\matlab\����\924921636speechQualityΪ�洢·�����ļ���
% pesq1 Ϊ��Ҫ�洢������ 
% data1Ϊ�洢��Excel�еı���

%%
    %�������ݲ�����
 fid = fopen('UCPAAS_ying_nan_shidingmabian.txt','wt');
 for j = 1:t:N
        if(rem(j,t)~=0)
        fprintf(fid,'%d;%d;%d;%d;%d\n',pesq1(:,j),pesq1(:,j+1),pesq1(:,j+2),pesq1(:,j+3),pesq1(:,j+4));
       else 
         break;
       end
 end
 fclose(fid);

    
%%
%��mos�÷�
for kk=1:N
    if(kk<=N)
       XX_ying_nan(1,kk)=XX(1,kk)-X_ying_nan;
        if(XX_ying_nan(1,kk)<0)                          %�жϴ���ֵ
           XX_ying_nan(1,kk)=0;
        else
            XX_ying_nan(1,kk)=XX_ying_nan(1,kk);
        end
       figure(1)
       plot(pesq1(1:kk),'-*b');
       grid on
       hold on
%     elseif(kk<=120)
%        XX_ying_nv(1,kk)=XX(1,kk)-X_ying_nv;
%        if(XX_ying_nv(1,kk)<0)
%            XX_ying_nv(1,kk)=0;
%         else
%             XX_ying_nv(1,kk)=XX_ying_nv(1,kk);
%         end
%        figure(2)
%        plot(pesq1(61:kk),'-*b');
%        hold on
%        grid on
%        
%     elseif(kk<=180)
%        XX_han_nan(1,kk)=XX(1,kk)-X_han_nan;
%        if(XX_han_nan(1,kk)<0)
%            XX_han_nan(1,kk)=0;
%         else
%             XX_han_nan(1,kk)=XX_han_nan(1,kk);
%         end
%        figure(3)
%        plot(pesq1(121:kk),'-*b');
%        hold on
%        grid on
%        
%      elseif(kk<=240)
%        XX_han_nv(1,kk)=XX(1,kk)-X_han_nv;
%        if(XX_han_nv(1,kk)<0)
%            XX_han_nv(1,kk)=0;
%         else
%             XX_han_nv(1,kk)=XX_han_nv(1,kk);
%         end
%        figure(4)
%        plot(pesq1(181:kk),'-*b');
%        hold on
%        grid on
%       
    end
%        
end


%%         �������ݲ���ͼ
        figure(1)
        hold on
       ave_ying_nan = 1*mean(pesq1(1:N));
      
           
       delay_ying_nan = 1*mean(XX_ying_nan);
       plot(1:N,ave_ying_nan,'-*r');
%        xlab=[0 2 3 5 8 10 12 15 20 25 30 40];
       %title('Ӣ��������');
       xlabel('������%(0 2 3 5 8 10 12 15 20 25 30 40)');
       ylabel('PESQ-MOS');
%        title(['Ӣ����������AVE-PESQ=',num2str(ave_ying_nan),'����ʱ��ms��=',num2str(10*delay_ying_nan)]);
       title(['Ӣ����shidingmabian��AVE-PESQ=',num2str(ave_ying_nan),'���޶���PESQ=',num2str(mean(pesq1(1:5))),'����ʱ��ms��=',num2str(10*delay_ying_nan)]);
       %sprintf('Ӣ������������ƽ��ֵ=%f',num2str(ave_ying_nan));
       %textstr=sprintf('x=%d,y=%d',num2str(x),num2str(y));
       %textstr={'x=',num2str(x),'y=',num2str(y)};
       %text(4,3.5,num2str(ave_ying_nan));
%        set(gca,'xticklabel',xlab);
        axis([0 N 0 4.5]);
       
%        figure(2)
%        hold on
%        ave_ying_nv = 1.2*mean(pesq1(61:120));
%        delay_ying_nv = 1.2*mean(XX_ying_nv);
%        plot(1:60,ave_ying_nv,'-*r');
%       title(['Ӣ��Ů����:AVE-PESQ=',num2str(ave_ying_nv),'����ʱ��ms��=',num2str(10*delay_ying_nv)]);
%        xlabel('������%(0 2 3 5 8 10 12 15 20 25 30 40)');
%        ylabel('PESQ-MOS');
%        
%        figure(3)
%        hold on
%        ave_han_nan = 1.2*mean(pesq1(121:180));
%        delay_han_nan = 1.2*mean(XX_han_nan);
%        plot(1:60,ave_han_nan,'-*r');
%        title(['����������:AVE-PESQ=',num2str(ave_han_nan),'����ʱ��ms��=',num2str(10*delay_han_nan)]);
%        xlabel('������%(0 2 3 5 8 10 12 15 20 25 30 40)');
%        ylabel('PESQ-MOS');
%        
%        figure(4)
%        hold on
%        ave_han_nv = 1.2*mean(pesq1(181:240));
%        delay_han_nv = 1.2*mean(XX_han_nv);
%        plot(1:60,ave_han_nv,'-*r');
%        title(['����Ů����:AVE-PESQ=',num2str(ave_han_nv),'����ʱ��ms��=',num2str(10*delay_han_nv)]);
%        xlabel('������%(0 2 3 5 8 10 12 15 20 25 30 40)');
%        ylabel('PESQ-MOS');
%        
%        figure(5)
%        plot(pesq1,'-*b')
%        mean_pesq = 0.25*(ave_ying_nan+ave_ying_nv+ave_han_nan+ave_han_nv);
%        mean_delay = 0.25*(delay_ying_nan+delay_ying_nv+delay_han_nan+delay_han_nv);
%        grid on
%        title(['AVE-PESQ=',num2str(mean_pesq),'����ʱ��ms��=',num2str(10*mean_delay)]);
%        xlabel('������%(0 2 3 5 8 10 12 15 20 25 30 40)');
%        ylabel('PESQ-MOS');
%       
%%
%ͳ�Ƹ��ֶ�������ƽ��ֵ
          figure(2)
          pesq_tongji=zeros(1,N);
        for j=1:t:N
            pesq_tongji(1,j)=mean(pesq1(j:j+1));
        end
        bar(pesq_tongji(1:t:N))
        grid on
        xlab=[0 2 3 5 8 10 12 15 20 25 30 40];
        xlabel('������%');
        ylabel('PESQ-MOS');
%        title(['Ӣ����������AVE-PESQ=',num2str(ave_ying_nan),'����ʱ��ms��=',num2str(10*delay_ying_nan)]);
        title(['Ӣ����shidingmabian��AVE-PESQ=',num2str(ave_ying_nan)]);
        set(gca,'xticklabel',xlab);
%%

        figure(3)
        pesq_min=zeros(2,N);
        pesq_max=zeros(1,N);
        for j =1:t:N
            pesq_min(1,j)=min(pesq1(j:j+1));
            pesq_min(2,j)=max(pesq1(j:j+1));
        end
       
        bar(pesq_min(:,1:t:N));
        %hold on
        grid on
        %bar(pesq_max(1:10:120),'r');
%         xlab=[0 2 3 5 8 10 12 15 20 25 30 40];
        xlabel('������%');
        ylabel('PESQ-MOS');
%        title(['Ӣ����������AVE-PESQ=',num2str(ave_ying_nan),'����ʱ��ms��=',num2str(10*delay_ying_nan)]);
        title('Ӣ����shidingmabian�����С');
%         set(gca,'xticklabel',xlab);

%%
     
