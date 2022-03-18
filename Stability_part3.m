clear all; close all; clc;

[~,P_gir]=date_indiv_SS(156)

a1=3;
s=tf('s');
Q1=1/(s+1);

[X,Y,N,M]=eucl_Youla(P_gir.num{1},P_gir.den{1},a1);

C1=(X+M*Q1)/(Y-N*Q1);
C1=tf(ss(C1,'min'));

T1=(P_gir*C1)/(1+P_gir*C1);
T1=tf(ss(T1,'min'));

stepinfo(T1);
roots(T1.den{1});

%nyquist(T1);
%nyquist(P_gir*C1);

%Bez=N*X+M*Y;
%B=Bez.num{1}/Bez.den{1}


a2=5;

[X,Y,N,M]=eucl_Youla(P_gir.num{1},P_gir.den{1},a2);

func=Y/N;
evalfr(func,0);
Q2=evalfr(func,0)/(s+1)^4;

C2=(X+M*Q2)/(Y-N*Q2);
C2=tf(ss(C2,'min'));
roots(C2.den{1})



T2=(P_gir*C2)/(1+P_gir*C2);
T2=tf(ss(T2,'min'));
stepinfo(T2)
%roots(T2.den{1})
save('Vija_Vlad-Alexandru_324AB_tema3.mat','a1', 'Q1', 'a2', 'Q2');
