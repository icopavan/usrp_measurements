N_sample = 50e6;
N_out = 10*50e6;

freqs = [-6e6 -3e6 0 3e6 6e6];
amp =   [1 1/2 1/4 1/8 1/16];

l = gcd(N_sample, min(abs(nonzeros(freqs))));
t = 0:1:l-1;

v = zeros(1,l);
for i = 1:length(freqs)
    v = v + amp(i)*exp(2i*pi*freqs(i)*t/N_sample);
end

v = v/(max(max(real(v)), max(imag(v))))*127*0.6;


process = usrp_tx(2.4e9, 20, v, 0, 50e6, 8, 1);
is = java.io.BufferedReader(java.io.InputStreamReader(process.getInputStream()));
os = java.io.OutputStreamWriter(process.getOutputStream());
pause(3);
disp('test');
os.write('\n');
os.close();
x = is.ready();
while x
    disp(is.readLine());
    x = is.ready()
end
is.close();
process.waitFor()