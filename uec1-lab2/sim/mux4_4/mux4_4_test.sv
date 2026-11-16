module mux4_4_test (

    );
        logic [3:0] select;
        logic [3:0] input_vec [0:3];
        logic [3:0] out;
        logic [3:0] out_expected;
    
        // Podpięcie z mapowaniem tablicy input_vec na osobne porty
        mux4_4 mux4_4_dut (
            .input0(input_vec[3]),
            .input1(input_vec[2]),
            .input2(input_vec[1]),
            .input3(input_vec[0]),
            .sel(select),
            .input_selected(out)
        );
    
        task automatic check(
            input logic [3:0] sel,
            input logic [3:0] data [0:3]
        );
            select = sel;
            input_vec = data;
        
            #10;
            case (sel)
                4'b0111: out_expected = data[0];
                4'b1011: out_expected = data[1];
                4'b1101: out_expected = data[2];
                4'b1110: out_expected = data[3];
                default: out_expected = 4'bxxxx;
            endcase
    
            assert (out === out_expected)
                else $error("MUX error: sel=%b expected=%b got=%b",
                            sel, out_expected, out);
        endtask
    
        initial begin
            check(4'b0111, '{4'b1111, 4'b0000, 4'b0000, 4'b0000});
            check(4'b1011, '{4'b0000, 4'b1111, 4'b0000, 4'b0000});
            check(4'b1101, '{4'b0000, 4'b0000, 4'b1111, 4'b0000});
            check(4'b1110, '{4'b0000, 4'b0000, 4'b0000, 4'b1111});
            check(4'b0000, '{4'b1111, 4'b1111, 4'b1111, 4'b1111}); // Test dla default (4'bxxxx)
        
            $finish;
        end
    
    endmodule