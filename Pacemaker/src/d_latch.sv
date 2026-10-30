module d_latch(
    input logic D,
    input logic E,
    input logic R_n,
    output logic Q,
    output logic Q_n
);

logic S_i_n, R_i_n;
logic S_final_n, R_final_n;
logic D_n, R;

// D logic
not u_not1 (D_n, D);

nand u_nand1 (S_i_n, D, E);
nand u_nand2 (R_i_n, D_n, E);

// External reset
not u_not2 (R, R_n);

// S_final_n = S_i_n OR R
not  u_not3  (S_i, S_i_n);
not  u_not4  (R_inv, R);
nand u_nand3 (S_final_n, S_i, R_inv);

// R_final_n = R_i_n AND R_n
nand u_nand4 (R_temp, R_i_n, R_n);
not  u_not5  (R_final_n, R_temp);

// SR latch
sr_latch u_sr_latch (
    .S_n(S_final_n),
    .R_n(R_final_n),
    .Q(Q),
    .Q_n(Q_n)
);

endmodule