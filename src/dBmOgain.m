function vals = dBmOgain(f, freqs, gains, ys)
    f = find(freqs==f);
    ys = reshape(mean(ys,2),11,81);
    vals = -14-gains.'+20*log10(127./ys(:,f));

end

