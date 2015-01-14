fsample = 25e6;
wire = 16;
gain = 31.5;
cfreq = 2e9;
df = 1e6;
Nmeas = 10;
start = -40;
stop = -21;
Nsig = 20;
N_samples = fsample;

now = datestr(date);
mkdir(now);
savefile = strcat(now, '/calrx_ip3.mat');

smiq = SMIQ('128.131.85.223', 'gpib0,27');
smiq.freq = cfreq - df/2;
smiq.pow = start;

smbv = SMIQ('128.131.85.223', 'gpib0,28');
smbv.freq = cfreq + df/2;
smbv.pow = start;

pwr = PWR('128.131.85.239');
pwr.freq = cfreq;


ressmbv = zeros(Nsig, Nmeas);
ressmiq = zeros(Nsig, Nmeas);
pows = linspace(start, stop, Nsig);


for i = 1:Nsig;
    smbv.pow = pows(i);
    smiq.pow = pows(i);
    smbv.rf = true;
    pause(1);
    for j = 1:Nmeas
        ressmbv(i, j) = pwr.pow;
        fprintf(1, 'smbv pow: %g #%d: %g\n', pows(i), j, ressmbv(i, j));
        save(savefile, 'ressmbv', 'ressmiq', 'gain', 'pows', 'cfreq', 'df');
    end
    smbv.rf = false;
    smiq.rf = true;
    pause(1);
    for j = 1:Nmeas
        ressmiq(i, j) = pwr.pow;
        fprintf(1, 'smiq pow: %g #%d: %g\n', pows(i), j, ressmiq(i, j));
        save(savefile, 'ressmbv', 'ressmiq', 'gain', 'pows', 'cfreq', 'df');
    end
    smiq.rf = false;
end

delete(smbv);
delete(smiq);
delete(pwr);