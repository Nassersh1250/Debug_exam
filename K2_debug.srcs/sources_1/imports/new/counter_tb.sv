`timescale 1ns / 1ps

module counter_tb;


logic clk;
logic resetn;



core K2(.*);

initial begin 
        clk = 0;

        forever #1 clk = ~clk;
    end
    
    
    initial begin 
        resetn = 1;#2;
        resetn = 0;#5;
        resetn = 1; #10;
        #200;
        $finish;
    end

endmodule
