module tester;

// Clock and reset pins
reg clock;
reg reset;

// Outputs and inputs from the FPGA
reg [3:0] Keys = 4'd0;
reg [9:0] Toggles = 10'b1111111111;
wire [7:0] Green;
wire [9:0] Red;
wire [6:0] Hex0, Hex1, Hex2, Hex3;
reg rx = 1'b1;

// Test device.
wire ready;
wire [7:0] serial_out;
serial_read test(clock, rx, ready, serial_out);

// Reset the processor
initial
begin
    // Start with clock on high
    clock = 1;

    reset <= 1;
    # 3;
    reset <= 0;
end

// Generate clock
always
begin
    clock <= 1;
    # 1;
    clock <= 0;
    # 1;
end

// Count the cycles.
reg [31:0] cycle = 32'd0;
always @(posedge clock) begin
    cycle <= cycle + 1;
end

always @(negedge test.clk) begin
        $display("RX: %b", rx);
        $display("Ready: %b", ready);
        $display("Output: %b", serial_out);
		  $display("State: %b", test.state);
		  $display("Next State: %b", test.next_state);
        $display("Clock Counter: %d", test.clk_counter);
        $display("Baud Counter: %b\n", test.baud_count);

        if (cycle == 880000)
            $finish;
end

always @(posedge clock) begin
    case (cycle)
    80000:      rx <= 0;
    160000:     rx <= 1;
    240000:     rx <= 1;
    320000:     rx <= 1;
    400000:     rx <= 1;
    480000:     rx <= 1;
    560000:     rx <= 1;
    640000:     rx <= 1;
    720000:     rx <= 1;
    800000:     rx <= 1;
    880000:     rx <= 1;
    960000:     rx <= 1;
    /*
    1040000:    rx <= 0;
    1120000:    rx <= 0;
    1200000:    rx <= 0;
    1280000:    rx <= 0;
    1360000:    rx <= 0;
    1440000:    rx <= 0;
    1520000:    rx <= 0;
    1600000:    rx <= 0;
    1680000:    rx <= 0;
    1760000:    rx <= 0;
    1840000:    rx <= 0;
    1920000:    rx <= 0;
    2000000:    rx <= 0;
    2080000:    rx <= 0;
    2160000:    rx <= 0;
    2240000:    rx <= 0;
    2320000:    rx <= 0;
    2400000:    rx <= 0;
    2480000:    rx <= 0;
    2560000:    rx <= 0;
    2640000:    rx <= 0;
    2720000:    rx <= 0;
    2800000:    rx <= 0;
    2880000:    rx <= 0;
    2960000:    rx <= 0;
    3040000:    rx <= 0;
    3120000:    rx <= 0;
    3200000:    rx <= 0;
    3280000:    rx <= 0;
    3360000:    rx <= 0;
    3440000:    rx <= 0;
    3520000:    rx <= 0;
    3600000:    rx <= 0;
    3680000:    rx <= 0;
    3760000:    rx <= 0;
    3840000:    rx <= 0;
    3920000:    rx <= 0;
    4000000:    rx <= 0;
    4080000:    rx <= 0;
    4160000:    rx <= 0;
    4240000:    rx <= 0;
    4320000:    rx <= 0;
    4400000:    rx <= 0;
    4480000:    rx <= 0;
    4560000:    rx <= 0;
    4640000:    rx <= 0;
    4720000:    rx <= 0;
    4800000:    rx <= 0;
    4880000:    rx <= 0;
    4960000:    rx <= 0;
    5040000:    rx <= 0;
    5120000:    rx <= 0;
    5200000:    rx <= 0;
    5280000:    rx <= 0;
    */
    endcase
end

// Load memory and register file contents
/*
initial
begin
    $readmemh("tests/data/verify", verify);

    if (verify[0] != 0) begin
        $display("Verify: %d\nCycles: %d", verify[0], verify[1]);
        $readmemh("tests/data/memory.expected", expected_memory);
        $readmemh("tests/data/regfile.expected", expected_regfile);
        $readmemh("tests/data/regfile.test", dut.datapath.registers.storage);
        $readmemh("tests/data/memory.test", dut.datapath.mem.storage);
        $display("Loaded memory and registers.");
    end
end

integer cycles = 0;
integer index = 0;
integer broken = 0;
always @ (negedge clock)
begin
    if (cycles != 0 && cycles == verify[1]) begin
        for (index = 0; index < 32; index = index + 1) 
            if (expected_regfile[index] != dut.datapath.registers.storage[index])
            begin
                $display("Regfile does not match at index %d.", index);
                $display("Expected: %h --- Found: %h\n", expected_regfile[index],
                    dut.datapath.registers.storage[index]);
                broken = 1;
            end

        for (index = 0; index < 65536; index = index + 1) 
            if (expected_memory[index] != dut.datapath.mem.storage[index])
            begin
                $display("Memory does not match at address %h", index);
                $display("Expected: %h --- Found: %h\n", expected_memory[index],
                    dut.datapath.mem.storage[index]);
                broken = 1;
            end

        if (broken == 1)
            $display("Test Failed.");
        else
            $display("Success.");
        $finish;
    end

    $display("FPGA State:");
    $display("Keys: %b", Keys);
    $display("Toggles: %b", Toggles);
    $display("Green: %b", Green);
    $display("Red: %b", Red);
    $display("Hex: (0 %b) (1 %b) (2 %b) (3 %b)", Hex0, Hex1, Hex2, Hex3);
    
    cycles = cycles + 1;
end
*/

endmodule
