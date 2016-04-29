`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:14 03/07/2016 
// Design Name: 
// Module Name:    antirebotebotones 
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
module AntiRebote_Botones(
input wire D,
input clk, 
output reg activar
	);
reg X1; 
reg X2;
reg X3;
reg A;

always @(posedge clk)
	begin
		X1 <= D;
		X2 <= X1;
		X3 <= X2;
		A <= (D & X1 & X2 & X3);
	end
	
always @(A)
	if (A)
		activar = 1;
	else
		activar = 0;

endmodule
