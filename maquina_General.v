`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:58 04/05/2016 
// Design Name: 
// Module Name:    maquina_General 
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
module maquina_General(
   input wire reset,clk,Fin_W,Fin_L,Fin_I,SW_prog_clk,SW_Activar,
	output wire [3:0] ctrl_G
    );
	 
	reg [3:0] control_A,control_N;
	reg [3:0] Est_Actual,Est_Sig;
	localparam [3:0] a=4'b0000,b=4'b0001,c=4'b0010,d=4'b0011,e=4'b0100,f=4'b0101,g=4'b0110,h=4'b0111,i=4'b1000;
	 
always @ (posedge clk, posedge reset)
	begin 
		if (reset)
			begin
			Est_Actual=4'b0000;
			control_A=4'b0000;
			end
		else
			begin
			Est_Actual=Est_Sig;
			control_A=control_N;
			end
	end 

always @* 
	begin
	Est_Sig=Est_Actual;
	control_N=control_A;
	case(Est_Actual)
			a:
			begin
			control_N=4'b0000;
			if(SW_Activar)
				begin
				Est_Sig=b;
				end
			else
				begin
				Est_Sig=a;
				end
			end 
			
			b:
			begin 
				control_N=4'b0001;
				Est_Sig=c;
			end

			c:
			begin 
				control_N=4'b0010;
				if (Fin_I)
					begin
					Est_Sig=d;
					end
				else
					begin
					Est_Sig=c;
					end
			end
			
			d:
			begin 
				control_N=4'b0011;
				Est_Sig=e;
			end
			
			e:
			begin 
				control_N=4'b0100;
				if (Fin_W)
					begin
					Est_Sig=f;
					end
				else
					begin
					Est_Sig=e;
					end
			end
					
			f:
			begin 
				control_N=4'b0101;
				Est_Sig=g;
			end
			
			g:
			begin 
				control_N=4'b0110;
				if (Fin_L)
					begin
					Est_Sig=h;
					end
				else
					begin
					Est_Sig=g;
					end
			end
			
			h:
			begin
				control_N=4'b0111;
				if (SW_prog_clk)
					begin
					Est_Sig=d;
					end
				else
					begin
					Est_Sig=i;
					end
			end
			
			i:
			begin
				control_N=4'b1000;
				if (reset)
					begin
					Est_Sig=a;
					end
				else
					begin
					Est_Sig=f;
					end
			end
				
			default:Est_Sig=a;
			
			endcase
		
		end
				
assign ctrl_G = control_A;

endmodule
