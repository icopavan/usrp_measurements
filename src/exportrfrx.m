load('04-Dec-2014/kabel_bad.mat');
delta = log10(mean(10.^ps))+20;

basedir = '../tex/data/rf/rx/';

mkdir(strcat(basedir, '16'));
mkdir(strcat(basedir, '8'));

wire = 16;
load('04-Dec-2014/rxmeasure_16_25M.mat');
freqs = 400e6:50e6:4.4e9;
gains = 0:5:50;

for freq = freqs
    dlmwrite(sprintf('%s%d/gain_%d', basedir, wire, freq/1e6), [gains' dBmOgain(freq, freqs, gains, ys, wire, delta)], 'delimiter', '\t');
end
for gain = gains
    dlmwrite(sprintf('%s%d/f_%d', basedir, wire, gain), [freqs' dBmOfreq(gain, ys, wire, delta)'], 'delimiter', '\t');
end

wire = 8;
load('04-Dec-2014/rxmeasure_8_50M.mat');

for freq = freqs
    dlmwrite(sprintf('%s%d/dbm_%d', basedir, wire, freq/1e6), [gains' dBmOgain(freq, freqs, gains, ys, wire, delta)], 'delimiter', '\t');
end
for gain = gains
    dlmwrite(sprintf('%s%d/f_%d', basedir, wire, gain), [freqs' dBmOfreq(gain, ys, wire, delta)'], 'delimiter', '\t');
end
