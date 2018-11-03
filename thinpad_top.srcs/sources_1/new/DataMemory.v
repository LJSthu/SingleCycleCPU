`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/30 17:18:59
// Design Name: 
// Module Name: DataMemory
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
数据存储内存
input:
        CLK: 时钟信号
        DataAddress: 数据对应的地址
        WriteData:  要写入的数据
        MemWrite:   写内存信号
        MemRead:    读内存信号

output：
        DataMemoryOut: 输出的数据
*/

module DataMemory(CLK, DataAddress, WriteData, MemWrite, MemRead, DataMemoryOut);
input [31:0] DataAddress,WriteData;
input CLK, MemRead, MemWrite;
output [31:0] DataMemoryOut;

reg [7:0] memory[0:60];

integer i;
initial begin  //初始化清零数据内存
    for(i = 0;i < 60;i = i+1)
        begin
            memory[i] = 0;
        end
end

assign DataMemoryOut[7:0] = (MemRead==1)?memory[DataAddress+3]:8'bz;
assign DataMemoryOut[15:8] = (MemRead==1)?memory[DataAddress+2]:8'bz;
assign DataMemoryOut[23:16] = (MemRead==1)?memory[DataAddress+1]:8'bz;
assign DataMemoryOut[31:24] = (MemRead== 1)?memory[DataAddress]:8'bz;     //如果是从内存中读，就直接持续赋值，如果是写，就设置为高阻态

//大端存储，高位放在低位，连续的地址相差4个字节
always @(negedge CLK)
begin
    if (MemWrite == 1) begin
        memory[DataAddress]    <= WriteData[31:24];
        memory[DataAddress + 1]<= WriteData[23:16];
        memory[DataAddress + 2]<= WriteData[15:8];
        memory[DataAddress + 3]<= WriteData[7:0];
        end
end

endmodule
