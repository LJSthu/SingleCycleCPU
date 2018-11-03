`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:40:41
// Design Name: 
// Module Name: SignZeroExtend
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

/*
根据选择信号来完成符号扩展或者0扩展
input:
        Immediate: 输入的16位立即数
        ExtSel： 选择信号（1的时候进行符号扩展；0的时候补0--逻辑扩展）
output:
        ExtendedOut: 扩展之后的结果
*/

module SignZeroExtend(Immediate,ExtSel, ExtendedOut);
input [15:0] Immediate;
input ExtSel;
output [31:0] ExtendedOut;

assign ExtendedOut[15:0] = Immediate[15:0];                   // 后16位直接赋值
assign ExtendedOut[31:16] = (ExtSel == 1 && (Immediate[15]==1))?16'hFFFF:16'h0000;   //扩展的前16位根据信号来进行赋值
endmodule

