clear all; close all; clc;

P_tan=date_indiv_SS(156)
H=[P_tan.den{1}(2) P_tan.den{1}(4) 0; P_tan.den{1}(1) P_tan.den{1}(3) 0; 0 P_tan.den{1}(2) P_tan.den{1}(4)];
disp(H);
det1=det(H(1,1));
det2=det(H(1:2,1:2));
det3=det(H);

numitor=P_tan.den{1};
poli=roots(numitor);

t=(0:0.01:180)';

h_pondere=impulse(P_tan,t);
rasp_trp=step(P_tan,t);

trp=double(t>=0);
rasp_conv=conv(trp,h_pondere)*0.01;

rasp_conv=rasp_conv(1:length(t));

norm_dif=norm(rasp_trp-rasp_conv,inf)

x0=[1 1 1];
rasp_tot=lsim(ss_ci(P_tan),trp,t,x0)

rasp_perm=trp*evalfr(P_tan,0)

rasp_tran=rasp_tot-rasp_perm

plot(rasp_perm);
plot(rasp_tran);

rasp_libr=initial(ss_ci(P_tan),x0,t)

rasp_fort=rasp_tot-rasp_libr

var=stepinfo(P_tan)
tc1=var.RiseTime
tt1=var.SettlingTime
tv1=var.PeakTime
sr1=var.Overshoot

s=tf('s');
num=[1];
den=[10 1];
P_aux=tf(num,den);
vari=stepinfo(P_tan*P_aux)
tc2=vari.RiseTime
tt2=vari.SettlingTime
tv2=vari.PeakTime
sr2=vari.Overshoot

varia=stepinfo(P_tan*(tf('s')+1));
tc3=varia.RiseTime
tt3=varia.SettlingTime
tv3=varia.PeakTime
sr3=varia.Overshoot

save('Vija_Vlad-Alexandru_324AB_tema1.mat', 'H', 'det1', 'det2',...
'det3', 'poli', 'h_pondere', 'rasp_trp', 'rasp_conv',...
'norm_dif', 'rasp_tot', 'rasp_perm', 'rasp_tran',...
'rasp_libr', 'rasp_fort', 'tc1', 'tt1', 'tv1', 'sr1',...
'tc2', 'tt2', 'tv2', 'sr2', 'tc3', 'tt3', 'tv3', 'sr3');
