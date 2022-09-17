// bandpass filter synthesis

// learning materials
// https://www.micromodeler.com/dsp/
// https://www.notblackmagic.com/bitsnpieces/digital-filters/
// https://www.dsprelated.com/showarticle/1257.php

clear
clc

fmin=0.019
fmax=0.023

hz = iir(3, 'bp', 'butt', [fmin,fmax], []);		//Generate IIR Filter Transfer Function
//fo is the center freq
fo=sqrt(fmin*fmax)   // 
q = poly(0, 'q');						//To express the result in terms of the delay operator q=z^-1
hzd = horner(hz, 1/q);

[lnum,lden,gf]=factors(hzd,'d'); // not used, following create the same


A=roots(hzd.num);

B=1./roots(hzd.den);

//making biquads
b(1)=(q-A(1))*(q-A(2))
b(2)=(q-A(3))*(q-A(4))
b(3)=(q-A(5))*(q-A(6))

a(1)=(q-B(1))*(q-B(2))
a(2)=(q-B(3))*(q-B(4))
a(3)=(q-B(5))*(q-B(6))

//create frequency response to get gain at fo
[hh1,f]=frmag((b(1)), (a(1)),1000)
[hh2,f]=frmag((b(2)), (a(2)),1000)
[hh3,f]=frmag((b(3)), (a(3)),1000)

idx = round(fo/0.4995*1000)+1

g=[ 1/hh1(idx) 1/hh2(idx) 1/hh3(idx)]

[h1,f]=frmag(g(1)*(b(1)), (a(1)),1000)
[h2,f]=frmag(g(2)*(b(2)), (a(2)),1000)
[h3,f]=frmag((g(3)*b(3)), (a(3)),1000)

h=h1.*h2.*h3

// calculate quantatized coefficients

if (max(coeff(abs(a(1))))>1) then
    aq(1,3:-1:1)=round(real(coeff(a(1))*2**14))
else 
    aq(1,3:-1:1)=round(real(coeff(a(1))*2**15))
end


if (max(coeff(abs(a(2))))>1) then
    aq(2,3:-1:1)=round(real(coeff(a(2))*2**14))
else 
    aq(2,3:-1:1)=round(real(coeff(a(2))*2**15))
end

if (max(coeff(abs(a(3))))>1) then
    aq(3,3:-1:1)=round(real(coeff(a(3))*2**14))
else 
    aq(3,3:-1:1)=round(real(coeff(a(3))*2**15))
end


if (max(coeff(abs(b(1))))>1) then
    bq(1,3:-1:1)=round(real(g(1)*coeff(b(1))*2**14))
else 
    bq(1,1:1:3)=round(real(g(1)*coeff(b(1))*2**15))
end

if (max(coeff(abs(b(2))))>1) then
    bq(2,3:-1:1)=round(real(g(2)*coeff(b(2))*2**14))
else 
    bq(2,3:-1:1)=round(real(g(2)*coeff(b(2))*2**15))
end

if (max(coeff(abs(b(3))))>1) then
    bq(3,3:-1:1)=round(real(g(3)*coeff(b(3))*2**14))
else 
    bq(3,3:-1:1)=round(real(g(3)*coeff(b(3))*2**15))
end

cq15=[
    bq(1,0+1) 0 bq(1,1+1) bq(1,2+1) aq(1,1+1)*-1 aq(1,2+1)*-1 
    bq(2,0+1) 0 bq(2,1+1) bq(2,2+1) aq(2,1+1)*-1 aq(2,2+1)*-1
    bq(3,0+1) 0 bq(3,1+1) bq(3,2+1) aq(3,1+1)*-1 aq(3,2+1)*-1    
    ]
    




