clc
clf
close all
clearvars

L = 10;
n = 0:L-1;

% hamming
%{
w = hamming(L);
w1 = 0.54-0.46*cos(2*pi/(L-1)*n);
plot(w)
hold on
plot(w1)
hold off
legend('w', 'w1')
wvtool(w)
%}

% rectangular
%{
w = rectwin(L);
w1 = ones(L);
plot(w)
hold on
plot(w1)
hold off
legend('w', 'w1')
wvtool(w)
%}