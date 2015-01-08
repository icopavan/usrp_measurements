load('04-Dec-2014/kabel_bad.mat');
delta = mean(ps)+20;

mkdir('data');
mkdir('data/rf');
mkdir('data/rf/rx');
mkdir('data/rf/rx/16');
mkdir('data/rf/rx/8');

wire = 16;
load('04-Dec-2014/rxmeasure_16_25M.mat');

for freq = freqs
    dlmwrite(sprintf('data/rf/rx/%d/gain_%d', wire, freq/1e6), [gains' dBmOgain(freq, freqs, gains, ys, wire, delta)], 'delimiter', '\t');
end
for gain = gains
    dlmwrite(sprintf('data/rf/rx/%d/f_%d', wire, gain), [freqs' dBmOfreq(gain, ys, wire, delta)'], 'delimiter', '\t');
end

wire = 8;
load('04-Dec-2014/rxmeasure_8_50M.mat');

for freq = freqs
    dlmwrite(sprintf('data/rf/rx/%d/dbm_%d', wire, freq/1e6), [gains' dBmOgain(freq, freqs, gains, ys, wire, delta)], 'delimiter', '\t');
end
for gain = gains
    dlmwrite(sprintf('data/rf/rx/%d/f_%d', wire, gain), [freqs' dBmOfreq(gain, ys, wire, delta)'], 'delimiter', '\t');
end

%%
% 
% xlabel('gain/dB');
% ylabel('dBm');
% 
% xlabel('f/Hz');
% ylabel('dBm');