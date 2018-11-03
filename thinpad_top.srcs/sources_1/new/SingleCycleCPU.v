`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ljs
// 
// Create Date: 2018/10/30 18:02:06
// Design Name: 
// Module Name: SingleCycleCPU
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
一个完整的单周期CPU模块，输入时钟信号与Reset信号，输出只是为了仿真的时候看结果，没有实现指令内存，只是用一个txt文件来代替的
input:
        CLK: 时钟信号
        Reset:清零信号
*/

module SingleCycleCPU(CLK,Reset,curPC,nextPC,readData1,readData2,Rs,Rt,ALUOutput, DataOut,A,B,branch, jump, Insout, ExtendedTest, InsImmediate, ALUOperator, outReg1, outReg2, outReg3);
input CLK,Reset;
output [31:0] curPC,nextPC,readData1,readData2;//readdata1寄存器组的输出1，对应的rs的地址，readdata
output [4:0] Rs,Rt;
output [31:0] ALUOutput,DataOut;//result->ALU output, DataOut->DataMemory's output
output [31:0] A,B;
output branch, jump;
output [5:0] Insout;
output [31:0] ExtendedTest;
output [15:0] InsImmediate;
output [2:0] ALUOperator;
output [31:0] outReg1, outReg2, outReg3;



wire [31:0] PC, InstructionAddress, InstructionOut, WriteData, ReadData1, ReadData2, ExtendedOut, ALUinput2, ALUResult, jumpPCAddress, ReadDatafromMemory;
wire PCHalt;
wire [1:0] PCJudge;
wire ALUSrc, RegDst, RegWrite, MemoryRead, MemoryWrite, MemtoReg, Jump, Branch, ExtSel; 
wire [2:0] ALUOp; 
wire [4:0] WriteReg;
wire zero;   //alu的结果是否为0
wire [31:0] reg1, reg2, reg3;


// PC 模块CLK, Reset, PCHalt, PCNext, InstructionAddress
PC pc(.CLK(CLK), .Reset(Reset), .PCHalt(PCHalt), .PCNext(PC), .InstructionAddress(InstructionAddress));



// InstructionMemory模块
InstructionMemory IM(.InstructionAddress(InstructionAddress), .InstructionOut(InstructionOut));



// ControlUnit模块 Op, PCHalt, PCJudge, ALUSrc, RegDst, RegWrite, ALUOp, MemoryWrite, MemoryRead, MemtoReg, Jump, Branch, ExtSel
ControlUnit control(.Op(InstructionOut[31:26]), .PCHalt(PCHalt), .PCJudge(PCJudge), .ALUSrc(ALUSrc), .RegDst(RegDst), 
    .RegWrite(RegWrite), .ALUOp(ALUOp), .MemoryWrite(MemoryWrite), .MemoryRead(MemoryRead), .MemtoReg(MemtoReg), .Jump(Jump), .Branch(Branch), .ExtSel(ExtSel)
);



// write register前面的二选一
Select5bits selectwriteregister(.Select(RegDst), .DataA(InstructionOut[20:16]), .DataB(InstructionOut[15:11]), .Data(WriteReg));
// register heap模块
RegisterHeap heap(.ReadReg1(InstructionOut[25:21]), .ReadReg2(InstructionOut[20:16]), .WriteData(WriteData), .WriteReg(WriteReg), .ReadData1(ReadData1), 
    .ReadData2(ReadData2), .WE(RegWrite), .CLK(CLK), .reg1(reg1), .reg2(reg2), .reg3(reg3));



// 符号扩展模块
SignZeroExtend signextend(.Immediate(InstructionOut[15:0]), .ExtSel(ExtSel), .ExtendedOut(ExtendedOut));



// ALU前面选择操作数
Select32bits alusrcselect(.Select(ALUSrc), .DataA(ReadData2), .DataB(ExtendedOut), .Data(ALUinput2));
// ALU模块
ALU alu(.InA(ReadData1), .InB(ALUinput2), .ALUOp(ALUOp), .zero(zero), .result(ALUResult));


// 处理PC的更新
PCJump pcjump(.PC(InstructionAddress), .InAddr(InstructionOut[25:0]), .Out(jumpPCAddress));
PCNext nextpc( .Reset(Reset), .PC(InstructionAddress), .Immediate(ExtendedOut), .PCJump(jumpPCAddress), .Jump(Jump), .Branch(Branch), .zero(zero), .PCNext(PC));



// 处理写入读出数据
DataMemory datamemory(.CLK(CLK), .DataAddress(ALUResult), .WriteData(ReadData2), .MemWrite(MemoryWrite), .MemRead(MemoryRead), .DataMemoryOut(ReadDatafromMemory));
Select32bits writeIntoRegisterSelect(.Select(MemtoReg), .DataA(ALUResult), .DataB(ReadDatafromMemory), .Data(WriteData));


assign curPC=InstructionAddress;
assign nextPC=PC;
assign ReadData1=readData1;
assign ReadData2=readData2;
assign Rs=InstructionOut[25:21];
assign Rt=InstructionOut[20:16];
assign ALUOutput = ALUResult;
assign DataOut = ReadDatafromMemory;
assign A = ReadData1;
assign B = ReadData2;
assign branch = Branch;
assign jump = Jump;
assign Insout = InstructionOut[31:26];
assign ExtendedTest = ExtendedOut;
assign InsImmediate = InstructionOut[15:0];
assign ALUOperator = ALUOp;
assign outReg1 = reg1;
assign outReg2 = reg2;
assign outReg3 = reg3;




endmodule
