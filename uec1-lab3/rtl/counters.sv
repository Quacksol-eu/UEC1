/* Copyright (C) 2025  AGH University of Krakow */

module counters #(
    parameter int MAX_COUNT1 = 5,
    parameter int MAX_COUNT2 = 3
    )(
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic [($clog2(MAX_COUNT1)-1):0] value1,
    output logic [($clog2(MAX_COUNT2)-1):0] value2,
    output logic overflow
);
    logic overflow1;
    counter #(
        .MAX_COUNT(5)
    ) counter1 ( 
        .clk,
        .rst_n,
        .enabled,
        .value(value1),
        .overflow(overflow1)
    );

    counter #(
        .MAX_COUNT(3)
    ) counter2 ( 
        .clk,
        .rst_n,
        .enabled(overflow1),
        .value(value2),
        .overflow(overflow)
    );


endmodule