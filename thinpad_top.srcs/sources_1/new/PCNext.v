`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:40:41
// Design Name: 
// Module Name: PCNext
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
根据PCJudge，选择三个PC输入中的一个输出到PC中，Immediate 为立即数，PC为上一条指令地址 
input:  PC: 上一个PC的值
        Immediate: PC上加一个立即数    beq
        PCJump：jump+ immediate 通过取PC高四位拼接而成（JumpPC.v中的模块） jump
        Reset: 优先清零，使得下一个PC指向PC+4  
        Jump: 是否是jump指令
        Branch: 是否是beq指令
        zero: ALU的结果是不是0
output: PCNext: 更新之后的32位的PC值
*/

module PCNext( Reset, PC, Immediate, PCJump, Jump, Branch, zero, PCNext);
input Reset;
input [31:0] PC, Immediate,PCJump;
input Jump, Branch, zero;
output reg [31:0] PCNext;

always @( Branch or Jump or zero or PCJump or Immediate) begin
    if(Reset == 0) PCNext=PC+4;
    begin
        if (Jump == 1)
        begin
            PCNext = PCJump;
        end
        else if (Branch == 1 && zero == 1)
            PCNext = PC + 4 + (Immediate << 2);
        else
            PCNext = PC + 4;
    end
end
endmodule
