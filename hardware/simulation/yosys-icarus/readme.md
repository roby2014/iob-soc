## yosys-icarus

This simulation process is a bit different from the others: It uses `yosys` to generate verilog, and then it simulates that verilog with the same testbench as others simulators use. 


*This is useful to simulate code that will be compiled with yosys toolchain and target FPGAs supported by it.*