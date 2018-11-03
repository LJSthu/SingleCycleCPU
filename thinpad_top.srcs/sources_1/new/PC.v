`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:33:05
// Design Name: 
// Module Name: PC
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
在时钟上升沿将PC的值改为NextPC
input: CLK: 时钟信号
       Reset: 清零
       PCHalt: 停机指令时不修改PC    0:PC不更改（halt之后）   1：PC正常更改为NextPC（其他指令执行之后）
       PCNext: 下一个PC
output:
        InstructionAddress
*/

module PC(CLK, Reset, PCHalt, PCNext, InstructionAddress);
input CLK, Reset;
input [31:0] PCNext;
input PCHalt;
output reg[31:0] InstructionAddress;

initial begin
    InstructionAddress =0;
end

always @(posedge CLK or negedge Reset)
begin 
    if (Reset == 0) InstructionAddress <= 32'hFFFFFFFC;
    else if (PCHalt == 1 || PCNext == 0) InstructionAddress <= PCNext;
end
endmodule