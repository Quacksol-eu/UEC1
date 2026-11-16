module alarm_test;

    logic [4:0] doors;
    logic alarm;

    alarm alarm_dut(doors[0], doors[1], doors[2], doors[3], doors[4], alarm);

    task check(input [4:0] d);
	doors = d;
	#10;
	assert (alarm == (|d)) else
		$error("alarm not working");
    endtask

	initial begin

	$monitor("t=%0t doors =%b alarm=%b", $time, doors, alarm);
	check(5'b00000);
	check(5'b00000);
	check(5'b10000);
	check(5'b00000);
	check(5'b01000);
	check(5'b00000);
	check(5'b00100);
	check(5'b00000);
	check(5'b00010);
	check(5'b00000);
	check(5'b00001);
	check(5'b00000);	
	
	$display("koniec");
	$finish;
	
	
	end

      


endmodule


