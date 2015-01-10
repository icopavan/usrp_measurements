fsample = 25e6;
wire = 16;
ampl = 0.7;
gain = 20;
cfreq = 2e9;
N = 10;
start = 0.2;
stop = 1;
nsig = 100;

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
zvl = ZVL('128.131.85.229');
zvl.cfreq = cfreq;
zvl.span = 5e6;
zvl.ref = 0;
zvl.rbw = 1e3;
zvl.vbw = 3e3;
zvl.att = 20;
zvl.display = 'ON';
zvl.m(1).enable = true;
zvl.m(1).freq = cfreq+f(1);
zvl.m(2).enable = true;
zvl.m(2).freq = cfreq+f(1);
zvl.m(3).enable = true;
zvl.m(3).freq = cfreq+f(1)-df;
zvl.m(4).enable = true;
zvl.m(4).freq = cfreq+f(2)+df;

res = zeros(nsig, N, 5);
ampls = linspace(start, stop, N);

for i = 1:N;
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
end

sendmail(email, 'Messung IP3', 'blubb', {savefile});

delete(zvl);