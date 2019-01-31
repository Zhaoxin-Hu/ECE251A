clc
clf
close all
clearvars

% generate 1024 samples of WSS Gaussian RP with variance 1
var = 1;
N = 1024;
nw = 0:1:N-1;
w = var*rand(N,1);
ww = fliplr(w);

% generate system transfer function
num = [1, -0.9, 0.81];
den = [1, -2.76, 3.809, -2.654, 0.924];
sys = filt(num, den);
% [impResp, n] = impulse(sys);

% generate system H~

% output of the system to input
[x, nx] = lsim(sys, w, nw);
xx = fliplr(x);

% estimated autocorr of w and x
rHatww = 1/N*conv(w, ww);
rHatxx = 1/N*conv(x, xx);

% frequency reponse of the filter
[freqResp, wsys] = freqz(num, den, 1e3);
freqRespdB = 20*log10(abs(freqResp));
freqRespdBNorm = freqRespdB - max(freqRespdB);

% periodogram of w and x
[pww, omegaw] = periodogram(w);
[pxx, omegax] = periodogram(x);
RHatww = 1/(2*pi*N)*abs(fft(w)).^2;
RHatxx = 1/(2*pi*N)*abs(fft(x)).^2;

% plot estimated autocorr
% plot(rHatww)
% hold on
% plot(rHatxx)
% hold off
% legend('\hat{r}_ww', '\hat{r}_xx')

% plot frequency response of the filter
% plot(wsys/pi,freqRespdB)
% ax = gca;
% ax.YLim = [-100 20];
% ax.XTick = 0:.5:2;
% xlabel('Normalized Frequency (\times\pi rad/sample)')
% ylabel('Magnitude (dB)')

% plot periodogram
% figure
% periodogram(w)
% figure
% periodogram(x)
% figure
% plot(RHatww)
% figure
% plot(RHatxx)
% legend('\hat{R}_ww', '\hat{R}_xx')