/* Copyright (C) 2025  AGH University of Krakow */

module counter #(
    parameter int MAX_COUNT = 256
    )(
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic [($clog2(MAX_COUNT)-1):0] value,
    output logic overflow
);


/* Local variables and signals */
logic [($clog2(MAX_COUNT)-1):0] value_nxt;
logic overflow_nxt;


/* Module internal logic */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        value <= '0;
        overflow <= '0;
    end else begin
        value <= value_nxt;
        overflow <= overflow_nxt;
    end
end

always_comb begin
    value_nxt = value;
    overflow_nxt = 1'b0;
    if (value == (MAX_COUNT-2) && enabled) begin
        overflow_nxt = 1'b1;
        value_nxt = value + 1;
    end
    if (value == (MAX_COUNT-1) && enabled) begin
        value_nxt = '0;
    end
    else if (enabled) begin
        value_nxt = value + 1;
    end
end

endmodule

