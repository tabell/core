# Pipelined MIPS CPU in Verilog
## Components
- 32 bit, 32 entry synchronous register file with dual-ported read
- 32-bit synchronous ALU (add, sub, and, or, nor)
- Top-level module (core.v) implementing pipelined control path and data path

## Completed
Currently a small subset of MIPS instructions are implemented. Load Upper Immediate is implemented (although currently bit-shifting the imm value to the high word is disabled). ALU operations on registers such as ADD and SUB are tested, however they don't work unless you follow them with NO-OPs in the program code. Unconditional jump is implemented although two subsequent instructions will enter the pipeline and currently will be (at least partially) executed.

## Goals
### Core
- Implement conditional branching
- Implement immediate value sourced ALU ops

### Alu 
- Implement flags and the rest of the supported instructions

### Memory
- Implement some sort of load/store, first to register banks then to SDRAM

### Serial interface
- Simple UART for testing on hardware, send-only at first

## Hardware
- Currently testing in simulation and on Spartan6 FPGA
