module alarm_test;

    logic [4:0] doors;
    logic alarm;
	logic alarm_expected;

    alarm alarm_dut(doors[0], doors[1], doors[2], doors[3], doors[4], alarm);

    task check(input [4:0] d);
		alarm_expected = |d;
		doors = d;
		#10;
		assert (alarm == (|d)) else
			$error("alarm not working when t=%0t doors=%b alarm=%b expected=%b", $time, doors, alarm, alarm_expected);
    endtask

	initial begin
		//$monitor("t=%0t doors=%b alarm=%b", $time, doors, alarm);
		for (int i = 0; i < 32; i++) begin
			check(i[4:0]);
		end
	
		$display("koniec");
		$finish;
	end
	
endmodule


