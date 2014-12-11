% rfinterp1
cable = sparameters('09-Dec-2014/cable_6db_10db.s2p');
cable0 = sparameters('11-Dec-2014/cable_0db.s2p');


corr = -20*log10(abs(rfparam(cable, 2, 1)));
corr0 = -20*log10(abs(rfparam(cable0, 2, 1)));

load('09-Dec-2014/tx_50_8_0.8.mat');
powscorr = repmat(corr',8,1)+reshape(mean(pows,2),8,81);
load('11-Dec-2014/tx0_50_8_0.8.mat');
powscorr(1,:) = corr0'+mean(pows);
subplot(2,1,1);
plot(rffreqs, powscorr);
title('a = 0.8');
legend(cellstr(num2str(gains', '%g')), 'Location', 'NorthWest');
xlabel('f');
ylabel('p/dBm');

load('10-Dec-2014/tx_50_8_1.0.mat');
powscorr = repmat(corr',8,1)+reshape(mean(pows,2),8,81);
load('11-Dec-2014/tx0_50_8_1.0.mat');
powscorr(1,:) = corr0'+mean(pows);
subplot(2,1,2);
plot(rffreqs, powscorr);
title('a = 1');
legend(cellstr(num2str(gains', '%g')), 'Location', 'NorthWest');
xlabel('f');
ylabel('p/dBm');