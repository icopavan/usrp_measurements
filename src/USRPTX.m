classdef USRPTX < handle
    
    properties(SetAccess = 'private', GetAccess = 'private', Transient)
        process;
        os;
        is;
    end

    methods
        function h = USRPTX(frequency, gain, v, samp_rate, wire)
            h.process = usrp_tx(frequency, gain, v, 0, samp_rate, wire, 1);
            h.is = java.io.BufferedReader(java.io.InputStreamReader(h.process.getInputStream()));
            h.os = java.io.OutputStreamWriter(h.process.getOutputStream());
        end
        
        function status = stop(h)
            h.os.write('\n');
            h.os.close();
            x = h.is.ready();
            while x
                line = h.is.readLine();
                x = h.is.ready();
            end
            h.is.close();
            status = h.process.waitFor();
            if strncmp(line, 'Using', 5)
                line = '';
            end
            if strncmp(line, '--', 2)
                line = '';
            end
            status = status + length(line);
        end
        
        function delete(h)
            try
                h.stop();
            catch E
            end
        end
    end
    
end

