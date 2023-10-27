CORE := iob_soc

SIMULATOR ?= icarus
BOARD ?= CYCLONEV-GT-DK

DISABLE_LINT:=1
export DISABLE_LINT

INIT_MEM ?= 1
USE_EXTMEM ?= 0

clean:
	rm -rf ../$(CORE)_V*

setup:
	python3 -B ./$(CORE).py INIT_MEM=$(INIT_MEM) USE_EXTMEM=$(USE_EXTMEM) 

sim-build: clean setup
	make -C ../$(CORE)_V*/ sim-build SIMULATOR=$(SIMULATOR)

setup:
	nix-shell --run 'make build-setup SETUP_ARGS="$(SETUP_ARGS)"'

pc-emul-run:
	nix-shell --run 'make clean setup && make -C ../$(CORE)_V*/ pc-emul-run'

pc-emul-test:
	nix-shell --run 'make clean setup && make -C ../$(CORE)_V*/ pc-emul-test'

sim-run:
	nix-shell --run 'make clean setup INIT_MEM=$(INIT_MEM) USE_EXTMEM=$(USE_EXTMEM) && make -C ../$(CORE)_V*/ sim-run SIMULATOR=$(SIMULATOR)'

sim-test:
	nix-shell --run 'make clean setup INIT_MEM=1 USE_EXTMEM=0 && make -C ../$(CORE)_V*/ sim-test SIMULATOR=icarus'
	nix-shell --run 'make clean setup INIT_MEM=0 USE_EXTMEM=1 && make -C ../$(CORE)_V*/ sim-test SIMULATOR=verilator'
	nix-shell --run 'make clean setup INIT_MEM=0 USE_EXTMEM=1 && make -C ../$(CORE)_V*/ sim-test SIMULATOR=verilator'

fpga-run:
	nix-shell --run 'make clean setup INIT_MEM=$(INIT_MEM) USE_EXTMEM=$(USE_EXTMEM) && make -C ../$(CORE)_V*/ fpga-fw-build BOARD=$(BOARD)'
	make -C ../$(CORE)_V*/ fpga-run BOARD=$(BOARD)

fpga-test:
	make clean setup fpga-run BOARD=CYCLONEV-GT-DK INIT_MEM=1 USE_EXTMEM=0 
	make clean setup fpga-run BOARD=CYCLONEV-GT-DK INIT_MEM=0 USE_EXTMEM=1 
	make clean setup fpga-run BOARD=AES-KU040-DB-G INIT_MEM=1 USE_EXTMEM=0 
	make clean setup fpga-run BOARD=AES-KU040-DB-G INIT_MEM=0 USE_EXTMEM=1 


doc-build:
	nix-shell --run 'make clean setup && make -C ../$(CORE)_V*/ doc-build'

doc-test:
	nix-shell --run 'make clean setup && make -C ../$(CORE)_V*/ doc-test'


test-all: pc-emul-test sim-test fpga-test doc-test


.PHONY: setup sim-test fpga-test doc-test test-all
