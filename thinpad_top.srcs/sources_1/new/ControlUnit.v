`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/29 17:33:05
// Design Name: 
// Module Name: ControlUnit
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
TODO: 列出控制信号以及对应的指令，再完成这里的部分
根据输入的指令来生成控制信号
input:  Op:从内存中读出的指令的开头
        zero  没看明白，似乎只影响 PC的下一个值    TODO
output: 
        PCHalt:PC要不要更新，                                             为1是更新，0的话PC保持不动，只需要判断是不是halt指令
        PCJudge: 选择PC的下一条指令的跳转位置                              beq：01    jump:10     else:00
        ALUSrc: ALU第二个操作数的选择信号                                  0是选择寄存器堆的输出，1是选择立即数扩展
        RegDst: 寄存器堆的写入寄存器的选择                                 0是选择【20-16】，1是选择【15-11】
        RegWrite: 寄存器堆是否写回的控制                                   1是将结果写回，0是不写回
        ALUOp: 控制ALU进行哪种运算                                         (add, 000) (sub, 001) (ori, 011) (lw, 000) (sw, 000) (beg, 001)                                   
        MemoryWrite: 是否写入数据内存区                                    0是不需要写入，1是需要写入
        MemoryRead: 是否从数据内存中读取数据                               0是不要，1是要读取
        MemtoReg: 写回寄存器组的数据来源                                    0是从ALU中获得的计算结果，1是从内存中读取出来的
        Jump: 是否是jump指令                                               1是，0不是
        Branch: 是否是beq指令           
OP值：
add: 000 000
sub: 000 001
ori: 001 101
lw:  100 011
sw:  101 011
beq: 000 100
jump:000 010
        

*/

module ControlUnit(Op, PCHalt, PCJudge, ALUSrc, RegDst, RegWrite, ALUOp, MemoryWrite, MemoryRead, MemtoReg, Jump, Branch, ExtSel);
input [5:0] Op;
output PCHalt, ALUSrc, RegDst, RegWrite, MemoryWrite, MemoryRead,Jump, Branch, MemtoReg, ExtSel;
output [1:0] PCJudge;
output [2:0] ALUOp;
assign PCHalt = (Op == 6'b111111)?0:1;    //只需要判断当前指令是否是halt

assign PCJudge[0] = (Op == 6'b000100) ?1:0;    // PCJudge: beq:01  jump:10 其他:00
assign PCJudge[1] = (Op == 6'b000010) ?1:0;    //只在jump的时候第一位为1,其他情况全是0

assign ALUSrc = ((Op == 6'b000000) || (Op == 6'b000001) || (Op == 6'b000100)) ?0:1;  //只有add,sub.beq为0.其余均为1

assign RegDst = ((Op == 6'b000000) || (Op == 6'b000001)) ?1:0;        // add和sub选择第三个寄存器写入，ori和lw都选择第二个，其余的随意都是0

assign RegWrite = ((Op == 6'b101011) || (Op == 6'b000100) || (Op == 6'b000010)) ?0:1;  //add,sub,ori,lw需要写入

assign ALUOp[0] = ((Op == 6'b000001) || (Op == 6'b001101)||(Op == 6'b000100)) ?1:0; // sub, ori, beg的末尾为1，其余为0
assign ALUOp[1] = ((Op == 6'b001101)) ?1:0;  // 只有ori指令的中间位为1
assign ALUOp[2] = 0;   // 高位全是0

assign MemoryWrite = (Op == 6'b101011) ?1:0;   //只有sw指令需要向数据内存区写入数据

assign MemoryRead = (Op == 6'b100011) ?1:0;    //只有lw指令需要从数据内存取出数据

assign MemtoReg = (Op == 6'b100011) ?1:0;   //只有lw是1，需要把写回的数据设置为从内存中读出来的

assign Jump = (Op == 6'b000010) ?1:0;   //只有jump指令是

assign Branch = (Op == 6'b000100) ?1:0; //只有branch是

assign ExtSel = (Op == 6'b001101) ?0:1; //只有ori是0扩展，别的都是符号扩展



endmodule