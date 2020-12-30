function [Pbest,Cbest,pg] =DSPSO(f,a,b,D,MaxDT,N)
%Differential Mutation and Social learning Particle Swarm Optimization,DSPSO
%_________________________________________________________________________%
%  Differential Mutation and Social learning PSO source codes demo 1.0    %
%                                                                         %
%  Developed in MATLAB R2014b                                             %
%                                                                         %
%  Author and programmer: Xinming Zhang                                   %
%                                                                         %
%         e-Mail: xinmingzhang@126.com                                    %
%                                                                         %
%                                                                         %
%                                                                         %
%   Main paper: Zhang Xinming, Wang Xia, Kang Qiang, Cheng Jingfeng.      %
%Differential mutation and novel social learning particle optimization    %
%algorithm. Information Sciences, 2019, 480:109-129��                     %
%DOI��10.1016/j.ins. 2018.12.030                                          %
%                                                                         %
%_________________________________________________________________________%

%------������ʼ������,�����ʼ�����ӵ�λ�ú��ٶ�---------------------------
c1=2.0;             %ѧϰ����1
[x,v,aa,bb,vmax,vmin]=InitializePosVoc(a,b,N,D);
%------�ȼ���������ӵ���Ӧ�ȣ�����ʼ����ʷ����λ��y��ȫ������λ��Pg-------
p=feval(f,x);
y=x;
[Pbest,index]=min(p);
pg=x(index,:);%PgΪȫ������
Cbest=zeros(1,MaxDT);
%------������Ҫѭ��------------
for t=1:MaxDT
    wt=1-(t-1)/MaxDT;   
    w=(1-(1-0.7)*t/MaxDT);   
    [p,y,x,v,ss]=SortPop(p,y,x,v);
    for i=1:N
        if i<=3            
            x(i,:)=DiffMutation(N,i,y,w);
        else 
            v(i,:)=SMexampleVoc(i,v,x,y,ss,D,c1,wt);
            cc=v(i,:)<vmin;v(i,cc)=vmin;
            cc=v(i,:)>vmax;v(i,cc)=vmax;
            x(i,:)=x(i,:)+v(i,:);
        end        
    end
    x=ControlBound(x,aa,bb);
    fit=feval(f,x);
    for i=1:N
        value=fit(i);
        if  value< p(i)
            p(i)=value;
            y(i,:)=x(i,:);
            if value < Pbest
                pg=y(i,:);
                Pbest=value;
            end
        end
    end    
    Cbest(t)=Pbest;
end