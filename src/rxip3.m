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
savefile = strcat(now, '/rx_ip3.mat');

smiq = SMIQ('128.131.85.223', 'gpib0,27');
smiq.freq = cfreq - df/2;
smiq.pow = start;

smbv = SMBV('128.131.85.232');
smbv.freq = cfreq + df/2;
smbv.pow = start;


res = zeros(Nsig, Nmeas, 4);
pows = linspace(start, stop, Nsig);


smbv.rf = true;
smiq.rf = true;

for i = 1:Nsig;
    smbv.pow = pows(i);
    smiq.pow = pows(i);
    pause(2);
    for j = 1:Nmeas
        status = 1;
        while status ~= 0
            [m1, m2, m3, m4, status] = rxm4(cfreq, gain, fsample, N_samples, wire, df);
            if status ~= 0
                fprintf(1, 'Error %d!\n', status);
            end
        end
        res(i, j,:) = [m1, m2, m3, m4];
        fprintf(1, 'pow: %g #: %d, %g %g\n', pows(i), j, m1, m3);
        save(savefile, 'res', 'gain', 'pows', 'fsample', 'wire', 'cfreq', 'df');
    end
end

smbv.rf = false;
smiq.rf = false;

sendmail(email, 'Messung IP3', 'blubb', {savefile});


delete(smbv);
delete(smiq);