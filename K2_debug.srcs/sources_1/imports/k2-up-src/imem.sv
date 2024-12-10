module imem#(
    parameter n = 4
)(
    input logic [3:0] addr,
    output logic [7:0] inst
);
    always @(*) begin 
        case(addr) // following program will generate the fibbonacci sequence
        4'b0000 : inst = 8'b00001000; 
        4'b0001 : inst = 8'b00011001; 
        4'b0010 : inst = 8'b00100010;
        4'b0011 : inst = 8'b00010000; 
        4'b0100 : inst = 8'b01110000; 
        4'b0101 : inst = 8'b00000000;
        4'b0110 : inst = 8'b00010100; 
        4'b0111 : inst = 8'b00000100; 
        4'b1000 : inst = 8'b10110010;
        default : inst = 8'b00110000;  // idle instruction
        endcase
    end

endmodule : imem