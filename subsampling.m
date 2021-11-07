pkg load communications
pkg load ltfat

# subsampling from  10000 -> 833

Fs = 10000;
Ts = 1/Fs;
Fs2 = 833;
Ts2 = 1/Fs2;
L = 100000;
t = (0: L-1)*Ts;

#x=noise(length(t),"white")'; #'
x=3*cos(2*pi*3110*t)+cos(2*pi*3120*t);
#b=fir1(140,[2*290/Fs,2*310/Fs], 'pass');
#a=zeros(length(b));
#a(1)=1;
#y=filter(b,a,x);
F=fft(x);

figure(1)
h = fftshift(fft(x));
fshift = (-L/2:L/2-1)*(Fs/L);
plot(fshift,abs(h));

rx = []
nTs = Ts2;
i= 1;
for tc = t
    if tc > nTs
        nTs = nTs +Ts2;
        rx=[rx, x(i)];
    endif
    i++;
endfor
figure(3)
F2 = fftshift(fft(rx));
fshift2 = (-length(rx)/2:length(rx)/2-1)*(Fs2/length(rx));
plot(fshift2, abs(fft(rx)));