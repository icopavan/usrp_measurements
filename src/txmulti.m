fsample = 25e6;
wire = 16;
ampl = 0.7;
gain = 10;

df = 1e6;
num = 2;

f = (-(num-1)/2 : (num-1)/2) * df;
t = (0 : 2*fsample/df-1) / fsample;
ph = rand(size(f)) * 2 * pi;

[tm, phm] = meshgrid(t, ph);

s = sum(exp(1i*(2*pi*diag(f)*tm)));
s = s./max(abs(s));

y = s*(2^(wire-1)-1)*ampl;

process = usrp_tx(2e9, gain, y, 0, fsample, wire, 1);
is = java.io.BufferedReader(java.io.InputStreamReader(process.getInputStream()));
os = java.io.OutputStreamWriter(process.getOutputStream());
pause;
os.write('\n');
os.close();
x = is.ready();
while x
    line = is.readLine();
    x = is.ready();
end
is.close();
status = process.waitFor();
if strncmp(line, 'Using', 5)
    line = '';
end
if strncmp(line, '--', 2)
    line = '';
end
status = status + length(line)
