`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/31 12:26:53
// Design Name: 
// Module Name: single_sim
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

module single_sim();
    reg Reset;
    reg CLK;
    wire [31:0] curPC,nextPC, reg1, reg2, reg3;
    wire [31:0] ReadData1,ReadData2,Result,DataOut, ExtendedTest;
    wire [4:0] Rs,Rt,Rd,Sa;
    wire [5:0] InsOut;
    wire [5:0] opCode;
    wire [15:0] Immediate;
    wire [25:0] Address;
    wire [31:0] InA,InB,JumpPC;
    wire [2:0] ALU;
    wire Zero, Jump, Branch;
    wire [1:0] pcSrc;
    wire [2:0] ALUOp;
//CLK,Reset,curPC,nextPC,readData1,readData2,Rs,Rt,ALUOutput, DataOut,A,B,branch, jump)
//module SingleCycleCPU(CLK,Reset,curPC,nextPC,ReadData1,ReadData2,Rs,Rt,Rd,Sa,Result,DataOut);   
    SingleCycleCPU cpu(
        .CLK(CLK),
        .Reset(Reset),
        .curPC(curPC),
        .nextPC(nextPC),
        .readData1(ReadData1),
        .readData2(ReadData2),
        .Rs(Rs),
        .Rt(Rt),
//        .Rd(Rd),
//        .Sa(Sa),
        .ALUOutput(Result),
        .DataOut(DataOut),
//        .OpCode(opCode),
//        .InsOut(InsOut),
//        .Immediate(Immediate),
        .A(InA),
        .B(InB),
//        .ALUOp(ALU),
//        .PCSrc(pcSrc)
//        .Zero(Zero),
//        .Sign(Sign)
        .branch(Branch), 
        .jump(Jump),
        .Insout(InsOut),
        .ExtendedTest(ExtendedTest),
        .InsImmediate(Immediate),
        .ALUOperator(ALUOp),
        .outReg1(reg1),
        .outReg2(reg2),
        .outReg3(reg3)
    );
    
initial begin
    CLK = 0;
    Reset = 0;
    #50;
    begin 
        Reset=1;
        CLK=1;
    end
    forever #50 CLK=~CLK;
end
    
endmodule

