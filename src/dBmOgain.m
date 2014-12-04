function vals = dBmOgain(f, freqs, gains, ys, wire, delta)
    switch wire
        case 8
            m = 127;
        case 16
            m = 32767;
    end
        
    f = find(freqs==f);
    ys = reshape(mean(ys,2),11,81);
    vals = -14-gains.'+20*log10(m./ys(:,f))-delta(f);

end

