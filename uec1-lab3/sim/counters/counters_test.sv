/* Copyright (C) 2025  AGH University of Krakow */

module counters_test;


/* Local variables and signals */

logic clk, rst_n;

localparam int MAX_COUNT1 = 5;
localparam int MAX_COUNT_FALSE = 3;
localparam int MAX_COUNT2 = MAX_COUNT_FALSE + 1;
logic [($clog2(MAX_COUNT1)-1):0] value1;
logic [($clog2(MAX_COUNT2)-1):0] value2;
logic overflow;
logic enabled;


/* Submodules placement */

counters #(
    .MAX_COUNT1(MAX_COUNT1),
    .MAX_COUNT2(MAX_COUNT2)
    ) dut (
    .clk,
    .rst_n,
    .enabled,
    .value1,
    .value2,
    .overflow
);


/* Tasks and functions definitions */

task reset();
    for (int i = 0; i < 2; ++i) begin
        @(negedge clk);
        rst_n = i[0];
    end
endtask

task test_disabled_counter();
    enabled = 1'b0;

    reset();

    for (int i = 0; i < 10; ++i) begin
        assert (value2 == 'b0) else begin
            $error("value2: exp: %1d, rcv: %1d", 'b0, value2);
        end
        @(negedge clk);
    end
endtask

task test_enabled_counter();
    enabled = 1'b1;

    reset();

    for (int i = 0; i < ((MAX_COUNT1 * MAX_COUNT2) + 5); ++i) begin
        assert (value2 == i) else begin
            $error("value2: exp: %1d, rcv: %1d", i, value2);
        end
        @(negedge clk);
    end
endtask


/* Clock generation */

initial begin
    clk = 1'b0;

    forever begin
        clk = #5ns ~clk;
    end
end


/* Test */

initial begin
    rst_n = 1'b1;
    enabled = 1'b0;

    test_disabled_counter();
    test_enabled_counter();

    $finish;
end

endmodule
