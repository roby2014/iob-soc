FPGA_OBJ=top_system.bit
FPGA_LOG=colorlight.log

FPGA_SERVER=$(COLORLIGHT_SERVER)
FPGA_USER=$(COLORLIGHT_USER)

#yosys cant infer iob-mem's dual port RAMs for now (only if using -no-rw-check)
#so we force this setting to use single port 
DEFINE+=$(defmacro)USE_SPRAM

include ../../fpga.mk

local-build:
	tclsh ../top_system.tcl "$(INCLUDE)" "$(DEFINE)" "$(VSRC)" "$(BOARD)" "$(REVISION)"

clean: clean-all
	@rm -rf *.json *.ys *.txt *.config *.log *.svf *.bit *.lpf

clean-ip:
	

veryclean: clean clean-ip

