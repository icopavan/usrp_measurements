load('04-Dec-2014/kabel_bad.mat');
delta = mean(ps)+20;
load('04-Dec-2014/rxmeasure_16_25M.mat');

subplot(2,1,1);
plot(gains, [dBmOgain(400e6, freqs, gains, ys, wire, delta) dBmOgain(2.4e9, freqs, gains, ys, wire, delta) dBmOgain(4.4e9, freqs, gains, ys, wire, delta)]);
xlabel('gain/dB');
ylabel('dBm');
legend('400MHz', '2.4GHz', '4.4GHz');

subplot(2,1,2);
plot(freqs, [dBmOfreq(0, ys, wire, delta).' dBmOfreq(20, ys, wire, delta).' dBmOfreq(50, ys, wire, delta).'])
%hold on;
%plot(freqs, [dBmOfreq(0, ys, wire, zeros(1,81)).' dBmOfreq(20, ys, wire, zeros(1,81)).' dBmOfreq(50, ys, wire, zeros(1,81)).'])
%hold off;
xlabel('f/Hz');
ylabel('dBm');
legend('0dB', '20dB', '50dB'); 