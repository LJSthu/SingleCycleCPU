`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:33:05
// Design Name: 
// Module Name: select5bits
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
选择register destination
input:
        DataA, DataB: 待选择的两个寄存器
        Select: 目标寄存器的选择信号
output:
        Data: 选择之后的目标寄存器
*/


module Select5bits(
    input Select,
    input [4:0] DataA, DataB,
    output [4:0] Data
    );
    assign Data = Select?DataB:DataA;
endmodule
