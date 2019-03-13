% Zhaoxin Hu, z1hu, A53273948
clc
clf
close all
clearvars

% import files
importfile('x.wav')
x = data;
clearvars data
importfile('v2.wav')
v2 = data;
clearvars data
N = length(x);

% compute autocorrelation of v2
r_v2 = ifft(fft(v2,2*N).*conj(fft(v2,2*N)));
% compute cross correlation between v2 and x
r_v2x = ifft(fft(v2,2*N).*conj(fft(x,2*N)));
r_xv2 = ifft(fft(x,2*N).*conj(fft(v2,2*N)));
% compute estimated PSD of v2
R_v2 = 1/N*fft(v2,2*N).*conj(fft(v2,2*N));
R_v2_dB = 10*log10(real(R_v2));

% predictor of size M
M = 13;
r_v2m = r_v2(1:M);
Rm = toeplitz(r_v2m);
dm = [r_v2x(1);r_v2x(end:-1:end-M+2)];
dmH = r_xv2(1:M).';
cm = inv(Rm)*dm;
cmH = dmH*inv(Rm);
v1_hat = zeros(N-M+1,1);
for n = M:N
    v1_hat(n-M+1) = cmH*v2(n:-1:n-M+1);
end
% v1_hat = filter(cmH,1,v2);
s_hat = x(M:N)-v1_hat;
% s_hat = x-v1_hat;
% soundsc(s_hat,fs)
% figure
% spectrogram(v1_hat, 4096, 4096-2048, 4096, 'yaxis')
% figure
% spectrogram(v2, 4096, 4096-2048, 4096, 'yaxis')
% figure
% spectrogram(s_hat, 4096, 4096-2048, 4096, 'yaxis')
[freqResp, wsys] = freqz(cmH, 1, 1e3);
freqRespdB = 20*log10(abs(freqResp));
% freqRespdBNorm = freqRespdB - max(freqRespdB);
figure
plot(R_v2_dB)
figure
plot(wsys/pi,freqRespdB)