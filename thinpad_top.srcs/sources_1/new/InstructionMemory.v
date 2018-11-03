`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ljs
// 
// Create Date: 2018/10/30 17:18:59
// Design Name: 
// Module Name: InstructionMemory
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
将本地的txt文件作为指令内存，实现一个指令内存模块
input:
        InstructionAddress: 指令的地址
output：
        InstructionOut: 取出来的指令
*/
module InstructionMemory(InstructionAddress, InstructionOut);
input [31:0] InstructionAddress;
output reg [31:0] InstructionOut;
integer i;
reg [7:0] Memory[0:99];
// 初始化函数，将txt作为内存
initial begin
    $readmemb("C:/Users/liujiashuo/Desktop/computerPrinciple/homework4/CPUInsMem.txt",Memory);       // 读入本地的txt文件作为内存
    for(i=0;i<24;i=i+1)  
        $display("%h%h%h%h",Memory[i*4+0],Memory[i*4+1],Memory[i*4+2],Memory[i*4+3]);    // 显示出来读入的命令
end

always @(InstructionAddress) begin       // 根据地址将指令读出
    begin
        InstructionOut[31:24]=Memory[InstructionAddress];
        InstructionOut[23:16]=Memory[InstructionAddress+1];
        InstructionOut[15:8]=Memory[InstructionAddress+2];
        InstructionOut[7:0]=Memory[InstructionAddress+3];
     end
end

endmodule

