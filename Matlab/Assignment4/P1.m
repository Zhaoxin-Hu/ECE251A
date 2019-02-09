clc
clf
close all
clearvars

z = zeros(6,1);
z(1) = -5/2;
z(2) = -4/3;
z(3) = 3/2;
z(4) = 1/z(1);
z(5) = 1/z(2);
z(6) = 1/z(3);

expr = zeros(6,2);
for i = 1:6
    expr(i,:) = [1, -z(i)];
end

coeff = [30, 16, -18, 40, -45, -24, 12, -60];
Hmax = coeff(7)*conv(conv(expr(1,:), expr(2,:)), expr(3,:));
Hmin = coeff(8)*conv(conv(expr(4,:), expr(5,:)), expr(6,:));
H = zeros(6,4);
H(1,:) = coeff(1)*conv(conv(expr(4,:), expr(2,:)), expr(3,:));
H(2,:) = coeff(2)*conv(conv(expr(1,:), expr(5,:)), expr(3,:));
H(3,:) = coeff(3)*conv(conv(expr(1,:), expr(2,:)), expr(6,:));
H(4,:) = coeff(4)*conv(conv(expr(4,:), expr(5,:)), expr(3,:));
H(5,:) = coeff(5)*conv(conv(expr(4,:), expr(2,:)), expr(6,:));
H(6,:) = coeff(6)*conv(conv(expr(1,:), expr(5,:)), expr(6,:));

delay = zeros(6,4);
for i = 1:6
    delay(i,:) = energydelay(H(i,:));
end
delaymin= energydelay(Hmin);
delaymax= energydelay(Hmax);

function d = energydelay(x)
d = zeros(length(x),1);
for n = 1:length(x)
    for m = n:length(x)
        d(n) = d(n)+(x(m))^2;
    end
    
end
end