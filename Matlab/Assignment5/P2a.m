clc
clf
close all
clearvars

rww = [0.3];
h1 = [1,-0.8];
rss = conv(conv(rww,h1),conj(fliplr(h1)));
h2 = [1,-0.9];
ryy = conv(conv(rss,h2),conj(fliplr(h2)));
rvv = [0,0,0.1,0,0];
rxx = ryy+rvv;
Rxx = [rxx(3:end);rxx(2:4);rxx(1:3)];
Ryx = [rss(1)-0.9*rss(2),rss(2),0];
Rxy = Ryx';
Ryy = rss(2);

CoH = Ryx*inv(Rxx);
Co = CoH';
P = Ryy-Ryx*Co;
% P = rss(2)-Ryx*inv(Rxx)*Rxy;