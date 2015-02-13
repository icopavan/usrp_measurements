fsample = 25e6;
wire = 16;
gain = 10;
cfreq = 2e9;
N = 20;
start = -1;
stop = 0;
nsig = 50;
Nmeas = 5;

df = 1e6;
num = 2;

now = datestr(date);
mkdir(now);
savefile = strcat(now, '/caltx_ip3.mat');

load('13-Feb-2015/tx_ip3.mat', 'phs');

f = (-(num-1)/2 : (num-1)/2) * df;
t = (0 : 2*fsample/df-1) / fsample;
ys = zeros(nsig, length(t));
for i = 1:nsig
    ph = phs(i,:);
    [tm, phm] = meshgrid(t, ph);
    s = sum(exp(1i*(2*pi*diag(f)*tm + phm)));
    ys(i,:) = 0.5*s*(2^(wire-1)-1);
end

res = zeros(nsig, N, Nmeas);
ampls = logspace(start, stop, N);

pwr = PWR('128.131.85.239');
pwr.freq = cfreq;

i = 15;
    for j = 1:nsig
        for k = 1:Nmeas;
            status = 1;
            while status ~= 0
                [pow, status] = caltxm4(pwr, cfreq, gain, ys(j,:)*ampls(i), fsample, wire);
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            res(j, i, k) = pow;
            fprintf(1, 'ampl: %g ph: %d #%d, %g\n', ampls(i), j, k, pow);
            save(savefile, 'res', 'num', 'df', 'cfreq', 'gain', 'ampls', 'fsample', 'wire', 'phs');
        end
    end
    sendmail(email, sprintf('Messung cal tx IP3 %d', i), 'blubb', {savefile});

sendmail(email, 'Messung cal tx IP3 DONE', 'blubb', {savefile});

delete(pwr);