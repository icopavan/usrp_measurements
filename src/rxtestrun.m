samp_rate = 25e6;
N_samples = 50e6;
wire = 16;
N_meas = 10;
savefile = sprintf('rxmeasure_%d_%dM.mat', wire, samp_rate/1e6);
%-14dbm
freqs = 400e6:50e6:4.4e9;
gains = 0:5:50;

smbv = SMBV('128.131.85.232', true, -14);
smbv.pow = -14;
smbv.freq = freqs(1);

ps = zeros(length(gains), N_meas, length(freqs));
ys = zeros(length(gains), N_meas, length(freqs));

for i = 1:length(gains)
    gain = gains(i);
    smbv.pow = -14 -gain;
    fprintf(1, '---------------------\n');
    fprintf(1, 'gain %d\n', gain); 
    fprintf(1, '=====================\n');
    tic
        [p, y] = measure(smbv, gain, freqs, N_samples, N_meas, 1e6, samp_rate, wire);
    toc
    ps(i,:,:) = p;
    ys(i,:,:) = y;
    save(savefile, 'ps', 'ys');
end

plotrx;

delete(smbv);