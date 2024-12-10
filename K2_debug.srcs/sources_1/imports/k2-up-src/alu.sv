module alu(
    input wire clk,
    input wire opcode,
    input wire [3:0]a,
    input wire [3:0]b,

    output wire [3:0] out,
    output reg carry
);

    addsub addsub_inst0 (
            .M(opcode),
            .A(a),
            .B(b),
            .S(out),
            .Cout(carry)
    );

    
endmodule 


