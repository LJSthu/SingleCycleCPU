`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:33:05
// Design Name: 
// Module Name: select32bits
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
选择32位的数据     ALU的操作数，最后写回的data
input:
        Select: 选择信号
output:
        Data: 选择之后的信号
*/

module Select32bits(Select, DataA, DataB, Data);
input Select;
input [31:0] DataA, DataB;
output [31:0] Data;
    assign Data = Select?DataB:DataA;
endmodule
