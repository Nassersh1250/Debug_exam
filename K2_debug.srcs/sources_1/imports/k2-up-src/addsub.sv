module addsub #(
    parameter n = 4
)(
    input logic M,
    input logic [n -1:0] A,
    input logic [n -1:0] B,
    output logic [n-1:0] S,
    output logic Cout
);
    logic [n : 0] C;
    logic [n-1:0] Xor_o;
    // 

    xor (Xor_o[0], B[0], M);
    xor (Xor_o[1], B[1], M);
    xor (Xor_o[2], B[2], M);
    xor (Xor_o[3], B[3], M);

    full_adder fa_inst0(.Cin(M),  .A(A[0]), .B(Xor_o[0]), .S(S[0]), .Cout(C[1]));
    full_adder fa_inst1(.Cin(C[1]),  .A(A[1]), .B(Xor_o[1]), .S(S[1]), .Cout(C[2]));
    full_adder fa_inst2(.Cin(C[2]),  .A(A[2]), .B(Xor_o[2]), .S(S[2]), .Cout(C[3]));
    full_adder fa_inst3(.Cin(C[3]),  .A(A[3]), .B(Xor_o[3]), .S(S[3]), .Cout(C[4]));
    // using i instead of a number, giving syntax errors, also all of the full adders were named fa_inst0
    assign Cout = C[n];

endmodule : addsub