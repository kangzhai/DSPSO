function DSPSOmain()
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
%algorithm. Information Sciences, 2019, 480:109-129£¬                     %
%DOI£º10.1016/j.ins. 2018.12.030                                          %
%                                                                         %
%_________________________________________________________________________%
clc;
clear;
Num=30;
D=30;
if D==200
    N=20;MaxDT=8000;
elseif D==100
    N=20;MaxDT=5000;
else
    N=50;MaxDT=1000;D=30;
end
Vt=zeros(1,Num);
f ='Sphere';a=-100*ones(1,D);b=100*ones(1,D);

CBest=zeros(1,MaxDT);
time=0;
for i=1:Num
    tic;
    [u0,s,~] =DSPSO(f,a,b,D,MaxDT,N);
    time=((i-1)*time+toc)/i;
    CBest(1,:)=CBest(1,:)+s;
    Vt(i)=u0;
end
MeanValue=mean(Vt);
StdValue=std(Vt);
GoodValue=min(Vt);
BadValue=max(Vt);
plot(Vt)
title([' DSPSO£ºMean=',num2str(MeanValue),'£¬Std=',num2str(StdValue)]);
xlabel(['Vma=',num2str(BadValue),'£¬Vmi=',num2str(GoodValue),'£¬Time=',num2str(time)]);


function y = Sphere(x)
%Sphere function
y = sum(x.^2);

