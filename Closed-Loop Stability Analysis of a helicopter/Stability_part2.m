clear all; close all; clc;

P_tan=date_indiv_SS(156)

omeg=logspace(-2,2,1000)';

%nyquist(P_tan,omeg);
hold on;
[re,im]=nyquist(P_tan,omeg);
inters1=re(:,:,1);

inters2=-0.174;


%nyquist(P_tan*2,omeg);
inters3=-0.348;

%nyquist(P_tan*exp(-1i*pi/4),omeg);
inters4=-0.247;

s=tf('s');
%nyquist(P_tan*(1/s),omeg);
asimpt=-0.0909;


K_1=1013.00234;
T_1=400;
C_1=tf(K_1,[T_1 1]);
%nyquist(P_tan*C_1);
% aux=nyquist(P_tan*C_1);
% real=aux(:,:,1)

K_2=1013.00234;
T_2=800;
C_2=K_2* tf([1 1],[T_2 1]);
% nyquist(P_tan*C_2);
% nyquist(tf([-1 1], [1 1]), omeg);

t=0:0.1:100;
u=7*sin(t+pi/4);

%bode(P_tan,omeg);
[x,y,z]=bode(P_tan,1);
amp1=x*7;
def1=y+45;
%lsim(P_tan,u,t)

%bode(3*P_tan,omeg);
[x,y,z]=bode(3*P_tan,1);
amp2=x*7;
def2=y+45;

%bode(exp(-1i*pi/6)*P_tan,omeg);
[x,y,z]=bode(exp(-1i*pi/6)*P_tan,1);
amp3=x*7;
def3=y+45;

%bode(P_tan*100,omeg);
omeg_1=3.57;
omeg_2=1.87;

K_3=1013.00234;
w_3=0.2;
C_3=tf(K_3*w_3, [1 w_3]);
%bodemag(P_tan*C_3);

A_4=0.76;
B_4=4.6;
C_4=100*tf(B_4* [1 A_4],A_4*[1 B_4]);
%bode(P_tan*C_4);
save('Vija_Vlad-Alexandru_324AB_tema2.mat', 'inters1', 'inters2', ...
'inters3', 'inters4', 'asimpt', 'K_1', 'T_1', 'K_2', 'T_2', ...
'amp1', 'def1', 'amp2', 'def2', 'amp3', 'def3', 'omeg_1', ...
'omeg_2', 'K_3', 'w_3', 'A_4', 'B_4');