`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2024 21:03:22
// Design Name: 
// Module Name: top
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


module top(
    input           i_clk,
    input           i_rst,
    input  [31:0]   i_data_in,
    input           i_wr_en,
    input           i_rd_en,
    output reg  [31:0]   o_data_out,
    output          o_full,
    output          o_empty,
    output          o_almost_full,// 95% DEPTH = 1946
    output          o_almost_empty,
    output [11:0]   o_used_slot
    );
    
    parameter    DEPTH = 2048;
    parameter    WIDTH = 32;
                
    reg [10:0]   r_counter_wr = 0;
    reg [10:0]   r_counter_rd = 0;
    reg [31:0]   r_storage[(DEPTH-1):0];
    reg [11:0]   r_used_slot = 0;
    
    always@(posedge i_clk)
    begin
    
      if(i_rst == 0)
      begin
        // WRITING PROCESS     
        if(i_wr_en && !o_full)
        begin
        
          r_storage [r_counter_wr] <= i_data_in ;
          r_used_slot              <= r_used_slot  + 1;
          r_counter_wr             <= r_counter_wr + 1;  
          
          
        end
        
        // READING PROCESS
        if(i_rd_en && !o_empty)
        begin
        
          o_data_out    <= r_storage [r_counter_rd];
          r_used_slot   <= r_used_slot - 1;
          r_counter_rd  <= r_counter_rd + 1;
          
        end
        
        if(i_rd_en && i_wr_en)
        begin
          r_used_slot   <= r_used_slot;
        end
        
      end       
      else
      begin
          r_counter_wr  <= 1'b0;
          r_counter_rd  <= 1'b0;
          r_used_slot   <= 12'd0; 
      end
      
    end
    
    assign o_full  = (r_counter_rd == ( r_counter_wr  + 1'b1 )) ? 1'b1 : 1'b0;
    assign o_empty = (r_counter_rd == r_counter_wr) ? 1'b1 : 1'b0;
    
    assign o_almost_full  = (o_used_slot > 1945) ?  1'b1 : 1'b0;
    assign o_almost_empty = (o_used_slot < 102)  ?  1'b1 : 1'b0;
    assign o_used_slot = (r_used_slot > 2048) ? 1'b0 : r_used_slot;
    
    
    
    
    
endmodule
