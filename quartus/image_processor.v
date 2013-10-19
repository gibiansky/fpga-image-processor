// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

module image_processor
(
// {ALTERA_ARGS_BEGIN} DO NOT REMOVE THIS LINE!

	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,
	CLOCK_24,
	CLOCK_27,
	CLOCK_50,
	DRAM_ADDR,
	DRAM_BA_0,
	DRAM_BA_1,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_LDQM,
	DRAM_RAS_N,
	DRAM_UDQM,
	DRAM_WE_N,
	EXT_CLOCK,
	FL_ADDR,
	FL_CE_N,
	FL_DQ,
	FL_OE_N,
	FL_RST_N,
	FL_WE_N,
	GPIO_0,
	GPIO_1,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	I2C_SCLK,
	I2C_SDAT,
	KEY,
	LEDG,
	LEDR,
	PS2_CLK,
	PS2_DAT,
	SD_CLK,
	SD_CMD,
	SD_DAT,
	SD_DAT3,
	SRAM_ADDR,
	SRAM_CE_N,
	SRAM_DQ,
	SRAM_LB_N,
	SRAM_OE_N,
	SRAM_UB_N,
	SRAM_WE_N,
	SW,
	TCK,
	TCS,
	TDI,
	TDO,
	UART_RXD,
	UART_TXD,
	VGA_B,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_VS,
	rx,
	tx,
	ps2c,
	ps2d,
	i2c_sclk,
	i2c_sdat,
	m_clk,
	b_clk,
	dac_lr_clk,
	dacdat,
	adc_lr_clk,
	adcdat,
	hsync,
	vsync,
	sram_ce_n,
	sram_lb_n,
	sram_oe_n,
	sram_ub_n,
	sram_we_n,
	reset,
	sw,
	key,
	ledr,
	ledg,
	hex0,
	hex1,
	hex2,
	hex3,
	rgb,
	sram_addr,
	sram_dq
// {ALTERA_ARGS_END} DO NOT REMOVE THIS LINE!

);

// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
input			AUD_ADCDAT;
inout			AUD_ADCLRCK;
inout			AUD_BCLK;
output			AUD_DACDAT;
inout			AUD_DACLRCK;
output			AUD_XCK;
input	[1:0]	CLOCK_24;
input	[1:0]	CLOCK_27;
input	[0:0]	CLOCK_50;
output	[11:0]	DRAM_ADDR;
output			DRAM_BA_0;
output			DRAM_BA_1;
output			DRAM_CAS_N;
output			DRAM_CKE;
output			DRAM_CLK;
output			DRAM_CS_N;
inout	[15:0]	DRAM_DQ;
output			DRAM_LDQM;
output			DRAM_RAS_N;
output			DRAM_UDQM;
output			DRAM_WE_N;
input			EXT_CLOCK;
output	[21:0]	FL_ADDR;
output			FL_CE_N;
inout	[7:0]	FL_DQ;
output			FL_OE_N;
output			FL_RST_N;
output			FL_WE_N;
inout	[35:0]	GPIO_0;
inout	[35:0]	GPIO_1;
output	[6:0]	HEX0;
output	[6:0]	HEX1;
output	[6:0]	HEX2;
output	[6:0]	HEX3;
output			I2C_SCLK;
inout			I2C_SDAT;
input	[3:0]	KEY;
output	[7:0]	LEDG;
output	[9:0]	LEDR;
input			PS2_CLK;
input			PS2_DAT;
output			SD_CLK;
inout			SD_CMD;
inout			SD_DAT;
inout			SD_DAT3;
output	[17:0]	SRAM_ADDR;
output			SRAM_CE_N;
inout	[15:0]	SRAM_DQ;
output			SRAM_LB_N;
output			SRAM_OE_N;
output			SRAM_UB_N;
output			SRAM_WE_N;
input	[9:0]	SW;
input			TCK;
input			TCS;
input			TDI;
output			TDO;
input			UART_RXD;
output			UART_TXD;
output	[3:0]	VGA_B;
output	[3:0]	VGA_G;
output			VGA_HS;
output	[3:0]	VGA_R;
output			VGA_VS;
input			rx;
input			tx;
input			ps2c;
input			ps2d;
input			i2c_sclk;
input			i2c_sdat;
input			m_clk;
input			b_clk;
input			dac_lr_clk;
input			dacdat;
input			adc_lr_clk;
input			adcdat;
input			hsync;
input			vsync;
input			sram_ce_n;
input			sram_lb_n;
input			sram_oe_n;
input			sram_ub_n;
input			sram_we_n;
input			reset;
input	[0:9]	sw;
input	[0:3]	key;
input	[0:9]	ledr;
input	[0:7]	ledg;
input	[0:6]	hex0;
input	[0:6]	hex1;
input	[0:6]	hex2;
input	[0:6]	hex3;
input	[0:11]	rgb;
input	[0:17]	sram_addr;
input	[0:15]	sram_dq;

assign ledg = sw[7:0];

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule
