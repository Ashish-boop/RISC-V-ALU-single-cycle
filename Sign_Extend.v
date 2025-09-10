`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:33:34
// Design Name: 
// Module Name: Sign_Extend
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


module Sign_Extend (
    input  wire [31:0] instr,
    input  wire        immSrc, // 0 -> I-type, 1 -> S-type
    output wire [31:0] out
);
    wire [11:0] imm_I = instr[31:20];
    wire [11:0] imm_S = {instr[31:25], instr[11:7]};

    assign out = (immSrc == 1'b1) ? {{20{imm_S[11]}}, imm_S} : {{20{imm_I[11]}}, imm_I};
endmodule
