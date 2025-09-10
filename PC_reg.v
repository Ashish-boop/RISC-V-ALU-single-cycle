`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:27:44
// Design Name: 
// Module Name: PC_reg
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


module PC_reg (
    input  wire       clk,
    input  wire       rst,
    input  wire [31:0] PC_next,
    output reg  [31:0] PC
);
    always @(posedge clk or posedge rst) begin
        if (rst) PC <= 32'h00000000;
        else     PC <= PC_next;
    end
endmodule
