`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:51 03/30/2016 
// Design Name: 
// Module Name:    top_vga 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_vga
	 (
		input wire clk, reset, IRQ,
		input wire [3:0] digUH, digDH, digUM, digDM, digUS, digDS, digUD, digDD, digUME, digDME, digUA, digDA, digUHC, digDHC, digUMC, digDMC, digUSC, digDSC,
		input wire horasiete, horasiete2,
		output wire hsync,vsync,
		output wire [2:0] text_rgb
		
    );
	 
	 //declaración de señales 
	 wire video_on, p_tick;
	 wire [9:0] pix_x, pix_y;
	 wire [5:0] text_on;
	 reg clk1 = 1'b0;
	 
	 //divisor
	 always @(posedge clk)
		clk1 = ~clk1;

	//instancio vga_sync
	 vga_sync vgasync_unit(.clk(clk1), .reset(reset), .hsync(hsync), .vsync(vsync),.video_on(video_on), .p_tick(p_tick), .pixel_x(pix_x), .pixel_y(pix_y));
		 
   // instancio text_time
	text_time text_unit (.clk(clk),.IRQ(IRQ),.horasiete(horasiete), .horasiete2(horasiete2), .pix_x(pix_x), .pix_y(pix_y),.digUH(digUH), .digDH(digDH), .digUM(digUM), .digDM(digDM), .digUS(digUS), .digDS(digDS), .digUD(digUD), .digDD(digDD), .digUME(digUME), .digDME(digDME), .digUA(digUA), .digDA(digDA), .digUHC(digUHC), .digDHC(digDHC), .digUMC(digUMC), .digDMC(digDMC), .digUSC(digUSC), .digDSC(digDSC),  .text_on(text_on),  .text_rgb(text_rgb));



endmodule
