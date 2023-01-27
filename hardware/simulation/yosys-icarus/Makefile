ROOT_DIR:=../../..

defmacro:=-D
incdir:=-I

SIMULATOR=yosys-icarus
SIM_SERVER=$(IVSIM_SERVER)
SIM_USER=$(IVSIM_USER)
SIM_PROC=a.out

include ../simulation.mk

#simulator flags
VLOG = iverilog -Wall -g2012 $(INCLUDE) $(DEFINE)

#ECP5 source files
ECP5_SRC = /usr/share/yosys/ecp5

#generated verilog from yosys
VERILOG_SYNTH = SYNTH.v

#compile into netlist
comp: $(SIM_PROC)

$(SIM_PROC):
	tclsh yosys.tcl "$(INCLUDE)" "$(DEFINE)" "$(VSRC)" "$(VERILOG_SYNTH)"
	$(VLOG) -o $(SIM_PROC) system_tb.v $(VERILOG_SYNTH) $(ECP5_SRC)/cells_bb.v -I$(ECP5_SRC)  -l$(ECP5_SRC)/cells_sim.v

exec:
	./$(SIM_PROC)

clean: clean-remote
	@rm -f $(SIM_PROC) *.log *.ys *.json *.blif

.PHONY: comp exec clean debug
