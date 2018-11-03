`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:33:05
// Design Name: 
// Module Name: RegisterHeap
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
完成寄存器堆的相关操作
input:
        ReadReg1: 第一个寄存器的编号
        ReadReg2: 第二个寄存器的编号
        WriteData； 写回的数据
        WriteReg: 写入的寄存器编号
        WE: 控制信号Register write          1为写入
        CLK: 时钟信号                       在时钟的下降沿将需要写回寄存器的值写入
output:
        ReadData1: 输出的第一个操作数
        ReadData2: 输出的第二个操作数
*/

module RegisterHeap(ReadReg1, ReadReg2, WriteData, WriteReg, ReadData1, ReadData2, WE, CLK, reg1, reg2, reg3);
input[4:0] ReadReg1, ReadReg2, WriteReg;
input WE, CLK;
input [31:0] WriteData;
output [31:0] ReadData1, ReadData2;
output [31:0] reg1, reg2, reg3;

integer i;
reg [31:0] Register[0:31];

initial begin        // 最开始的时候初始化整个寄存器组，只执行一次
for(i=0;i<32;i=i+1)
    Register[i]=0;
end

assign ReadData1 = Register[ReadReg1];
assign ReadData2 = Register[ReadReg2];
assign reg1 = Register[1];
assign reg2 = Register[2];
assign reg3 = Register[3];

always @(negedge CLK)
begin
   if (WE == 1 && WriteReg!=0) Register[WriteReg]<=WriteData;
end
endmodule
