% Zhaoxin Hu, z1hu, A53273948
clc
clf
close all
clearvars

% generate 256-sample WSS Gaussian white noise
varr = 1; % unit variance
N = 2048; % number of samples
nw = 0:1:N-1; % samples index
w = sqrt(varr)*randn(N,1);

% generate system transfer function
num = [1, -0.9, 0.81];
den = [1, -2.76, 3.809, -2.654, 0.924];
sys = filt(num, den);

% output of the system for inputs with different number of samples
x = lsim(sys, w, nw); % 256 samples

% Welch estimate, using spectrogram
L = 128; % window length
ov = 0.5; % amount of overlap
R = (1-ov)*L; % hop size
K = floor((N-L)/R+1); % number of segments to average
nfft = 1024; % fft number of points
w = hamming(L); % hamming window
U = 1/L*sum(abs(w).^2); % normalization factor
xArr = w.*x(1:L);
for n = 1:K-1
    xArr = [xArr, w.*x(n*R+1:n*R+L)];
end
S = fft(xArr, nfft);
Welch = 1/(L*U)*mean(abs(S).^2,2);
WelchdB = 10*log10(Welch);
% S = spectrogram(x, L, L*ov, L, 'yaxis'); % spectrogram of x

% plot Welch
plot(WelchdB)