clc
clf
close all
clearvars

% same as part (a)
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

c2 = 0.2147;
c0 = -0.4:0.01:-0.2;
c1 = 0.1:0.01:0.3;
[C0,C1] = meshgrid(c0,c1);
P = zeros(size(C0));
for i = 1:length(c0)
    for j = 1:length(c1)
        C = [c0(i);c1(j);c2];
        P(i,j) = Ryy+C'*Rxx*C-Ryx*C-C'*Rxy;
    end
end

% find c0 and c1 that minimize P(C)
Pmin = min(min(P));
[c0ind,c1ind] = find(Pmin);
c0opt = c0(c0ind);
c1opt = c1(c1ind);

% plot error performance surface
% surf(C0,C1,P)
% xlabel('c0')
% ylabel('c1')
% title('Error Performance Surface')