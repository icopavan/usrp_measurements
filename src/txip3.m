fsample = 25e6;
wire = 16;
gain = 20;
cfreq = 2e9;
N = 20;
start = -1;
stop = 0;
nsig = 50;

df = 1e6;
num = 2;

now = datestr(date);
mkdir(now);
savefile = strcat(now, '/tx_ip3.mat');

f = (-(num-1)/2 : (num-1)/2) * df;
t = (0 : 2*fsample/df-1) / fsample;
ys = zeros(nsig, length(t));
phs = zeros(nsig, 2);
for i = 1:nsig
    ph = rand(size(f)) * 2 * pi;
    [tm, phm] = meshgrid(t, ph);
    s = sum(exp(1i*(2*pi*diag(f)*tm + phm)));
    ys(i,:) = 0.5*s*(2^(wire-1)-1);
    phs(i,:) = ph;
end

delete(zvl);
zvl = ZVL('128.131.85.230');
zvl.cfreq = cfreq;
zvl.span = 5e6;
zvl.ref = -5;
zvl.rbw = 100e3;
zvl.display = 'ON';
zvl.points = 1001;
zvl.avg_cnt = 50;
zvl.m(1).enable = true;
zvl.m(1).freq = cfreq+f(1);
zvl.m(2).enable = true;
zvl.m(2).freq = cfreq+f(1);
zvl.m(3).enable = true;
zvl.m(3).freq = cfreq+f(1)-df;
zvl.m(4).enable = true;
zvl.m(4).freq = cfreq+f(2)+df;

res = zeros(nsig, N, 5);
ampls = logspace(start, stop, N);

for i = 1:N;
    tic
    for j = 1:nsig
        status = 1;
        while status ~= 0
            [m1, m2, m3, m4, status] = txm4(zvl, cfreq, gain, ys(j,:)*ampls(i), fsample, wire);
            if status ~= 0
                fprintf(1, 'Error %d!\n', status);
            end
        end
        res(j, i,:) = [ampls(i), m1, m2, m3, m4];
        fprintf(1, 'ampl: %g ph: %d, %g %g\n', ampls(i), j, m1, m3);
        save(savefile, 'res', 'num', 'df', 'cfreq', 'gain', 'ampls', 'fsample', 'wire', 'phs');
    end
    toc
end

sendmail(email, 'Messung TXIP3', 'blubb', {savefile});

delete(zvl);