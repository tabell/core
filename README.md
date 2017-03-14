# Pipelined MIPS CPU in Verilog
## Components
- 32 bit, 32 entry synchronous register file with dual-ported read
- 32-bit synchronous ALU (add, sub, and, or, nor)
- Top-level module (core.v) implementing pipelined control path and data path

## Completed
- ALU and regfile
## Goals
- Everything else
### Priorities
- LUI - Load upper immediate
- NOOP
- ADD/SUB/AND/OR/XOR
- ADD/SUB/AND/OR/XOR immediate
- SLL/SRL/SRA
- SLL/SRL/SRA Variable
- BEQ / BNE
- SLTI/SLT/SLTU/SLTIU
