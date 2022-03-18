clc ; close all ; clear all

[~,~,~,~,G_ss]=date_indiv_TSA(192);

%1
Q = obsv(G_ss.A,G_ss.C);
rank(Q);

Q_tran = Q.';

r=rank(Q_tran);

B_o = Q_tran(:,[1,2,3,7])

%class(B_o)
rank(B_o);

%2
for i=1:6
    obsv_vec(i)=norm(Q(:,i));
end

obsv_vec

ord_o=[6 2 1 3 4 5];

%3
G_trans_1=ss(G_ss,'min');
G_trans_2=balreal(G_trans_1);
G_ech=diag([1 1/1600])*G_trans_2;

[ ~,m] =size(G_ech.B);
[p,n]=size(G_ech.C);


lam_cmd_stb=[-2.9 -3.5 -5 -6];
lam_est_stb=lam_cmd_stb*10;

F = -place(G_ech.A,G_ech.B,lam_cmd_stb');
L = -place(G_ech.A' ,G_ech.C',lam_est_stb)';

K_stb=ss([G_ech.A+L*G_ech.C+G_ech.B*F+L*G_ech.D*F],-L,F, zeros(m,p));
T_stb=feedback(G_ech,K_stb,1);
stepi1=stepinfo(T_stb(1,1)+T_stb(1,2));
stepi2=stepinfo(T_stb(2,1)+T_stb(2,2));


T1=stepi1.SettlingTime
T2=stepi2.SettlingTime


%4
intg=tf(1,[1 0]*eye(2));
G_aug=-series(G_ech,intg);

[ ~,m2] =size(G_aug.B);
[p2,n2]=size(G_aug.C);

rank([-G_ech.A -G_ech.B; G_ech.C G_ech.D])

lam_cmd_stb2=[-0.44 -1.12 -2 -5 -6 -7];
lam_est_stb2=lam_cmd_stb2*10;

F2 = -place(G_aug.A,G_aug.B,lam_cmd_stb2');
L2 = -place(G_aug.A' ,G_aug.C',lam_est_stb2)';

K_hat=ss([G_aug.A+L2*G_aug.C+G_aug.B*F2+L2*G_aug.D*F2],-L2,F2,0);
K_reg=series(intg,K_hat);
ser=series(K_reg, G_ech);
T_reg=feedback(ser,eye(2));
stepin1=stepinfo(T_reg(1,1)+T_reg(1,2));
stepin2=stepinfo(T_reg(2,1)+T_reg(2,2));

T12=stepin1.SettlingTime
T22=stepin2.SettlingTime
 
S1=stepin1.Overshoot
S2=stepin2.Overshoot

% stepplot(T_reg(1,1)+T_reg(1,2));
% figure();
% stepplot(T_reg(2,1)+T_reg(2,2));

save('tema_192.mat', 'B_o', 'obsv_vec', 'ord_o', ...
'K_stb', 'K_reg');

