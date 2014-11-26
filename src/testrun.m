N_samples = 50000000;
N_meas = 10;
gain = 10;

freqs = 400e6:50e6:4.4e9;

smbv = SMBV('128.131.85.232', true, -30);
smbv.pow = -30;
smbv.freq = freqs(1);
smbv.rf = 1;

y = measure(smbv, gain, freqs, N_samples, N_meas, 1e6);
errorbar(freqs, mean(y), std(y))
delete(smbv);