// This counter is designed using register, adder and a multiplexer. 
// Normally we don't use this appraoch as this requires more hardware there a simple counter 
// that adds constant value "1'b1".

module counter_4bit#(
)(
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [3:0] load_data,
    output logic [3:0] count
);

    logic [3:0] next_count; // next count is a one bit value, whilst count is a four bit variable, therefore it would only count to one 
    assign next_count = load ? (load_data) : (count+1); // when load is high the counter increments, and when load is low,it loads the data value into the counter. Logically (or atleast according to the diagram)  it should be the opposite


    always @(posedge clk, negedge reset_n)
    begin 
        if(!reset_n)
            count <= 0;
        else 
            count <= next_count;
    end

endmodule