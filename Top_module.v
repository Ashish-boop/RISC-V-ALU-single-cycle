`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:26:08
// Design Name: 
// Module Name: Top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_module (
    input  wire clk,
    input  wire rst
);

    
    // Top-level wires
    
    wire [31:0] PC;          // current PC (byte address)
    wire [31:0] PC_next;     // next PC (byte address)
    wire [31:0] instruction;
    wire [31:0] RD1;         // regfile read port 1
    wire [31:0] RD2;         // regfile read port 2
    wire [31:0] SrcA;        // ALU A input
    wire [31:0] SrcB;        // ALU B input
    wire [31:0] Extend_out;  // immediate extended
    wire [31:0] Alu_out;
    wire [31:0] DM_RD;       // data memory read data
    wire [31:0] result;      // WB result

    wire       DM_WE, RF_WE, Extend_Src, ResultSrc, AluSrc;
    wire [1:0] Alu_control;

    
    // PC register + adder
    
    PC_reg pc_reg (
        .clk(clk),
        .rst(rst),
        .PC_next(PC_next),
        .PC(PC)
    );

    Adder pc_adder (
        .A(PC),
        .out(PC_next)
    );

    
    // Instruction memory 
    
    Instruction_Memory IM (
        .A(PC),
        .RD(instruction)
    );

    
    // Register file
    
    Reg_file RF (
        .A1(instruction[19:15]),
        .A2(instruction[24:20]),
        .A3(instruction[11:7]),
        .RD1(RD1),
        .RD2(RD2),
        .WD(result),
        .WE(RF_WE),
        .clk(clk)
    );

    assign SrcA = RD1;

    
    // Sign extend 
   
    Sign_Extend SE (
        .instr(instruction),
        .immSrc(Extend_Src),
        .out(Extend_out)
    );

    
    // ALU source multiplexer
   
    Mux_2to1 mux_alu (
        .in1(RD2),
        .in2(Extend_out),
        .sel(AluSrc),
        .out(SrcB)
    );

    
    // ALU
    

    ALU ALU0 (
        .A(SrcA),
        .B(SrcB),
        .ALU_out(Alu_out),
        .ALU_control(Alu_control)
    );

   
    // Result Mux: from ALU or Data Memory
    
    Mux_2to1 mux_result (
        .in1(Alu_out),
        .in2(DM_RD),
        .sel(ResultSrc),
        .out(result)
    );

   
    // Data Memory
   
    Data_Memory DM (
        .A(Alu_out),     // address in bytes
        .clk(clk),
        .WE(DM_WE),
        .RD(DM_RD),
        .WD(RD2)
    );


    // Control Unit
   
    Control_unit CU (
        .opcode(instruction[6:0]),
        .func3(instruction[14:12]),
        .func7(instruction[31:25]),
        .DM_WE(DM_WE),
        .RF_WE(RF_WE),
        .Extend_Src(Extend_Src),
        .ResultSrc(ResultSrc),
        .AluSrc(AluSrc),
        .Alu_control(Alu_control)
    );

endmodule


