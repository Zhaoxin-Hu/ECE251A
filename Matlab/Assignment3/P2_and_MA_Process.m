clc
clf
close all
clearvars

% generate 1024 samples of WSS Gaussian RP with variance 1
var = 1;
N = 1024;
nw = 0:1:N-1; % index of the input RP
w = var*rand(N,1); % input RP
ww = flipud(w);

% generate system transfer function
num = [1, -0.9, 0.81];
den = [1];
sys = filt(num, den);
[h, nh] = impz(num, den);
hh = flipud(h);

% output of the system to input, using lsim
[x, nx] = lsim(sys, w, nw);
xx = flipud(x);

% true autocorr
rHatx = conv(h, flipud(h));

% estimated autocorr of w and x, using convolution
rHatww = 1/N*conv(w, ww);
rHatxx = 1/N*conv(x, xx);

% plot
figure
stem(rHatxx(1022:1026)) 
figure
stem(nh, h)
figure
stem(rHatx)
