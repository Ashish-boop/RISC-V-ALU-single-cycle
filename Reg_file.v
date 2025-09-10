`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:32:14
// Design Name: 
// Module Name: Reg_file
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

module Reg_file (
    input  wire [4:0] A1,
    input  wire [4:0] A2,
    input  wire [4:0] A3,
    output wire [31:0] RD1,
    output wire [31:0] RD2,
    input  wire [31:0] WD,
    input  wire       WE,
    input  wire       clk
);
    reg [31:0] reg_file [0:31];
    integer j;
    initial begin
        for (j = 0; j < 32; j = j + 1) reg_file[j] = 32'h0;
        // sample init values
        reg_file[5] = 32'd15;
        reg_file[6] = 32'd20;
        reg_file[9] = 32'd30;
    end

    assign RD1 = reg_file[A1];
    assign RD2 = reg_file[A2];

    always @(posedge clk) begin
        if (WE && (A3 != 5'd0)) // x0 is read-only zero
            reg_file[A3] <= WD;
    end
endmodule
