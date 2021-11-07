pkg load communications
Fs = 1000;
Ts = 1/Fs;
L = 1500;
t = (0: L-1)*Ts;

fFm = 100;
fSig = 10;

x = cos (2 * pi * fSig * t) ;  

## Frequency Deviation
fDev = 5;

## Frequency modulate x
y = fmmod (x, fFm, Fs, fDev);

O= fft(y);

P2 = abs(O/L);
f2 = Fs*(0:(L-1))/L;


plot(f2,P2)
title('Spectrum of X(t)')
xlabel('f (Hz)');
ylabel('|P2(f)|');

iq = cos(2*pi*fFm*t).*y + i*sin(2*pi*fFm*t).*y;

b=fir1(40, 2*fFm /Fs);
a=zeros(length(b));
a(1)=1;

mi = filter(b,a,iq);

norm = arrayfun(@(k) k/abs(k),mi);

dm1 = arrayfun(@(idx) imag(norm(idx)) * real(norm(idx-1)) - real(norm(idx)) * imag(norm(idx-1))  , 2:length(norm));
dm2 = arrayfun(@(idx) real(norm(idx)) * real(norm(idx-1)) - imag(norm(idx)) * imag(norm(idx-1))  , 2:length(norm));
demod1 =  Fs/fDev .* asin(dm1);
demod2 =  Fs/fDev .* acos(dm1);

figure(3)
plot(demod1(45:end)) 
title('Demod')
xlabel('time')
ylabel('amplitude')
