// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.


// Generated by Quartus Prime Version 20.1 (Build Build 720 11/11/2020)
// Created on Sat Nov 26 10:56:18 2022

ALU ALU_inst
(
	.dataIn(dataIn_sig) ,	// input [7:0] dataIn_sig
	.addsub(addsub_sig) ,	// input  addsub_sig
	.reset(reset_sig) ,	// input  reset_sig
	.clock(clock_sig) ,	// input  clock_sig
	.loadA(loadA_sig) ,	// input  loadA_sig
	.loadB(loadB_sig) ,	// input  loadB_sig
	.loadR(loadR_sig) ,	// input  loadR_sig
	.OVR(OVR_sig) ,	// output  OVR_sig
	.Cout(Cout_sig) ,	// output  Cout_sig
	.hexALSB(hexALSB_sig) ,	// output [0:6] hexALSB_sig
	.hexAMSB(hexAMSB_sig) ,	// output [0:6] hexAMSB_sig
	.hexBLSB(hexBLSB_sig) ,	// output [0:6] hexBLSB_sig
	.hexBMSB(hexBMSB_sig) ,	// output [0:6] hexBMSB_sig
	.hexRLSB(hexRLSB_sig) ,	// output [0:6] hexRLSB_sig
	.hexRMSB(hexRMSB_sig) ,	// output [0:6] hexRMSB_sig
	.dataOutA(dataOutA_sig) ,	// output [7:0] dataOutA_sig
	.dataOutB(dataOutB_sig) ,	// output [7:0] dataOutB_sig
	.dataSum(dataSum_sig) ,	// output [7:0] dataSum_sig
	.result(result_sig) 	// output [7:0] result_sig
);

