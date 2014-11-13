function v = load_data(filename, count)
    f = fopen(filename, 'rb');
    t = fread(f, [2, count], 'schar');
    v = t(1,:) + t(2,:)*1i;
    [r, c] = size(v);
    v = reshape(v, c, r);
    fclose(f);
end

