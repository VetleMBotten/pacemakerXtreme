module d_latch(
    input logic D,
    input logic E,
    output logic Q,
    output logic Q_n
);

logic S_i_n, R_i_n;
logic D_n;

// D logic
not u_not1 (D_n, D);

nand u_n3 (S_i_n, D, E);
nand u_n4 (R_i_n, D_n, E);

// SR latch
sr_latch u_sr_latch (
    .S_n(S_i_n),
    .R_n(R_i_n),
    .Q(Q),
    .Q_n(Q_n)
);

endmodule