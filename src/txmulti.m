N_sample = 50e6;
wire = 8;
f = zeros(1, N_sample);

f(25e6) = 1;
f(30e6) = 1;
y = ifft(ifftshift(f));
y = y/(max(max(real(y)), max(imag(y))))*127*0.8;
usrp_tx(2.4e9, 9, y, N_sample*30, N_sample, wire);
