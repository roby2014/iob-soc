## yosys-icarus

This simulation process is a bit different from the others: It uses `yosys` to generate verilog, and then it simulates that verilog with the same testbench as others simulators use. 


*This is useful to simulate code that will be compiled with yosys toolchain and target FPGAs supported by it.*

### Slow compilation
In case the compilation is **very** slow, it might be `axiram`.
You can remove `include $(AXI_DIR)/hardware/axiram/hardware.mk` from [`simulation.mk`](../simulation.mk).