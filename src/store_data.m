function store_data(filename, v)
    f = fopen(filename, 'wb');
    v = reshape([int8(real(v))';int8(imag(v))'], 1, []);
    fwrite(f, v, 'schar');
    fclose(f);
end

