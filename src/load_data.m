function v = load_data(filename, count, wire)
    switch wire
        case 8
            wire = 'int8';
        case 16
            wire = 'int16';
    end
    f = fopen(filename, 'rb');
    t = fread(f, [2, count], wire);
    v = t(1,:) + t(2,:)*1i;
    [r, c] = size(v);
    v = reshape(v, c, r);
    fclose(f);
end

