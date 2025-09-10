`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2025 08:43:50
// Design Name: 
// Module Name: Top_module_TB
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


module Top_module_TB;

    reg clk, rst;
    
    // Instantiate DUT
    Top_module uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generator: 10 ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Apply reset
        rst = 1;
        #20;
        rst = 0;

        // Run simulation for 200 ns (20 cycles)
        //#200 $finish;
    end

    // Monitor key signals
    initial begin
        $monitor("T=%0t | PC=%h | Instr=%h | ALU=%h | Result=%h | RF_WE=%b | DM_WE=%b",
                  $time,
                  uut.PC,
                  uut.instruction,
                  uut.Alu_out,
                  uut.result,
                  uut.RF_WE,
                  uut.DM_WE);
    end

    // Initialize instruction memory contents
    // This is done directly by accessing uut.IM.mem
    integer i;
    initial begin
        
        for (i = 0; i < 1024; i = i + 1)
            uut.IM.mem[i] = 32'h00000013; // NOP (addi x0,x0,0)

        // Program:
        // addi x1, x0, 5      -> x1 = 5
        // addi x2, x0, 10     -> x2 = 10
        // add  x3, x1, x2     -> x3 = 15
        // sw   x3, 0(x0)      -> store x3 into mem[0]
        // lw   x5, 0(x0)      -> load mem[0] into x5
        uut.IM.mem[0] = 32'h00500093; // addi x1, x0, 5
        uut.IM.mem[1] = 32'h00A00113; // addi x2, x0, 10
        uut.IM.mem[2] = 32'h002081B3; // add x3, x1, x2
        uut.IM.mem[3] = 32'h00302023; // sw x3, 0(x0)
        uut.IM.mem[4] = 32'h00002283; // lw x5, 0(x0)
    end

endmodule

