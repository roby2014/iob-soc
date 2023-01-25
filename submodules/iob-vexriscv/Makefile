include config.mk

# Rules
.PHONY: vexriscv clean-all qemu

CPU ?= LinuxGen
#CPU ?= GenFullNoMmuNoCache

# Primary targets
vexriscv:
	cp $(VEX_SOFTWARE_DIR)/vexriscv_core/* $(VEX_SUBMODULES_DIR)/VexRiscv/src/main/scala/vexriscv/demo/ && \
		cd submodules/VexRiscv && sbt "runMain vexriscv.demo.$(CPU)" && \
		cp VexRiscv.v $(VEXRISCV_SRC_DIR)

#
# Clean
#
clean-vexriscv:
	rm $(VEXRISCV_SRC_DIR)/VexRiscv.v

clean-all: clean-vexriscv
