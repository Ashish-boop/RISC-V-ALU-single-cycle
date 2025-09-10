`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:29:17
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory (
    input  wire [31:0] A,    // byte address
    output reg  [31:0] RD
);
    reg [31:0] mem [0:1023];
    integer i;
    // initialize (example instructions)
    initial begin
        // Fill with NOP (addi x0,x0,0 -> 0x00000013) then override few locations
        
        for (i = 0; i < 1024; i = i + 1)
            mem[i] = 32'h00000013;

        // Example: a few instructions (you can replace with your hex)
        // mem[0] = 32'h... ;
        // mem[1] = 32'h0062E233; // example (ensure correctness)
        end

    always @(*) begin
        RD = mem[A[31:2]];
    end
endmodule