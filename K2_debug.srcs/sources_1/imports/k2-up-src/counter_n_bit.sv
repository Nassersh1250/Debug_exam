module counter_n_bit#(
    parameter n = 4
)(
    input logic clk,
    input logic resetn,
    input logic load = 0,
    input logic en,
    input logic [n - 1: 0] load_data,
    output logic [n - 1: 0] count
);

    always_ff @(posedge clk, negedge resetn) begin 
        if(!resetn) count <= 0;
        else begin 
            if(en) begin 
                    if(load == 1) count <= load_data;
                    else count <= count + 1; // load while enabled or increment
            end
        end
    end
endmodule : counter_n_bit