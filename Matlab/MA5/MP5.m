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

%% computation
% compute autocorrelation of v2
r_v2 = 1/N*ifft(fft(v2,2*N).*conj(fft(v2,2*N)));
% compute cross correlation between v2 and x
r_v2x = 1/N*ifft(fft(v2,2*N).*conj(fft(x,2*N)));
r_xv2 = 1/N*ifft(fft(x,2*N).*conj(fft(v2,2*N)));
% compute periodogram of v2
per_v2 = 1/N*fft(v2).*conj(fft(v2));
per_v2_dB = 10*log10(abs(per_v2));
% compute Welch of v2
L = 128; % window length
ov = 0.5; % amount of overlap
R = (1-ov)*L; % hop size
K = floor((N-L)/R+1); % number of segments to average
nfft = 1024; % fft number of points
w = hamming(L); % hamming window
U = 1/L*sum(abs(w).^2); % normalization factor
v2_Arr = w.*v2(1:L);
for n = 1:K-1
    v2_Arr = [v2_Arr, w.*v2(n*R+1:n*R+L)];
end
S_v2 = fft(v2_Arr, nfft);
Welch_v2 = 1/(L*U)*mean(abs(S_v2).^2,2);
Welch_v2_dB = 10*log10(abs(Welch_v2));
% compute AR model of v2, and PSD estimate of v2 based on AR model
M = 13; % AR model of order M
[am,em,km] = levinson(r_v2(1:M+1),M);
[freq_resp,wsys] = freqz(sqrt(em),am,linspace(0,2*pi,1000));
PSD_est_v2_dB = 20*log10(abs(freq_resp));

%% building predictor
M = 13; % predictor of size M
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

%% plotting
% plot spectrogram
% figure
% spectrogram(v1_hat, 4096, 4096-2048, 4096, 'yaxis')
% figure
% spectrogram(v2, 4096, 4096-2048, 4096, 'yaxis')
% figure
% spectrogram(s_hat, 4096, 4096-2048, 4096, 'yaxis')

% plot periodogram of v2
figure
plot(linspace(0,2,N), per_v2_dB)
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Power/frequency (dB/(rad/sample))')
title('Periodogram of v_2')

% plot Welch of v2
figure
plot(linspace(0,2,nfft), Welch_v2_dB) 
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Power/frequency (dB/(rad/sample))')
title('Welch of v_2')

% plot estimated PSD of v2 based on AR model
figure
plot(linspace(0,2,1000), PSD_est_v2_dB) 
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Power/frequency (dB/(rad/sample))')
title('Estimated PSD of v_2 based on AR model')
