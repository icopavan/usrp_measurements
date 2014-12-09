function [pow, status] = txmeasure(pwr, rffreq, gain, v, N_sample, wire )
    process = usrp_tx(rffreq, gain, v, 0, N_sample, wire, 1);
    is = java.io.BufferedReader(java.io.InputStreamReader(process.getInputStream()));
    os = java.io.OutputStreamWriter(process.getOutputStream());
    pause(2);
    pwr.freq = rffreq;
    pow = pwr.pow;
    os.write('\n');
    os.close();
    x = is.ready();
    while x
        line = is.readLine();
        x = is.ready();
    end
    is.close();
    status = process.waitFor();
    if strncmp(line, 'Using', 5)
        line = '';
    end
    status = status + length(line);
end

