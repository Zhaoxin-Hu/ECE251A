clc
clf
close all
% clearvars
importfile('Sample.wav')

%% (1)
M = 256;
R = 128;
L = length(data);
nframes = floor((L-M)/R+1); % floor((L-M)/R+1);
nfft = floor(M/2+1);
w = hamming(M);
dd = w.*data(1:M);
for n = 1:nframes-1
    dd = [dd, w.*data(n*R+1:n*R+M)];
end
fft1 = fft(dd);
fft1 = fft1(1:nfft,:);
tf1 = isequal(fft1, s1)

%% (2)
M = 1024;
R = 512;
L = length(data);
nframes = floor((L-M)/R+1); % floor((L-M)/R+1);
nfft = floor(M/2+1);
w = hamming(M);
dd = w.*data(1:M);
for n = 1:nframes-1
    dd = [dd, w.*data(n*R+1:n*R+M)];
end
fft2 = fft(dd);
fft2 = fft2(1:nfft,:);
tf2 = isequal(fft2, s2)

%% (3)
M = 4096;
R = 2048;
L = length(data);
nframes = floor((L-M)/R+1); % floor((L-M)/R+1);
nfft = floor(M/2+1);
w = hamming(M);
dd = w.*data(1:M);
for n = 1:nframes-1
    dd = [dd, w.*data(n*R+1:n*R+M)];
end
fft3 = fft(dd);
fft3 = fft3(1:nfft,:);
tf3 = isequal(fft3, s3);