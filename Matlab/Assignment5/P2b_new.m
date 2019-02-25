clc
clf
close all
clearvars

% same as part (a)
r0 = 1.42252;
r1 = -0.8772;
r2 = 0.216;

RXX = [r0,r1,r2;r1,r0,r1;r2,r1,r0];
RYY = 0.492;
RXY = [0.708;-0.24;0];
RYX = RXY';

c0 = 0.6635;
c1 = 0.2877;
c2 = 0.0767;
var = -2:0.01:2;
varlabel = 'c_2';

P = zeros(1,length(c0));

for i = 1:length(var)    
    C = [c0;c1;var(i)];
    P(i) = RYY+C'*RXX*C-RYX*C-C'*RXY;    
end

% find c0 and c1 that minimize P(C)
% Pmin = min(min(P));
% [c0ind,c1ind] = find(Pmin);
% c0opt = c0(c0ind);
% c1opt = c1(c1ind);

% plot error performance surface
minind = find(P == min(P));
plot(var,P)
% ,'-p','MarkerIndices',[minind],...
%     'MarkerFaceColor','red',...
%     'MarkerSize',15)
text(var(minind),P(minind),['(',num2str(var(minind)),',',num2str(P(minind)),')'])
ylim([-2 inf])
xlabel([varlabel,' (C = [c_0,c_1,c_2]^T)'])
ylabel(['MSE(',varlabel,')'])
title(['Error Performance Surface (c_0 = ',num2str(c0),', c_1 = ',num2str(c1),')'])