module serial_read(
	input clk_24,
	input rx,
	output reg ready = 0,
	output reg [7:0] out = 8'b0
	);

// Downsample our clock to 9600 hertz.
parameter DOWNSAMPLE_24MHZ_CLOCK = 16'd20000;
reg [15:0] clk_counter = 16'b0;
always_ff @(posedge clk_24) begin
	if (clk_counter == DOWNSAMPLE_24MHZ_CLOCK)
		clk_counter <= 0;
	else
		clk_counter <= clk_counter + 1'b1;
end
wire clk = (clk_counter == DOWNSAMPLE_24MHZ_CLOCK);

// Serial port reader states.
parameter STATE_IDLE 		= 4'd0;
parameter STATE_START_BIT 	= 4'd3;
parameter STATE_BIT0 		= 4'd4;
parameter STATE_BIT1 		= 4'd5;
parameter STATE_BIT2 		= 4'd6;
parameter STATE_BIT3 		= 4'd7;
parameter STATE_BIT4 		= 4'd8;
parameter STATE_BIT5 		= 4'd9;
parameter STATE_BIT6 		= 4'd10;
parameter STATE_BIT7 		= 4'd11;
parameter STATE_STOP_BIT	= 4'd12;

// Current state.
reg [3:0] state = STATE_IDLE;
reg [1:0] idle_counter = 2'd0;

// Compute the next state.
reg [3:0] next_state = STATE_IDLE;
always_comb begin
	case (state)
		// Count number of times a low bit has been seen. 
		// Once we've seen it enough, switch to the start bit.
		STATE_IDLE:
			next_state = (idle_counter == 2'b10) ? STATE_START_BIT : STATE_IDLE;
			
		STATE_START_BIT:
			// In the start bit, if we see a high bit, that means that 
			// we're not actually on a start bit. That means the channel must be
			// idle, and transmission is done. Therefore, switch to idle if the received 
			// value is high (i.e. idle line) instead of expected low (start bit).
                        next_state = rx ? STATE_IDLE : STATE_BIT0;
		
		// Advance through the bits we're reading into.
		STATE_BIT0: next_state = STATE_BIT1;
		STATE_BIT1: next_state = STATE_BIT2;
		STATE_BIT2: next_state = STATE_BIT3;
		STATE_BIT3: next_state = STATE_BIT4;
		STATE_BIT4: next_state = STATE_BIT5;
		STATE_BIT5: next_state = STATE_BIT6;
		STATE_BIT6: next_state = STATE_BIT7;
		STATE_BIT7: next_state = STATE_STOP_BIT;
		
		// Reading is done. Reset to the first bit!
		STATE_STOP_BIT: next_state = STATE_START_BIT;
		
		// Should never happen.
		default: next_state = STATE_IDLE;
	endcase
end

// Downsample the oversampled clock to a baud clock.
// The baud clock will tick exactly once per bit.
// When the line is idle, the baud count should be one tick away from
// having the baud clock go through a positive edge.
parameter INIT_BAUD_COUNT = 3'b111;
reg [2:0] baud_count = INIT_BAUD_COUNT;
wire baud_clk = (baud_count == 3'b0);

// Tick the baud clock if the state isn't idle.
always @(posedge clk) begin
	case (next_state)
		// When idle, don't increment baud count, because we aren't
		// synced. Instead, reset to initial value.
		STATE_IDLE: begin
			baud_count <= INIT_BAUD_COUNT;
                        idle_counter <= idle_counter + 2'b1;
		end
		
		// When active, tick the baud clock.
                default: begin
                        baud_count <= baud_count + 1'b1;
                        idle_counter <= 2'b00;
                end

	endcase
end

// Advance to the next state.
always_ff @(posedge baud_clk) begin
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
			
		default:
			ready <= 1'b0;
	endcase
end
	
endmodule
