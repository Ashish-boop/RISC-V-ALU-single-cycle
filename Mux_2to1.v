`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:34:52
// Design Name: 
// Module Name: Mux_2to1
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


module Mux_2to1 (
    input  wire [31:0] in1,
    input  wire [31:0] in2,
    input  wire        sel,
    output wire [31:0] out
);
    assign out = (sel) ? in2 : in1;
endmodule

