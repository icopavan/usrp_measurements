N_sample = 50e6;
N_meas = 10;
wire = 8;
rffreqs = 400e6:50e6:4.4e9;
ampl = 0.8;
gains = 0:5:30;
gains(end+1) = 31.5;

now = datestr(date);
mkdir(now);


pwr = PWR('128.131.85.239');

ampl = 0.8;

savefile = strcat(now, sprintf('/tx_%d_%d_%1.1f.mat', N_sample/1e6, wire, ampl));
pows = txmeasuresweep(gains, rffreqs, ampl, N_meas, N_sample, wire, pwr, savefile);
sendmail(email, 'Messung 0.8 ist fertig', 'blubb', {savefile});

ampl = 1;

savefile = strcat(now, sprintf('/tx_%d_%d_%1.1f.mat', N_sample/1e6, wire, ampl));
pows = txmeasuresweep(gains, rffreqs, ampl, N_meas, N_sample, wire, pwr, savefile);
sendmail(email, 'Messung  1 ist fertig', 'blubb', {savefile});

delete(pwr);

