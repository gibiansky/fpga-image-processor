module serial_read(
	input clk_24,
	input rx,
	output reg ready,
	output reg [7:0] out
	);

// Convert our clock to 9600 hertz.
reg [15:0] clk_counter = 16'b0;
always @(posedge clk_24) begin
	if (clk_counter === 16'd20000)
		clk_counter = 0;
	else
		clk_counter <= clk_counter + 1;
end
wire clk = (clk_counter == 16'd20000);

// Serial port reader state.
parameter STATE_IDLE 		= 4'd0;
parameter STATE_START_BIT 	= 4'd1;
parameter STATE_BIT0 		= 4'd2;
parameter STATE_BIT1 		= 4'd3;
parameter STATE_BIT2 		= 4'd4;
parameter STATE_BIT3 		= 4'd5;
parameter STATE_BIT4 		= 4'd6;
parameter STATE_BIT5 		= 4'd7;
parameter STATE_BIT6 		= 4'd8;
parameter STATE_BIT7 		= 4'd9;
parameter STATE_STOP_BIT	= 4'd10;

// Indicates current state.
reg [3:0] state = STATE_IDLE;

// Idle state machine.
reg [2:0] seen;

// Internal clock that ticks once per baud
parameter INIT_BAUD_COUNT = 3'b111;
reg [2:0] baud_count = INIT_BAUD_COUNT;
wire baud_clk = (baud_count == 3'b0);

// Oversample RX at the clock frequency.
always @(posedge clk) begin
	case (state)
		STATE_IDLE:
			if (~rx) begin
				if (seen == 3'b10) begin
					state <= STATE_START_BIT;
					seen <= 3'b0;
				end else
					seen <= seen + 1;
			end
	endcase
	
	if (state != STATE_IDLE) begin
		if (baud_count == 3'b111)
			baud_count <= 3'b0;
		else
			baud_count <= baud_count + 1;
	end
end

// Compute the next state.
reg [3:0] next_state = STATE_IDLE;
always @(*) begin
	case (state)
		STATE_START_BIT:
			if (rx)
				next_state <= STATE_IDLE;
			else
				next_state <= STATE_BIT0;
		
		STATE_BIT0: next_state <= STATE_BIT1;
		STATE_BIT1: next_state <= STATE_BIT2;
		STATE_BIT2: next_state <= STATE_BIT3;
		STATE_BIT3: next_state <= STATE_BIT4;
		STATE_BIT4: next_state <= STATE_BIT5;
		STATE_BIT5: next_state <= STATE_BIT6;
		STATE_BIT6: next_state <= STATE_BIT7;
		STATE_BIT7: next_state <= STATE_STOP_BIT;
		
		STATE_STOP_BIT: next_state <= STATE_START_BIT;
	endcase
end

// Advance to the next state.
always @(posedge baud_clk) begin
	state <= next_state;
	case (state) 
		// Read into the output buffer.
		STATE_BIT0: out[7] <= rx;
		STATE_BIT1: out[6] <= rx;
		STATE_BIT2: out[5] <= rx;
		STATE_BIT3: out[4] <= rx;
		STATE_BIT4: out[3] <= rx;
		STATE_BIT5: out[2] <= rx;
		STATE_BIT6: out[1] <= rx;
		STATE_BIT7: out[0] <= rx;
		
		// Declare the output to be ready when we finish reading,
		// and clear it once we hit another start bit.
		STATE_STOP_BIT:
			ready <= 1'b1;
		STATE_START_BIT:
			ready <= 1'b0;
	endcase
end
	
endmodule