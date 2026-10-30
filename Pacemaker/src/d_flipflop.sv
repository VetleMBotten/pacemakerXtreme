//D_flipflop using only inverters and NAND gates. 
//for simple CMOS implementation
module d_flipflop(
    input logic clk,
    input logic D,
    input logic S_n,
    input logic R_n,
    output logic Q,
    output logic Q_n
);

logic clk_n, clk_n_n;
logic Q_i, Q_i_n;

// Clock inversion
not u_not1 (clk_n, clk);
not u_not2 (clk_n_n, clk_n);

// Master latch
d_latch master (
    .D(D),
    .E(clk_n),
    .Q(Q_i),
    .Q_n(Q_i_n)
);

// Slave latch
d_latch slave (
    .D(Q_i),
    .E(clk_n_n),
    .Q(Q),
    .Q_n(Q_n)
);

endmodule