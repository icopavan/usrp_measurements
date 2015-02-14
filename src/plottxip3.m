load('13-Feb-2015/caltx_ip3.mat');

corr = pow2db(mean(db2pow(res(1,15,:) - gain))/2);
cable = dlmread('13-Feb-2015/kabel16_13feb.s2p', '\t', 5, 0);
cable = mag2db(abs(cable(33,6)+1j*cable(33,7)));

load('13-Feb-2015/tx_ip3.mat');
corr = corr - (res(1,15,2) - gain);

X = mag2db(0.5*res(1,:,1));
La = pow2db(mean(db2pow(res(:,:,2)- gain - corr - cable)));
LIM3 = pow2db(mean(db2pow(res(:,:,4) - gain - corr - cable)));

basedir = '../tex/data/ip3/tx/';

mkdir(basedir);

dlmwrite(sprintf('%sla', basedir), [X' La'], 'delimiter', '\t');
dlmwrite(sprintf('%sim3', basedir), [X' LIM3'], 'delimiter', '\t');

pLa = polyfit(X(1:end), La(1:end), 1)
pLIM3 = polyfit(X(12:end), LIM3(12:end), 1)

pX = linspace(-30, 20);

yLa = polyval(pLa, pX);
yLIM3 = polyval(pLIM3, pX);

[IM3x, IM3y] = polyxpoly(pX, yLa, pX, yLIM3);
dlmwrite(sprintf('%spim3', basedir), [IM3x, IM3y], 'delimiter', '\t');

hold off;
plot(X,La,'x');
hold on;
plot(X,LIM3,'*');
plot(pX,yLa);
plot(pX,yLIM3);
plot(IM3x, IM3y, '+');