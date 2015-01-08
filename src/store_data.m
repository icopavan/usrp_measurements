function store_data(filename, v, wire)
    switch wire
        case 8
            wire = 'int8';
            v = reshape([int8(real(v));int8(imag(v))], 1, []);
        case 16
            wire = 'int16';
            v = reshape([int16(real(v));int16(imag(v))], 1, []);
    end
    f = fopen(filename, 'wb');
    fwrite(f, v, wire);
    fclose(f);
end

