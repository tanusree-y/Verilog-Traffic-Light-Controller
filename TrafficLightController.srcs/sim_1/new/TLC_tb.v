`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 10:13:10
// Design Name: 
// Module Name: TLC_tb
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


module TLC_tb();
reg clk, resetn, ped_req;
wire [2:0] highway_lights;
wire [2:0] farm_lights;

TLC dut (.clk(clk), .resetn(resetn), .ped_req(ped_req), .highway_lights(highway_lights), 
.farm_lights(farm_lights));

initial begin
clk = 0;
forever #5 clk = ~clk;
end
initial begin
resetn = 0;
ped_req = 0;
#10;
resetn = 1;
#20;
$display("Time = %0t | Pedestrian Triggering!", $time);
ped_req = 1;
#120;
ped_req = 0;
#50;
$finish;
end
endmodule