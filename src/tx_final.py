#!/usr/bin/env python
##################################################
# Gnuradio Python Flow Graph
# Title: TX Block for measurements
# Author: Gernot Vormayr
# Generated: Wed Dec  3 11:57:54 2014
##################################################

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import uhd
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser
import time

class tx(gr.top_block):

    def __init__(self, freq=2.4e9, gain=0, filename="", samples=1000000, samp_rate=50e6, wire=8):
        gr.top_block.__init__(self, "TX Block for measurements")
        if wire == 8:
            otw_format = "sc8"
            bs = gr.sizeof_char*2
        elif wire == 16:
            otw_format = "sc16"
            bs = gr.sizeof_short*2

        ##################################################
        # Blocks
        ##################################################
        self.uhd_usrp_sink_0 = uhd.usrp_sink(
        	device_addr="addr=192.168.10.2",
        	stream_args=uhd.stream_args(
        		cpu_format="sc16",
        		otw_format=otw_format,
        		channels=range(1),
        	),
        )
        self.uhd_usrp_sink_0.set_clock_source("external", 0)
        self.uhd_usrp_sink_0.set_samp_rate(samp_rate)
        self.uhd_usrp_sink_0.set_center_freq(freq, 0)
        self.uhd_usrp_sink_0.set_gain(gain, 0)
        if samples != 0:
            self.blocks_head_0 = blocks.head(bs, samples)
        self.blocks_file_source_0 = blocks.file_source(bs, filename, True)
        if wire == 8:
            self.blocks_char_to_short_0 = blocks.char_to_short(2)

        ##################################################
        # Connections
        ##################################################
        if wire == 8:
            self.connect((self.blocks_char_to_short_0, 0), (self.uhd_usrp_sink_0, 0))
            if samples == 0:
                self.connect((self.blocks_file_source_0, 0), (self.blocks_char_to_short_0, 0))
            else:
                self.connect((self.blocks_head_0, 0), (self.blocks_char_to_short_0, 0))
                self.connect((self.blocks_file_source_0, 0), (self.blocks_head_0, 0))
        elif wire == 16:
            if samples == 0:
                self.connect((self.blocks_file_source_0, 0), (self.uhd_usrp_sink_0, 0))
            else:
                self.connect((self.blocks_head_0, 0), (self.uhd_usrp_sink_0, 0))
                self.connect((self.blocks_file_source_0, 0), (self.blocks_head_0, 0))

if __name__ == '__main__':
    parser = OptionParser(option_class=eng_option, usage="%prog: [options]")
    parser.add_option("", "--freq", dest="freq", type="eng_float", default=eng_notation.num_to_str(2.4e9),
        help="Set freq [default=%default]")
    parser.add_option("", "--gain", dest="gain", type="eng_float", default=eng_notation.num_to_str(0),
        help="Set gain [default=%default]")
    parser.add_option("", "--filename", dest="filename", type="string", default="",
        help="Set filename [default=%default]")
    parser.add_option("", "--samples", dest="samples", type="intx", default=1000000,
        help="Set samples [default=%default]")
    parser.add_option("", "--samp-rate", dest="samp_rate", type="eng_float", default=eng_notation.num_to_str(50e6),
        help="Set samp_rate [default=%default]")
    parser.add_option("", "--wire", dest="wire", type="intx", default=8,
        help="Set wire [default=%default]")
    (options, args) = parser.parse_args()
    if gr.enable_realtime_scheduling() != gr.RT_OK:
        print "Error: failed to enable realtime scheduling."
    tb = tx(freq=options.freq, gain=options.gain, filename=options.filename, samples=options.samples, samp_rate=options.samp_rate, wire=options.wire)
    tb.start()
    if options.samples == 0:
        raw_input() 
        tb.stop()
    tb.wait()

