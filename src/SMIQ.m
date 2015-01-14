classdef SMIQ < handle
    properties % (Access = protected, Hidden = true)
        comm;
    end
    
    properties (Dependent)
        freq;
        pow;
        rf;
    end
    
    methods
        function obj = SMIQ(addressa, addressb, preset, limit)
            import py.vxi11.Instrument;
            obj.comm = Instrument(addressa, addressb);
            if (nargin == 2) || preset
                obj.comm.write('*RST\n');
            end
            if (nargin == 4)
                obj.comm.write(sprintf(':POW:LIM %f\n', limit));
            end
            obj.comm.write('*ESE 1\n');
            obj.rf = false;
        end
        
        function delete(obj)
            obj.rf = false;
        end
        
        function waitComplete(obj)
            status = 0;
%            while status ~= 1
                status = str2double(char(obj.comm.ask('*OPC;*ESR?')));
%            end
        end
        
        function sendCommand(obj, varargin)
            obj.comm.write(sprintf(varargin{:}));
        end
        
        function waitCommand(obj, varargin)
            obj.sendCommand(varargin{:});
            obj.waitComplete();
        end
        
        function value = query(obj, varargin)
            value = char(obj.comm.ask(sprintf(varargin{:})));
        end
        
        function value = queryDouble(obj, varargin)
            value = str2double(obj.query(varargin{:}));
        end
    end
    
    methods
        function set.freq(obj, value)
            obj.waitCommand(':FREQ %f\n', value);
        end
        function value = get.freq(obj)
            value = obj.queryDouble(':FREQ?');
        end
        
        function set.pow(obj, p)
            obj.waitCommand(':POW %f\n', p);
        end
        function value = get.pow(obj)
            value = obj.queryDouble(':POW?');
        end
    
        function set.rf(obj, value)
            if value
                value = 'ON';
            else
                value = 'OFF';
            end
            obj.waitCommand(':OUTP %s\n', value);
        end
        function value = get.rf(obj)
            value = obj.queryDouble(':OUTP?');
        end
    end 
end