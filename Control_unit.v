`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:36:42
// Design Name: 
// Module Name: Control_unit
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

module Control_unit (
    input  wire [6:0] opcode,
    input  wire [2:0] func3,
    input  wire [6:0] func7,
    output wire DM_WE,
    output wire RF_WE,
    output wire Extend_Src,
    output wire ResultSrc,
    output wire AluSrc,
    output wire [1:0] Alu_control
);
    wire is_load  = (opcode == 7'b0000011);
    wire is_store = (opcode == 7'b0100011);
    wire is_rtype = (opcode == 7'b0110011);

    assign DM_WE     = is_store ? 1'b1 : 1'b0;
    assign RF_WE     = (is_load | is_rtype) ? 1'b1 : 1'b0;
    assign Extend_Src= is_store ? 1'b1 : 1'b0;  // S-type when store, else use I-type
    assign ResultSrc = is_load ? 1'b1 : 1'b0;   // load -> writeback from DM, else ALU
    assign AluSrc    = (is_load | is_store) ? 1'b1 : 1'b0; // load/store use immediate as B

    // ALU control:
    // R-type: func3+func7 decides
    // For simplicity: func3==000 && func7[5]==1 -> SUB else ADD
    // OR and AND mapped by func3
    wire alu_op_r = is_rtype;
    wire is_sub   = (alu_op_r && func3 == 3'b000 && func7[5] == 1'b1);
    wire is_add   = (alu_op_r && func3 == 3'b000 && func7[5] == 1'b0) | (is_load | is_store); // load/store -> add (address)
    wire is_or    = (alu_op_r && func3 == 3'b110);
    wire is_and   = (alu_op_r && func3 == 3'b111);

    assign Alu_control = is_add ? 2'b00 :
                         is_sub ? 2'b01 :
                         is_and ? 2'b10 :
                         is_or  ? 2'b11 : 2'b00;
endmodule
