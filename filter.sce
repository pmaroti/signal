// lowpass filter synthesis

clear
clc

hz = iir(4, 'lp', 'butt', 0.1, []);		//Generate IIR Filter Transfer Function
q = poly(0, 'q');						//To express the result in terms of the delay operator q=z^-1
hzd = horner(hz, 1/q);

[lnum,lden,gf]=factors(hzd,'d');


A=roots(hzd.num);

B=1./roots(hzd.den);

b(1)=(q-A(1))*(q-A(4))
b(2)=(q-A(2))*(q-A(3))

a(1)=(q-B(1))*(q-B(2))
a(2)=(q-B(3))*(q-B(4))

g(1)=sum(coeff(a(1)))/sum(coeff(b(1)))
g(2)=sum(coeff(a(2)))/sum(coeff(b(2)))


