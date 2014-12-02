subplot(2,1,1);
plot(gains, [dBmOgain(400e6, freqs, gains, ys) dBmOgain(2.4e9, freqs, gains, ys) dBmOgain(4.4e9, freqs, gains, ys)]);
xlabel('gain/dB');
ylabel('dBm');
legend('400MHz', '2.4GHz', '4.4GHz');

subplot(2,1,2);
plot(freqs, [dBmOfreq(0, ys).' dBmOfreq(20, ys).' dBmOfreq(50, ys).'])
xlabel('f/Hz');
ylabel('dBm');
legend('0dB', '20dB', '50dB');