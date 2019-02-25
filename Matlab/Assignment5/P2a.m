clc
clf
close all
clearvars

r0 = 1.42252;
r1 = -0.8772;
r2 = 0.216;

RXX = [r0,r1,r2;r1,r0,r1;r2,r1,r0];
RYY = 0.492;
RXY = [0.708;-0.24;0];
RYX = RXY';

CoH = RYX*inv(RXX);
Co = inv(RXX)*RXY;
P = RYY+CoH*RXX*Co-RYX*Co-CoH*RXY;
% P = RYY-RYX*Co;
% P = rss(2)-Ryx*inv(Rxx)*Rxy;