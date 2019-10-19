##### Step 1: Install ipbb

##### Step 2: Setup the emp work area
If you haven't already cloned the emp-fwk and related firmware somewhere else, then get the core components:

```
ipbb init p2fwk-work
cd p2fwk-work
git clone https://gitlab.cern.ch/p2-xware/firmware/emp-fwk.git -b tags/v0.2.5
git clone https://gitlab.cern.chcms-cactus/firmware/mp7.git -b ephemeral/phase2-vC
ipbb add git https://github.com/ipbus/ipbus-firmware -b tags/v1.3
```

##### Step 2: Build the TAU HLS IP core

```
cd src
git clone https://github.com/violatingcp/GlobalCorrelator_HLS.git -b serenity_v2
cd GlobalCorrelator_HLS
vivado_hls run_hls_sort_v5.tcl
```

##### Step 3: Create a Tau IP Vivado project 
Still in `p2fwk-work/src`
```
git clone https://github.com/violatingcp/GlobalCorrelator.git

For VCU118 dev-kit (VU9P FPGA):
```
ipbb proj create vivado tau_vcu118 GlobalCorrelator:emp_examples/top -t top_vcu118_sort.dep
cd proj/tau_vcu118
```

##### Step 4: Setup, build and package the bitfile
Create the Vivado project
```
ipbb vivado project
```
Then either 1): build the firmware in batch mode
```
ipbb vivado synth -j4 impl -j4
ipbb vivado package
```
Or 2): open the Vivado GUI
```
vivado top/top.xpr
```

##### Step 5: Run on the VU9P

```
ssh cmd-phase2-trg-ctrlhub
source /home/xilinx/Vivado_Lab/2018.3/settings64.sh
vivado_lab
open hardware manager (keep clicking hardware)
program bitfile

source /afs/cern.ch/work/s/ssummers/public/forbrandon/emp-tb.sh
# Clone the emp-toolbox (could be to your home dir, work dir, wherever)
git clone https://gitlab.cern.ch/p2-xware/software/emp-toolbox
# Then every time:
cd emp-tooblox
source env.sh
export UHAL_ENABLE_IPBUS_PCIE=1
empbutler -c /afs/cern.ch/work/s/ssummers/public/forbrandon/VertexFinder_vcu118/package/src/addrtab/connections.xml do vcu118 inspect 'info*'
sudo /afs/cern.ch/work/s/ssummers/public/forbrandon/pcie_reconnect_xilinx.sh
sudo chmod 777 /dev/xdma0_c2h_0 /dev/xdma0_h2c_0
/afs/cern.ch/user/p/pharris/public/tmp2/emp-toolbox/tmp/pattern_file_test.sh




