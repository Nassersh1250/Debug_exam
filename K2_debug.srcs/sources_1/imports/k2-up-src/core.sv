module core(
    input logic clk, 
    input logic resetn
);

// Instruction Fetching
logic [3:0] imm;
logic [3:0] pc;

// Decoding instruction 
logic J;
logic C;
logic [1:0] D;
logic Sreg;
logic S;
logic carry,carry_ff;

// jump logic 
logic pc_load;
assign pc_load = J | (C & carry_ff);

counter_n_bit pc_inst(
    .clk(clk),
    .resetn(resetn),
    .load_data(imm),
    .load(pc_load),
    .en(1'b1),   
    .count(pc)
);


// Instruction memory
logic [7:0] inst;
imem imem_inst(
    .addr(pc),
    .inst(inst)
);



assign J = inst[7];
assign C = inst[6];
assign D = inst[5:4];
assign Sreg = inst[3];
assign imm = ({1'b0, inst[2:0]}); // imm should be a four bit value to avoid high impedance 
assign S = inst[2]; // S wasnt assigned 

// Generating enables for register O, A and B
logic enA, enB, enO, enx;
logic [3:0] decout;
decoder decoder_inst(
    .in(D),
    .out(decout)
);

// registers 
logic [3:0] regIn;
logic [3:0] regA, regB, regO;
assign enA = decout[0];
assign enB = decout[1];
assign enO = decout[2];
assign enx = decout[3];
// redid the enable and decoder assignment 
logic [3:0] AluOut; // AluOut was 1 bit instead of four

// Mux for selecting inputs for register (regIn)
mux2x1 mux1(
    .in1(imm),
    .in2(AluOut),
    .sel(Sreg),
    .out(regIn)
);

// Register RA (regA)
register reg_A(
    .clk(clk),
    .resetn(resetn),
    .wen(enA),
    .D(regIn),
    .Q(regA)
);

// Register RB (regB)
register reg_B(
    .clk(clk),
    .resetn(resetn),
    .wen(enB), // b's enable wasnt added
    .D(regIn),
    .Q(regB)
);

// Register RO (regO)
register reg_O(
    .clk(clk), // coreclk instead of clk
    .resetn(resetn),
    .wen(enO),
    .D(regA),
    .Q(regO)
);
// Register for carry
register reg_C(
    .clk(clk), // coreclk instead of clk
    .resetn(resetn),
    .wen(1'b1),
    .D(carry),
    .Q(carry_ff)
);

// ALU

alu alu_inst(
    .opcode(S), // alu does not need clk
    .a(regA),
    .b(regB),
    .out(AluOut),
    .carry(carry)
);


endmodule : core