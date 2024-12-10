module counter_4bit#(
)(
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [3:0] load_data,
    output logic [3:0] count
);

        logic dff0_data_i;
        logic dff1_data_i;
        logic dff2_data_i;
        logic dff3_data_i;


        // Next count logic 
        logic [3:0] next_count;
        assign next_count[0] = ~count[0];
        assign next_count[1] = count[0] ^ count[1];
        assign next_count[2] = (count[0] & count[1]) ^ count[2];
        assign next_count[3] = (count[0] & count[1] & count[2])  ^ count[3];

        // do count plus one or load a value to counter
        mux2x1 mux_inst0(.S(load), .in2(next_count[0]), .in1(load_data[0]), .out(dff0_data_i));
        mux2x1 mux_inst1(.S(load), .in2(next_count[1]), .in1(load_data[1]), .out(dff1_data_i));
        mux2x1 mux_inst2(.S(load), .in2(next_count[2]), .in1(load_data[2]), .out(dff2_data_i));
        mux2x1 mux_inst3(.S(load), .in2(next_count[3]), .in1(load_data[3]), .out(dff3_data_i));
            // mux wasn't instantiated properly

        // D flip flops
        d_flipflop dff0(
            .clk(clk),
            .D(dff0_data_i),
            .reset_n(reset_n),
            .Q(count[0])
            );

        d_flipflop dff1(
            .clk(clk),
            .D(dff1_data_i),
            .reset_n(reset_n),
            .Q(count[1])
            );

        d_flipflop dff2(
            .clk(clk),
            .D(dff2_data_i), // dff2_data was not loaded
            .reset_n(reset_n),
            .Q(count[2])
            );

        d_flipflop dff3(
            .clk(clk),
            .D(dff3_data_i),
            .reset_n(reset_n),
            .Q(count[3]) // Qn instead of Q
            );

endmodule