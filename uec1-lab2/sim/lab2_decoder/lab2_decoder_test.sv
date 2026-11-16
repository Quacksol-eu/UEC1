module lab2_decoder_test (

    );
        logic [3:0] dec;
        logic [6:0] result;
        logic [6:0] result_expected;
    
        lab2_decoder lab2_decoder_dut(dec, result);
    
        task check(
            input logic [3:0] d
        );
            dec = d;
        
            #10;
            case (d)
                4'd0: result_expected = 7'b1000000;
                4'd1: result_expected = 7'b1111001;
                4'd2: result_expected = 7'b0100100;
                4'd3: result_expected = 7'b0110000;
                4'd4: result_expected = 7'b0011001;
                4'd5: result_expected = 7'b0010010;
                4'd6: result_expected = 7'b0000010;
                4'd7: result_expected = 7'b1111000;
                4'd8: result_expected = 7'b0000000;
                4'd9: result_expected = 7'b0000000;
                default: result_expected = 7'bxxxxxxx;
            endcase
    
            assert (result === result_expected)
                else $error("Decoder error: dec=%b (%0d) expected=%b got=%b",
                            d, d, result_expected, result);
        endtask
    
        initial begin

            check(4'd0);
            check(4'd1);
            check(4'd2);
            check(4'd3);
            check(4'd4);
            check(4'd5);
            check(4'd6);
            check(4'd7);
            check(4'd8);
            check(4'd9);
    
            check(4'd10);
            check(4'd11);
            check(4'd12);
            check(4'd13);
            check(4'd14);
            check(4'd15);
        
            $finish;
        end
    
    endmodule