clc
clf
close all
clearvars

% autocorr
M = 4;
r = [1,0.8,0.6,0.4,0.3];
r = [fliplr(r(2:end)),r];

% FLP
Rff = [];
rf = [];
for i = 0:-1:-(M-1)
    Rff = [Rff;r(M+i+1:M+i+4)];
    rf = [rf;r(M+i)];
end
Cf = -inv(Rff)*rf;
PMf = r(M+1)+rf'*Cf;

% BLP
Rbb = [];
rb = [];
for i = 0:-1:-(M-1)
    Rbb = [Rbb;r(M+i+1:M+i+4)];
    rb = [rb;r(end+i)];
end
Cb = -inv(Rbb)*rb;
PMb = r(M+1)+rb'*Cb;