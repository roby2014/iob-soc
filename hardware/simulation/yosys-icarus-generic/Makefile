ROOT_DIR:=../../..

defmacro:=-D
incdir:=-I

SIMULATOR=yosys-icarus
SIM_SERVER=$(IVSIM_SERVER)
SIM_USER=$(IVSIM_USER)
SIM_PROC=a.out

include ../simulation.mk

DEFINE+=$(defmacro)YOSYS_SIM=1

#simulator flags
VLOG = iverilog -Wall -g2012 $(INCLUDE) $(DEFINE)

#generated verilog from yosys
GENERATED_VERILOG = SYNTH.v

#compile into netlist
comp: $(SIM_PROC)

$(SIM_PROC): $(GENERATED_VERILOG)
	$(VLOG) system_tb.v $(GENERATED_VERILOG) -o $(SIM_PROC)

$(GENERATED_VERILOG):
	tclsh generate_yosys_verilog.tcl "$(INCLUDE)" "$(DEFINE)" "$(VSRC)" "$(GENERATED_VERILOG)"

exec:
	./$(SIM_PROC)

clean: clean-remote
	@rm -f $(SIM_PROC) *.log *.ys *.json *.blif

.PHONY: comp exec clean debug