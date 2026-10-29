`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 00:07:10
// Design Name: 
// Module Name: TLC
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


module TLC(
input clk, resetn, ped_req,
output reg [2:0] highway_lights,
output reg [2:0] farm_lights);
    
localparam S0_HW_GREEN = 2'b00;
localparam S1_HW_YELLOW = 2'b01;
localparam S2_FM_GREEN = 2'b10;
localparam S3_FM_YELLOW = 2'b11;
localparam RED = 3'b100;
localparam YELLOW = 3'b010;
localparam GREEN = 3'b001;

reg [3:0] count;
reg [1:0] state, next_state;

always@(*) begin
next_state = state;
case(state)
S0_HW_GREEN: if(count >= 4'd3 && ped_req) next_state = S1_HW_YELLOW;
else next_state = S0_HW_GREEN;
S1_HW_YELLOW: if(count >= 4'd0) next_state = S2_FM_GREEN;
else next_state = S1_HW_YELLOW;
S2_FM_GREEN: if(count >= 4'd2) next_state = S3_FM_YELLOW;
else next_state = S2_FM_GREEN;
S3_FM_YELLOW: if(count >= 4'd0) next_state = S0_HW_GREEN;
else next_state = S3_FM_YELLOW;
default: next_state = S0_HW_GREEN;
endcase
end

always @(posedge clk or negedge resetn) begin
if (!resetn) begin
state <= S0_HW_GREEN;
count <= 4'd0;
end else begin
state <= next_state;
if (state != next_state) count <= 4'd0;
else count <= count + 4'd1;
end
end

always@(*) begin
case(state)
S0_HW_GREEN: begin
highway_lights = GREEN;
farm_lights = RED;
end
S1_HW_YELLOW: begin
highway_lights = YELLOW;
farm_lights = RED;
end
S2_FM_GREEN: begin
highway_lights = RED;
farm_lights = GREEN;
end
S3_FM_YELLOW: begin
highway_lights = RED;
farm_lights = YELLOW;
end
default: begin
highway_lights = RED;
farm_lights = RED;
end
endcase
end
endmodule