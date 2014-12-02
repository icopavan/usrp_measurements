N_sample = 50e6;
N_out = 30*50e6;

freqs = [-6e6 -3e6 0 3e6 6e6];
amp =   [1 1/2 1/4 1/8 1/16];

l = gcd(N_sample, min(abs(nonzeros(freqs))));
t = 0:1:l-1;

v = zeros(1,l);
for i = 1:length(freqs)
    v = v + amp(i)*exp(2i*pi*freqs(i)*t/N_sample);
end

v = v/(max(max(real(v)), max(imag(v))))*127;

plotfft(v.', N_sample);

usrp_tx(2.4e9, 20, N_out, v);