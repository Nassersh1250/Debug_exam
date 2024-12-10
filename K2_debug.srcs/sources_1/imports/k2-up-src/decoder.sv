module decoder#(
    parameter n = 2
)(
    input logic [n-1:0]in,
    output logic [(1 << n) - 1: 0]out
);

    always @(*)
    begin 
        case(in)
        0: out = 0001;
        1: out = 0010;
        2: out = 0100; // logical error, should be 0100 instead of 0110
        3: out = 1000; // included the final case just in case
        endcase
    end

endmodule // endmodule syntax error 