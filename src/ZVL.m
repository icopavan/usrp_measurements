classdef ZVL < handle
    properties % (Access = protected, Hidden = true)
        comm;
        m;
    end
    
    properties (Dependent)
        cfreq;
        rbw;
        vbw;
        att;
        ref;
        span;
        points;
        display;
    end
    
    methods
        function obj = ZVL(address, preset)
            obj.comm = tcpip(address, 5025);
            set(obj.comm, 'Timeout', 120);
            fopen(obj.comm);
            if (nargin == 1) || preset
                fprintf(obj.comm, '*RST\n');
            end
            fprintf(obj.comm, 'INST:SEL SAN\n');
            fprintf(obj.comm, 'ROSC:SOUR EXT\n');
            fprintf(obj.comm, 'INIT:CONT OFF\n');
            fprintf(obj.comm, 'INIT:SCOP SING\n');
            fprintf(obj.comm, 'DISP:TRAC:MODE AVER\n');
            fprintf(obj.comm, 'SWE:COUN 10\n');
            fprintf(obj.comm, 'DET RMS\n');
            fprintf(obj.comm, 'SWE:POIN 161\n');
            obj.m = Marker(obj);
        end
        
        function delete(obj)
            fclose(obj.comm);
        end
        
        function sendCommand(obj, varargin)
            fprintf(obj.comm, varargin{:});
        end
        
        function waitCommand(obj, varargin)
            obj.sendCommand(varargin{:});
        end
        
        function value = query(obj, varargin)
            obj.sendCommand(varargin{:});
            value = fgetl(obj.comm);
        end
        
        function value = queryDouble(obj, varargin)
            value = str2double(obj.query(varargin{:}));
        end
    end
    
    methods
        function set.cfreq(obj, value)
            obj.waitCommand('FREQ:CENT %f\n', value);
        end
        function value = get.cfreq(obj)
            value = obj.queryDouble('FREQ:CENT?');
        end
        
        function set.span(obj, p)
            obj.waitCommand('FREQ:SPAN %f\n', p);
        end
        function value = get.span(obj)
            value = obj.queryDouble('FREQ:SPAN?');
        end

        function set.rbw(obj, value)
            obj.waitCommand('BWID:RES %f\n', value);
        end
        function value = get.rbw(obj)
            value = obj.queryDouble('BWID:RES?');
        end

        function set.points(obj, value)
            obj.waitCommand('SWE:POIN %d\n', value);
        end
        function value = get.points(obj)
            value = obj.queryDouble('SWE:POIN?');
        end

        function set.vbw(obj, value)
            obj.waitCommand('BAND:VID %f\n', value);
        end
        function value = get.vbw(obj)
            value = obj.queryDouble('BAND:VID?');
        end
        
        function set.att(obj, value)
            obj.waitCommand('INP:ATT %f\n', value);
        end
        function value = get.att(obj)
            value = obj.queryDouble('INP:ATT?');
        end

        function set.ref(obj, value)
            obj.waitCommand('DISP:TRAC:Y:RLEV %f\n', value);
        end
        function value = get.ref(obj)
            value = obj.queryDouble('DISP:TRAC:Y:RLEV?');
        end
        
        function set.display(obj, value)
            obj.waitCommand('SYST:SETT:UPD %s\n', value);
        end
        function value = get.display(obj)
            value = obj.query('SYST:SETT:UPD?');
        end
        
        function value = sweep(obj)
            value = obj.queryDouble('INIT; *OPC?');
        end
    end 
end