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
den = [1, -2.76, 3.809, -2.654, 0.924];
sys = filt(num, den);

% output of the system to input
[x, nx] = lsim(sys, w, nw);
xx = flipud(x);

% estimated autocorr of w and x, using definition
rHatw = zeros(N, 1);
rHatx = zeros(N, 1);
for m = 1:N
    for n = 1:N-m+1
        rHatw(m) = rHatw(m)+w(n+m-1)*w(n);
        rHatx(m) = rHatx(m)+x(n+m-1)*x(n);
    end
end
rHatwflip = flipud(rHatw);
rHatxflip = flipud(rHatx);
rHatw = [rHatwflip(1:end-1); rHatw]/N;
rHatx = [rHatxflip(1:end-1); rHatx]/N;

% estimated autocorr of w and x, using convolution
rHatww = 1/N*conv(w, ww);
rHatxx = 1/N*conv(x, xx);

% plot
% plot(nw, w)
% plot(nx, x)
% stem(nx, x)
plot(rHatx)
figure
plot(rHatxx)