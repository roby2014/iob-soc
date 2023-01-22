# IoB-SoC on Colorlight boards

## Dependencies
You can program this boards using **a fully open source toolchain**:
- [yosys](https://github.com/YosysHQ/yosys) – Yosys Open Synthesis Suite.
- [nextpnr-ecp5](https://github.com/YosysHQ/nextpnr) - A portable FPGA place and route tool (for Lattice ECP5 FPGA).
- [prjtrellis](https://github.com/YosysHQ/prjtrellis) - Device database and tools for bitstream creation (fully open source flow for ECP5 FPGA).
- [openFPGALoader](https://github.com/trabucayre/openFPGALoader) - Universal utility for programming FPGA

## Logging
When building for these boards, all compilation (synthesis/place&route) logs are stored inside:
- `BOARD/top_system_synthesis.log`
- `BOARD/top_system_pnr.log`

## Adding support for a new Colorlight board
To add support for a new Colorlight board, you must:
- Create its folder (e.g: `5A-75E/`)
- Inside board folder, it must have:
  - `Makefile` (the other examples should be easy to follow and understand)
  - `top_system.lpf`: Pin mapping
  - `verilog/top_system.v`: Top system Verilog source file
  - `doc/`: Folder with documentation about the board/FPGA