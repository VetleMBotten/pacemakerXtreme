module sr_latch(
    input logic S_n,
    input logic R_n,
    output logic Q,
    output logic Q_n
);

nand u_n1 (Q_n, R_n, Q);
nand u_n2 (Q, S_n, Q_n);

endmodule