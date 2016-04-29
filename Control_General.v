`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:34 04/05/2016 
// Design Name: 
// Module Name:    Control_General 
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
module Control_General(
	input wire reset,clk,Fin_W,Fin_L,Fin_I,SW_prog_clk,SW_Activar,
	output wire Inicio_W,Inicio_L,Inicio_I,
	output wire [1:0] dir_sel
    );

wire [3:0] ctrl_G;

maquina_General FMS_General (
    .reset(reset), 
    .clk(clk), 
    .Fin_W(Fin_W), 
    .Fin_L(Fin_L), 
    .Fin_I(Fin_I), 
    .SW_prog_clk(SW_prog_clk),
	 .SW_Activar(SW_Activar),
    .ctrl_G(ctrl_G)
    );	

Deco_General Deco_General (
    .ctrl_G(ctrl_G),
    .Inicio_W(Inicio_W), 
    .Inicio_L(Inicio_L), 
    .Inicio_I(Inicio_I),
	 .dir_sel(dir_sel)
    ); 

endmodule
