`timescale 1ns / 1ps

module counter_tb;


logic clk;
logic reset_n;
logic load;
logic [3:0] load_data;
logic [3:0] count;


counter_4bit counter(.*);

initial begin 
        clk = 0;

        forever #1 clk = ~clk;
    end
    
    
    initial begin 
        reset_n = 1; load = 0; load_data = 4'b0000; #2;
        reset_n = 0; load = 0; #5;
        reset_n = 1; #30;
        load = 1; load_data = 4'b1111; #20;
        $finish;
    end

endmodule
