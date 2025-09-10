`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:35:30
// Design Name: 
// Module Name: ALU
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


module ALU (
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire [31:0] ALU_out,
    input  wire [1:0]  ALU_control
);
    wire [31:0] sub_b;
    wire        do_sub = (ALU_control == 2'b01);

    // if subtract, use two's complement
    assign sub_b = do_sub ? (~B + 32'd1) : B;

    wire [31:0] add_res = A + sub_b;
    wire [31:0] and_res = A & B;
    wire [31:0] or_res  = A | B;

    assign ALU_out = (ALU_control == 2'b00) ? add_res :
                     (ALU_control == 2'b01) ? add_res : // sub case uses add_res computed with sub_b
                     (ALU_control == 2'b10) ? and_res :
                     (ALU_control == 2'b11) ? or_res  :
                     32'd0;
endmodule
