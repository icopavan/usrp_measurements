load('08-Jan-2015/tx_ip3.mat');


cable = dlmread('08-Jan-2015/kabel_txip3.s2p', '\t', 5, 0);
cable = -20*log10(abs(cable(33,6)+1j*cable(33,7)));

X = 20*log10(res(1,:,1));
La = log10(mean(10.^res(:,:,2)))+cable;
LIM3 = log10(mean(10.^res(:,:,4)))+cable;

mkdir('../tex/data');
mkdir('../tex/data/ip3');
mkdir('../tex/data/ip3/tx');
dlmwrite('../tex/data/ip3/tx/la', [X' La'], 'delimiter', '\t');
dlmwrite('../tex/data/ip3/tx/im3', [X' LIM3'], 'delimiter', '\t');

pLa = polyfit(X(3:end), La(3:end), 1)
pLIM3 = polyfit(X(3:end), LIM3(3:end), 1)

yLa = polyval(pLa, pX);
yLIM3 = polyval(pLIM3, pX);

pX = linspace(-14, 20);

[IM3x, IM3y] = polyxpoly(pX, yLa, pX, yLIM3);
dlmwrite('../tex/data/ip3/tx/pim3', [IM3x, IM3y], 'delimiter', '\t');

hold off;
plot(X,La,'x-');
hold on;
plot(X,LIM3,'*-');
plot(pX,yLa);
plot(pX,yLIM3);
plot(IM3x, IM3y, '+');