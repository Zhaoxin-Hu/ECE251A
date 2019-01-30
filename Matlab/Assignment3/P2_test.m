clc
clf
close all
clearvars

% input sequence is {2, 5, 1}
N = 3;
nx = 0:1:N-1; % index of the input RP
x = [2, 5, 1]; % input

% generate system transfer function
num = [1, 1];
den = [1];
sys = filt(num, den);
[h, nh] = impz(num, den);

% compute output using two methods
[y, ny] = lsim(sys, x, nx);
yy = conv(x, h);

% plot impulse response
% stem(nh, h)
figure
stem(ny, y)
figure
stem(yy)