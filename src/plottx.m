% rfinterp1
cable = sparameters('16-Dec-2014/kabel_neu.s2p');

corr = -20*log10(abs(rfparam(cable, 2, 1)));

load('16-Dec-2014/tx_50_8_0.8.mat');
powscorr = repmat(corr',8,1)+reshape(mean(pows,2),8,81);
subplot(2,1,1);
plot(rffreqs, powscorr);
title('a = 0.8');
legend(cellstr(num2str(gains', '%g')), 'Location', 'NorthWest');
xlabel('f');
ylabel('p/dBm');

load('16-Dec-2014/tx_50_8_1.0.mat');
powscorr = repmat(corr',8,1)+reshape(mean(pows,2),8,81);
subplot(2,1,2);
plot(rffreqs, powscorr);
title('a = 1');
legend(cellstr(num2str(gains', '%g')), 'Location', 'NorthWest');
xlabel('f');
ylabel('p/dBm');