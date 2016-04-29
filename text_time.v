`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:22 03/29/2016 
// Design Name: 
// Module Name:    text_time 
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
module text_time
	 (
		input wire clk, IRQ,
		input wire [9:0] pix_x, pix_y,
		input wire [3:0] digUH, digDH, digUM, digDM, digUS, digDS, digUD, digDD, digUME, digDME, digUA, digDA, digUHC, digDHC, digUMC, digDMC, digUSC, digDSC,
		input wire horasiete, horasiete2,
		output wire [8:0] text_on,
		output reg [2:0] text_rgb
		
    );
	 
	wire[3:0] digFD = 4'b0010;
	wire[3:0] digFU = 4'b0000;
	    // signal declaration
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_fecha, char_addr_crono, char_addr_punto, char_addr_puntob, char_addr_puntoa,
             char_addr_hora, char_addr_digfecha, char_addr_dighora, char_addr_digcrono, char_addr_alarma;
   reg [3:0] row_addr;
   wire [3:0] row_addr_fecha, row_addr_crono, row_addr_hora, row_addr_digfecha, row_addr_puntoa,
				  row_addr_dighora, row_addr_digcrono, row_addr_alarma, row_addr_punto, row_addr_puntob;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_fecha, bit_addr_crono,bit_addr_hora, bit_addr_digfecha, bit_addr_punto, bit_addr_puntob,
				  bit_addr_dighora, bit_addr_digcrono, bit_addr_alarma, bit_addr_puntoa;
   wire [7:0] font_word;
   wire font_bit, fecha_on, crono_on, hora_on, digfecha_on, dighora_on, digcrono_on, alarma_on, punto_on, puntob_on, puntoa_on;
   wire [7:0] rule_rom_addr; 
	
	
	 // instantiate font ROM
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
		
	//texto fecha 
   assign fecha_on = (pix_y[9:5]==1) &&
                    (3<=pix_x[9:4]) && (pix_x[9:4]<=7);
   assign row_addr_fecha = pix_y[4:1];
   assign bit_addr_fecha = pix_x[3:1];
   always @*
      case(pix_x[8:4])
         3'h3: char_addr_fecha = 7'h46; // F
         3'h4: char_addr_fecha = 7'h65; // e
         3'h5: char_addr_fecha = 7'h63; // c
         3'h6: char_addr_fecha = 7'h68; // h

         default: char_addr_fecha = 7'h61; // a
      endcase
		
	
	//digitos de fecha
	
	assign digfecha_on = (pix_y[9:5]==2) &&
                    (3<=pix_x[9:4]) && (pix_x[9:4]<=12);
   assign row_addr_digfecha = pix_y[4:1];
   assign bit_addr_digfecha = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_digfecha = {3'b011, digDD}; // dig1(decenas)
         4'h4: char_addr_digfecha = {3'b011, digUD}; // dig0(unidades)
         4'h5: char_addr_digfecha = 7'h2f; // "/"
         4'h6: char_addr_digfecha = {3'b011, digDME};
			4'h7: char_addr_digfecha = {3'b011, digUME};
			4'h8: char_addr_digfecha = 7'h2f; // "/"
			4'h9: char_addr_digfecha = {3'b011, digFD};
			4'ha: char_addr_digfecha = {3'b011, digFU};
			4'hb: char_addr_digfecha = {3'b011, digDA};
			default: char_addr_digfecha = {3'b011, digUA}; 
      endcase
		
		
	//texto hora
	assign hora_on = (pix_y[9:5]==4) && (3<=pix_x[9:4]) && (pix_x[9:4]<=16);
   assign row_addr_hora = pix_y[4:1];
   assign bit_addr_hora = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_hora = 7'h48; // H
         4'h4: char_addr_hora = 7'h6f; // o
         4'h5: char_addr_hora = 7'h72; // r
			4'h6: char_addr_hora = 7'h61; // a
			4'h7: char_addr_hora = 7'h00; // 
			4'h8: char_addr_hora = 7'h00; // 
			4'h9: char_addr_hora = 7'h00; // 
			4'ha: char_addr_hora = 7'h00; // 
			4'hb: char_addr_hora = 7'h00; // 
			4'hc: char_addr_hora = 7'h41; // A
			4'hd: char_addr_hora = 7'h4d; // M
			4'he: char_addr_hora = 7'h00; // 
			4'hf: char_addr_hora = 7'h50; // P
			default: char_addr_hora =  7'h4d; //M
      endcase
		
	//texto punto AM/PM
	assign punto_on = (pix_y[9:5]==5) && (12<=pix_x[9:4]) && (pix_x[9:4]<=14);
   assign row_addr_punto = pix_y[4:1];
   assign bit_addr_punto = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'hc: char_addr_punto = 7'h28; // (
         4'hd: char_addr_punto = 7'h2a; // *
			default: char_addr_punto =  7'h29; //)
		endcase
		
	assign puntob_on = (pix_y[9:5]==5) && (15<=pix_x[9:4]) && (pix_x[9:4]<=17);
   assign row_addr_puntob = pix_y[4:1];
   assign bit_addr_puntob = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'hf: char_addr_puntob = 7'h28; // (
         4'h10: char_addr_puntob = 7'h2a; // *
			default: char_addr_puntob =  7'h29; //)
		endcase
		
	//digitos hora
	
	assign dighora_on = (pix_y[9:5]==5) &&(3<=pix_x[9:4]) && (pix_x[9:4]<=10);
   assign row_addr_dighora = pix_y[4:1];
   assign bit_addr_dighora = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_dighora = {3'b011, digDH}; // dig1(decenas)
         4'h4: char_addr_dighora = {3'b011, digUH}; // dig0(unidades)
         4'h5: char_addr_dighora = 7'h3a; // ":"
         4'h6: char_addr_dighora = {3'b011, digDM};
			4'h7: char_addr_dighora = {3'b011, digUM};
			4'h8: char_addr_dighora = 7'h3a; // ":"
			4'h9: char_addr_dighora = {3'b011, digDS};
			default: char_addr_dighora = {3'b011, digUS}; 
      endcase	
		
	//texto cronómetro
	
	assign crono_on = (pix_y[9:5]==7) && (3<=pix_x[9:4]) && (pix_x[9:4]<=12);
   assign row_addr_crono = pix_y[4:1];
   assign bit_addr_crono = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_crono = 7'h43; // C
         4'h4: char_addr_crono = 7'h72; // r
         4'h5: char_addr_crono = 7'h6f; // o
			4'h6: char_addr_crono = 7'h6e; // n
			4'h7: char_addr_crono = 7'h6f; // o
			4'h8: char_addr_crono = 7'h6d; // m
			4'h9: char_addr_crono = 7'h65; // e
			4'ha: char_addr_crono = 7'h74; // t
			4'hb: char_addr_crono = 7'h72; // r
			default: char_addr_crono =  7'h6f; //o
      endcase
		
		
	//Dígitos crónometros
	
	assign digcrono_on = (pix_y[9:5]==8) &&(3<=pix_x[9:4]) && (pix_x[9:4]<=10);
   assign row_addr_digcrono = pix_y[4:1];
   assign bit_addr_digcrono = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'h3: char_addr_digcrono = {3'b011, digDHC}; // dig1(decenas)
         4'h4: char_addr_digcrono = {3'b011, digUHC}; // dig0(unidades)
         4'h5: char_addr_digcrono = 7'h3a; // ":"
         4'h6: char_addr_digcrono = {3'b011, digDMC};
			4'h7: char_addr_digcrono = {3'b011, digUMC};
			4'h8: char_addr_digcrono = 7'h3a; // ":"
			4'h9: char_addr_digcrono = {3'b011, digDSC};
			default: char_addr_digcrono = {3'b011, digUSC}; 
      endcase	

	//texto alarma
		
	assign alarma_on = (pix_y[9:5]==10) && (3<=pix_x[9:4]) && (pix_x[9:4]<=8);
   assign row_addr_alarma = pix_y[4:1];
   assign bit_addr_alarma = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         3'h3: char_addr_alarma = 7'h41; // A
         3'h4: char_addr_alarma = 7'h6c; // l
         3'h5: char_addr_alarma = 7'h61; // a
			3'h6: char_addr_alarma = 7'h72; // r
			3'h7: char_addr_alarma = 7'h6d; // m
			default: char_addr_alarma =  7'h61; //a
      endcase
		
	assign puntoa_on = (pix_y[9:5]==10) && (10<=pix_x[9:4]) && (pix_x[9:4]<=12);
   assign row_addr_puntoa = pix_y[4:1];
   assign bit_addr_puntoa = pix_x[3:1];
   always @*
      case(pix_x[7:4])
         4'ha: char_addr_puntoa = 7'h28; // (
         4'hb: char_addr_puntoa = 7'h2a; // *
			default: char_addr_puntoa =  7'h29; //)
		endcase
		
		
		
	
   // mux for font ROM addresses and rgb
    always @*
   begin
      text_rgb = 3'b000;  // background, yellow
      if (fecha_on)
         begin
            char_addr = char_addr_fecha;
            row_addr = row_addr_fecha;
            bit_addr = bit_addr_fecha;
            if (font_bit)
               text_rgb = 3'b100;
         end
      else if (digfecha_on)
         begin
            char_addr = char_addr_digfecha;
            row_addr = row_addr_digfecha;
            bit_addr = bit_addr_digfecha;
            if (font_bit)
               text_rgb = 3'b100;
         end
      else if (hora_on)
         begin
            char_addr = char_addr_hora;
            row_addr = row_addr_hora;
            bit_addr = bit_addr_hora;
            if (font_bit)
               text_rgb = 3'b101;
         end
		else if (punto_on)
			begin
				if (horasiete)
					begin
						char_addr = char_addr_punto;
						row_addr = row_addr_punto;
						bit_addr = bit_addr_punto;
						if (font_bit)
							text_rgb = 3'b111;
					end
			end		
			
		else if (puntob_on)
			begin
				if (horasiete2)
					begin
						char_addr = char_addr_puntob;
						row_addr = row_addr_puntob;
						bit_addr = bit_addr_puntob;
						if (font_bit)
							text_rgb = 3'b111;
					end
			end	
			
		else if (puntoa_on)
			begin
				if (IRQ)
					begin
						char_addr = char_addr_puntoa;
						row_addr = row_addr_puntoa;
						bit_addr = bit_addr_puntoa;
						if (font_bit)
							text_rgb = 3'b111;
					end
			end	
			
		else if (dighora_on)
         begin
            char_addr = char_addr_dighora;
            row_addr = row_addr_dighora;
            bit_addr = bit_addr_dighora;
            if (font_bit)
               text_rgb = 3'b101;
         end
		else if (crono_on)
         begin
            char_addr = char_addr_crono;
            row_addr = row_addr_crono;
            bit_addr = bit_addr_crono;
            if (font_bit)
               text_rgb = 3'b001;
         end
      else if (digcrono_on)
         begin
            char_addr = char_addr_digcrono;
            row_addr = row_addr_digcrono;
            bit_addr = bit_addr_digcrono;
            if (font_bit)
               text_rgb = 3'b001;
         end
		else if (alarma_on)
			begin
            char_addr = char_addr_alarma;
            row_addr = row_addr_alarma;
            bit_addr = bit_addr_alarma;
            if (font_bit) 
               text_rgb = 3'b111;
         end
		else
			text_rgb = 3'b000;
	 
   end

   assign text_on = {fecha_on, digfecha_on, hora_on, dighora_on, crono_on, digcrono_on, alarma_on, punto_on, puntob_on, puntoa_on};
   //-------------------------------------------
   // font rom interface
   //-------------------------------------------
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];

endmodule
