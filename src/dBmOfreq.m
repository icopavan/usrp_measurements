function vals = dBmOfreq(gain, ys)
    g = gain/5 + 1;
    ys = reshape(mean(ys,2),11,81);
    vals = -14-gain+20*log10(127./ys(g,:));

end

