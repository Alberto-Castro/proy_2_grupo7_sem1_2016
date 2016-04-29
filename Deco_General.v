`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:22 04/05/2016 
// Design Name: 
// Module Name:    Deco_General 
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
module Deco_General(
   input wire [3:0] ctrl_G,
	output reg Inicio_W,Inicio_L,Inicio_I,
	output reg [1:0] dir_sel
    );

always @* 
	
	case(ctrl_G)
	
		4'b0000: //a 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b11;
			end
		
		4'b0001: //b 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 1;
			dir_sel = 2'b10;
			end
			
		4'b0010: //c 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b10;
			end
			
		4'b0011: //d 
			begin		
			Inicio_W = 1;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b01;
			end
			
		4'b0100: //e 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b01;
			end
			
		4'b0101: //f 
			begin		
			Inicio_W = 0;
			Inicio_L = 1;
			Inicio_I = 0;
			dir_sel = 2'b00;
			end
			
		4'b0110: //g 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b00;
			end
		
		4'b0111: //h 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b00;
			end
		
		4'b1000: //i 
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b11;
			end
			
		default:
			begin		
			Inicio_W = 0;
			Inicio_L = 0;
			Inicio_I = 0;
			dir_sel = 2'b11;
			end
		endcase
endmodule
