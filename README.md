# 🧠 6-Stage Pipelined Processor (MIPS-like) – Verilog Implementation

This project implements a 6-stage pipelined processor in Verilog HDL, designed for FPGA synthesis and simulation. The architecture is inspired by the MIPS instruction set and demonstrates key computer architecture concepts like pipelining, hazard resolution, and forwarding.

---

## 📌 Features

- ✅ **6 Pipeline Stages**:
  - **IF** – Instruction Fetch
  - **ID** – Instruction Decode
  - **RR** – Register Read
  - **EX** – Execute
  - **MEM** – Memory Access
  - **WB** – Write Back

- 🔁 **Forwarding Logic** to handle data hazards without stalling

- ⏱️ **Pipeline Registers**:
  - IF/ID
  - ID/RR
  - RR/EX
  - EX/MEM
  - MEM/WB

- 🧮 **Supported Instructions**:
  - `lw` – Load Word  
  - `sw` – Store Word  
  - `sub` – Subtract  
  - `xori` – XOR Immediate  
  - `j` – Jump  

- 🧰 **32 x 32-bit Register File**

- 💻 **Synthesis-ready** for Xilinx FPGA (tested on `xc7z020clg484-1`)


