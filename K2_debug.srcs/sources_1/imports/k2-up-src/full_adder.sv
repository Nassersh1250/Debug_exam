module full_adder(
    input wire Cin,
    input logic A,
    input logic B,
    output logic S,
    output logic Cout
);

    logic C1, C2;
    logic S0;

    half_adder hadder0(
        .A(A),
        .B(B),
        .S(S0),
        .C(C1)
    );

    half_adder hadder1(
        .A(S0),
        .B(Cin),
        .S(S),
        .C(C2)
    );


    or (Cout, C1, C2);

endmodule : full_adder