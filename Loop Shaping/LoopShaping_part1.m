clear all; close all; clc;


[G_tf, eps_max,w_perf,W_T] = date_indiv_TSA(192)


%1
s=tf('s');
W_S=(1/(1*eps_max))/(s/w_perf+1);


%2
omeg=logspace(-2,7,1e4);
amp=reshape(bode(W_T,omeg),1,numel(omeg));

for i=1:10000
    if amp(i)>=1
        a=i;
        break;
    end
end

w_rob=omeg(a);

%3

k=1;
for i=1:10000
    if omeg(i)<=w_perf
        w_jf(k)=omeg(i);
        k=k+1;
    end
end
k

ampS=reshape(bode(W_S,w_jf),1,numel(w_jf));
ampT=reshape(bode(W_T,w_jf),1,numel(w_jf));

for i=1:k-1
    R_jf(i)=(ampS(i)/(1-ampT(i)));
end

%4
m=1;
for i=1:10000
    if omeg(i)>=w_rob
        w_if(m)=omeg(i);
        m=m+1;
    end
end
m

ampS2=reshape(bode(W_S,w_if),1,numel(w_if));
ampT2=reshape(bode(W_T,w_if),1,numel(w_if));

for i=1:m-1
    R_if(i)=(1-ampS2(i))/ampT2(i);
end

%5
k=145;
a=250000;
b=1;
c=5;
d=800;
a2=100000;
b2=2000;
L=k*(b/a)*((s+a)/(s+b))*(d/c)*((s+c)/(s+d))*(b2/a2)*((s+a2)/(s+b2))*(1000000/(s+100000))*(1500000/(s+1500000));

amp_L=reshape(bode(L,omeg),1,numel(omeg));
semilogx(w_jf,20*log10(R_jf),'r',w_if,20*log10(R_if),'r',omeg,20*log10(amp_L),'b')

C=L/G_tf;
C=tf(ss(C,'min'))

%margin(L);


%6
T=feedback(L,1);
S=feedback(1,L);

%nyquist(T);

poli_T=pole(T)

ampS3=reshape(bode(W_S*S,omeg),1,numel(omeg));
ampT3=reshape(bode(W_T*T,omeg),1,numel(omeg));
maxS=0;
for i=1:10000
    if ampS3(i)>maxS
        maxS=ampS3(i);
    end
end
maxS

maxT=0;
for i=1:10000
    if ampT3(i)>maxT
        maxT=ampT3(i);
    end
end
maxT

maxM=0;
for i=1:10000
    if ampS3(i)+ampT3(i)>maxM
        maxM=ampS3(i)+ampT3(i);
    end
end
robperf_cost=maxM

save('tema_192.mat','W_S', 'w_rob', 'w_jf', 'R_jf', 'w_if', 'R_if', 'L', 'C' , 'poli_T', 'robperf_cost');

