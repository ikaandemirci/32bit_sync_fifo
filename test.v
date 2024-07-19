`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2024 22:46:10
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test();
    reg         clk      = 0;
    reg         wr_en    = 0;
    reg         rd_en    = 0;
    reg         rst      = 0;
    reg  [31:0] data_in  = 0;
     
    
    
top top_tb(
    .i_clk(clk),
    .i_rst(rst),
    .i_data_in(data_in),
    .i_wr_en(wr_en),
    .i_rd_en(rd_en),
    .o_data_out(),
    .o_full(),
    .o_empty(),
    .o_almost_full(),
    .o_almost_empty(),
    .o_used_slot()
    );
    
   always begin
      clk = 1'b1;
      #5 clk = 1'b0;
      #5;
   end   
   initial begin
      rst = 1;
      #10;
      rst =0;
      wr_en = 1;
      rd_en = 0;
      data_in = 31'd12;
      #10;
      rst =0;
      wr_en = 1;
      rd_en = 0;
      data_in = 31'd15;
      #10;
      rst =0;
      wr_en = 1;
      rd_en = 0;
      data_in = 31'd17;
      #10;
      rst =0;
      wr_en = 1;
      rd_en = 0;
      data_in = 31'd19;
      #10;
      rst =0;
      wr_en = 0;
      rd_en = 1;
      data_in = 31'd21;
      #10;
      rst =0;
      wr_en = 1;
      rd_en = 1;
      data_in = 31'd23;
      #10;
      rst =0;
      wr_en = 0;
      rd_en = 1;
      data_in = 31'd25;
      #50;
         
   end   
   
    
    
endmodule
