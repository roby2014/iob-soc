ifeq ($(filter AXISTREAMIN, $(HW_MODULES)),)

include $(AXISTREAMIN_DIR)/config.mk

#add itself to HW_MODULES list
HW_MODULES+=AXISTREAMIN

#include iob_fifo_sync
include $(MEM_DIR)/hardware/fifo/iob_fifo_sync/hardware.mk
include $(MEM_DIR)/hardware/ram/iob_ram_2p/hardware.mk
include $(MEM_DIR)/hardware/ram/iob_ram_2p_be/hardware.mk
include $(MEM_DIR)/hardware/ram/iob_ram_2p_asym/hardware.mk

AXISTREAMIN_INC_DIR:=$(AXISTREAMIN_HW_DIR)/include
AXISTREAMIN_SRC_DIR:=$(AXISTREAMIN_HW_DIR)/src

USE_NETLIST ?=0

#include files
VHDR+=$(wildcard $(AXISTREAMIN_INC_DIR)/*.vh)
VHDR+=iob_axistream_in_swreg_gen.vh iob_axistream_in_swreg_def.vh
VHDR+=$(LIB_DIR)/hardware/include/iob_lib.vh $(LIB_DIR)/hardware/include/iob_s_if.vh $(LIB_DIR)/hardware/include/iob_gen_if.vh

#hardware include dirs
INCLUDE+=$(incdir). $(incdir)$(AXISTREAMIN_INC_DIR) $(incdir)$(LIB_DIR)/hardware/include

#sources
VSRC+=$(AXISTREAMIN_SRC_DIR)/iob_axistream_in.v

axistream-in-hw-clean: axistream-in-gen-clean
	@rm -f *.v *.vh

.PHONY: axistream-in-hw-clean

endif
