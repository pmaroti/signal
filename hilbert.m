pkg load communications
pkg load signal

Fs = 1000;
Ts = 1/Fs;
L = 1500;
t = (0: L-1)*Ts;

fSig = 10;
x = cos (2 * pi * fSig * t) ; 

b=[-1/7, 0, -1/5, 0, -1/3, 0, -1, 0, 1, 0, 1/3, 0, 1/5, 0, 1/7];
cntr=0;
oi=[];
oq=[];
dl=zeros(15,1)'; #'
for s = x
    dl=shift(dl,1);
    dl(1)=s;
    oi=[oi,dl(7)];
    oq=[oq,2*b*dl']; #'
endfor

plot(oi);
hold on;
plot(oq);
