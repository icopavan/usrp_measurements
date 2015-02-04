MATLAB & GNU Radio sources
==========================

Instrument control
------------------

File(s) | Purpose
------- | -------
[Marker.m](Marker.m) [ZVL.m](ZVL) | Class for controlling Rhode & Schwarz ZVL via tcp socket
[PWR.m](PWR.m) | Class for controlling Agilent N1914A via tcp socket
[SMBV.m](SMBV.m) | Class for controlling Rhode & Schwarz SMBV100A via tcp socket
[SMIQ.m](SMIQ.m) | Class for controlling Rhode & Schwarz SMIQ06B via Agilent E85810 GPIB Gateway via VXI-11

USRP conrol
-----------

File(s) | Purpose
------- | -------
[usrp_rx.m](usrp_rx.m) [load_data.m](load_data.m) [rx.grc](rx.grc) [rx_final.py](rx_final.py) | Receive samples from USRP
[USRPTX.m](USRPTX.m) [usrp_tx.m](usrp_tx.m) [store_data.m](store_data.m) [tx.grc](tx.grc) [tx_final.py](tx_final.py) | Send samples to USRP
[rxtx.grc](rxtx.grc) | Send/Receive at the same time

Measurement Scripts
-------------------

Files(s) | Purpose
-------- | -------
[rxtestrun.m](rxtestrun.m) [rxmeasure.m](rxmeasure.m) [exportrfrx.m](exportrfrx.m) [dBmOfreq.m](dBmOfreq.m) [dBmOgain.m](dBmOgain.m) | RX RF measurement script
[txtestrun.m](txtestrun.m) [txmeasure.m](txmeasure.m) [txmeasuresweep.m](txmeasuresweep.m) [exportrftx.m](exportrftx.m) | TX RF measurement script
[rxifmeasure.m](rxifmeasure.m) [rxifsingle.m](rxifsingle.m) [rxifcal.m](rxifcal.m) | RX IF measurement script
[txifmeasure.m](txifmeasure.m) [txifsingle.m](txifsingle.m) [txifcal.m](txifcal.m) [txifsinglecal.m](txifsinglecal.m) | TX IF measurement script
[rxip3.m](rxip3.m) [rxm4.m](rxm4.m) [calrxip3.m](calrxip3.m) [plotrxip3.m](plotrxip3.m) | RX IP3 measurement script
[txip3.m](txip3.m) [txm4.m](txm4.m) [caltxip3.m](caltxip3.m) [caltxm4.m](caltxm4.m) [plotrxip3.m](plotrxip3.m) | TX IP3 measurement script


Raw Measurement results
-------------------

Folder | Purpose
---- | -------
Date named subfolders | Measurements taken at date
