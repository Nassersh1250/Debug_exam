module half_adder(
    input logic A,
    input logic B,
    output logic S,
    output logic C
);

    logic temp_sum;
    xor (S, A, B);
    and (C, A, B);

endmodule : half_adder