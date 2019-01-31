clc
clf
close all
clearvars

% generate system transfer function
num = [1, -0.9, 0.81];
den = [1, -2.76, 3.809, -2.654, 0.924];
sys = filt(num, den);
% [impResp, n] = impulse(sys);

% frequency reponse of the filter, and the PSD of the output RP
[freqResp, wsys] = freqz(num, den, 1e3);
freqRespdB = 20*log10(abs(freqResp));
freqRespdBNorm = freqRespdB - max(freqRespdB);

% plot frequency response of the filter
plot(wsys/pi,freqRespdBNorm)
ax = gca;
% ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')