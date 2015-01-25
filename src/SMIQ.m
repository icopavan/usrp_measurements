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
                obj.comm.write('*RST');
            end
            if (nargin == 4)
                obj.comm.write(sprintf(':POW:LIM %f', limit));
            end
            obj.rf = false;
        end
        
        function delete(obj)
            obj.rf = false;
        end
        
        function sendCommand(obj, varargin)
            obj.comm.write(sprintf(varargin{:}));
        end
        
        function waitCommand(obj, varargin)
            obj.comm.write('*CLS');
            obj.sendCommand(varargin{:});
            obj.comm.write('*OPC')
            status = 0;
            while (status&1) == 0
                status = obj.queryDouble('*ESR?');
            end
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
            obj.waitCommand(':FREQ %f', value);
        end
        function value = get.freq(obj)
            value = obj.queryDouble(':FREQ?');
        end
        
        function set.pow(obj, p)
            obj.waitCommand(':POW %f', p);
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
            obj.waitCommand(':OUTP %s', value);
        end
        function value = get.rf(obj)
            value = obj.queryDouble(':OUTP?');
        end
    end 
end