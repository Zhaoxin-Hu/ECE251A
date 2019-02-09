% Zhaoxin Hu, z1hu, A53273948
clc
clf
close all
clearvars

% generate 1000 realizations of 1024-sample WSS Gaussian white noise
varr = 1; % unit variance
N = 2048; % number of samples
nw = 0:1:N-1; % index of the input RP
P = 2000; % number of realizations
w = zeros(N,P); % store these realizations in a matrix, each column corresponds to a realization
for i = 1:P
    w(:,i) = sqrt(varr)*randn(N,1);
end

% generate system transfer function
num = [1, -0.9, 0.81];
den = [1, -2.76, 3.809, -2.654, 0.924];
sys = filt(num, den);

% outputs of the system, using lsim
x = zeros(N,P);
for i = 1:P
    x(:,i) = lsim(sys, w(:,i), nw);
end

% compute Welch estimate
L = 1024; % window length
ov = 0.75; % amount of overlap
R = (1-ov)*L; % hop size
K = floor((N-L)/R+1); % number of segments to average
nfft = 1024; % fft number of points
w = rectwin(L); % window
U = 1/L*sum(w.^2); % normalization factor
Welch = zeros(nfft,P); % Welch array storing each Welch estimate in a column
for i = 1:P
    xArr = w.*x(1:L,i);
    for n = 1:K-1        
        xArr = [xArr, w.*x(n*R+1:n*R+L,i)];
    end
    S = fft(xArr, nfft);
    Welch(:,i) = 1/(L*U)*mean(abs(S).^2,2);
end

% compute sample mean and variance of these 1000 Welch estimates
Welchmean = mean(Welch,2);
WelchmeandB = 10*log10(Welchmean);
Welchvar = var(Welch,0,2);
WelchvardB = 10*log10(Welchvar);

% plot the sample mean and variance
figure
plot(linspace(0,2,nfft), WelchmeandB) 
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Power/frequency (dB/(rad/sample))')
title('sample mean of periodograms of 1000 realizations')
% figure
% plot(linspace(0,2,nfft), WelchvardB)
% xlabel('Normalized Frequency (\times\pi rad/sample)')
% ylabel('Power/frequency (dB/(rad/sample))')
% title('sample variance of periodograms of 1000 realizations')