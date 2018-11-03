`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:40:41
// Design Name: 
// Module Name: PCJump
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

/* 将jump跳转指令中的26位数字拼接成为32位的地址
*
*input: PC: 当前指令寄存器中的地址
        InAddr: 跳转指令后加的立即数
*ouput: 拼接好的跳转的32位目的地址
*/
module PCJump(PC, InAddr, Out);
input [31:0] PC;
input [25:0] InAddr;
output reg [31:0] Out;

always @(PC or InAddr)
begin
    Out[31:28]=PC[31:28];
    Out[27:0] = { InAddr, 2'b00};
end
endmodule
