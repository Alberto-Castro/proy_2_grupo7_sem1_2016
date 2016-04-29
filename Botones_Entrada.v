`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:42:25 04/13/2016 
// Design Name: 
// Module Name:    Botones_Entrada 
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
module Botones_Entrada(
	input clk,reset,D,
	output Entrada
    );

FMS_AntiRebote Maquina_AntiRebote (
    .activar(activar), 
    .clk(clk), 
    .reset(reset), 
    .Entrada(Entrada)
    );

AntiRebote_Botones AntiRebote (
    .D(D), 
    .clk(clk), 
    .activar(activar)
    );

endmodule
