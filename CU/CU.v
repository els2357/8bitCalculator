module CU(
	input ENTER, CLOCK, RESET, ADDSUB,
	input [3:0] ROW, //KEYPAD
	
	output OVR, COUT, ENTEROUT,
	output[3:0] COL, //KEYPAD
	output [0:6] HEXONES, HEXTENS, HEXHUNDREDS, HEXSIGN,
	output blankhex0, blankhex1, blankhex2, blankhex3,
	output [0:7] blankhex4, blankhex5,
	output VALID, //LEDR0
	output reg select, LOADA, LOADB, LOADR,
	output reg [1:0] state, nextstate
);
	wire TRIG;
	wire [7:0]BSM, IU, AUA, AUB, SUM, RESULT, OU;
	wire [15:0] OUT; //KEYPAD
	wire [3:0] VALUE;
	wire [6:0] hexfill1, hexfill2, hexfill3, hexfill4, hexfill5, hexfill6;
	
	assign blankhex0 = 1, blankhex1 = 1, blankhex2 = 1, blankhex3 = 1;
	assign blankhex4 = 8'b11111111, blankhex5 = 8'b11111111;
	parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
	
	always @ (posedge CLOCK, negedge RESET)
		if(RESET == 0) state <= S0;
		else state <= nextstate;

	EdgeDetect EdgeDetect_inst
	(
		.in(~ENTER) , // input  in_sig
		.clock(CLOCK) , // input  clock_sig
		.out(ENTEROUT) // output  out_sig
	);	
	
	always @ (state,ENTEROUT)
		case (state)
			S0: if (ENTEROUT) nextstate = S1; else nextstate = S0;
			S1: if (ENTEROUT) nextstate = S2; else nextstate = S1;
			S2: if (ENTEROUT) nextstate = S3; else nextstate = S2;
			S3: if (ENTEROUT) nextstate = S3; else nextstate = S3;
		endcase
	
	always @ (state,ENTEROUT)
		case (state)
			S0: begin LOADA=1; LOADB=1; LOADR=1; select=0; end
			S1: begin LOADA=0; LOADB=1; LOADR=1; select=0; end 
			S2: begin LOADA=1; LOADB=0; LOADR=1; select=0; end
			S3: begin LOADA=1; LOADB=1; LOADR=0; select=1; end
		endcase
		
IU IU_inst
(
	.CLOCK(CLOCK) ,	// input  CLOCK_sig
	.RESET(RESET) ,	// input  RESET_sig
	.ROW(ROW) ,			// input [3:0] ROW_sig
	.TRIG(TRIG) ,		// output  TRIG_sig
	.COL(COL) ,			// output [3:0] COL_sig
	.VALUE(VALUE) ,	// output [3:0] VALUE_sig
	.OUT(OUT) ,			// output [15:0] OUT_sig
	.BSM(BSM) ,			// output [7:0] BSM_sig
	.TWOSCOMP(IU) ,	// output [7:0] TWOSCOMP_sig
	.VALID(VALID) 		// output  VALID_sig
);

ALU ALU_inst
(
	.dataIn(IU) ,	// input [7:0] dataIn_sig
	.addsub(ADDSUB) ,	// input  addsub_sig
	.reset(RESET) ,	// input  reset_sig
	.clock(CLOCK) ,	// input  clock_sig
	.loadA(LOADA) ,	// input  loadA_sig, triggered on "ENTER"
	.loadB(LOADB) ,	// input  loadB_sig, triggered on "ENTER"
	.loadR(LOADR) ,	// input  loadR_sig, triggered on "ENTER"
	.OVR(OVR) ,	// output  OVR_sig
	.Cout(COUT) ,	// output  Cout_sig
	.hexALSB(hexfill1) ,	// output [0:6] hexALSB_sig
	.hexAMSB(hexfill2) ,	// output [0:6] hexAMSB_sig
	.hexBLSB(hexfill3) ,	// output [0:6] hexBLSB_sig
	.hexBMSB(hexfill4) ,	// output [0:6] hexBMSB_sig
	.hexRLSB(hexfill5) ,	// output [0:6] hexRLSB_sig
	.hexRMSB(hexfill6) ,	// output [0:6] hexRMSB_sig
	.dataOutA(AUA) ,	// output [7:0] dataOutA_sig
	.dataOutB(AUB) ,	// output [7:0] dataOutB_sig
	.dataSum(SUM) ,	// output [7:0] dataSum_sig
	.result(RESULT) 	// output [7:0] result_sig
);

MUX MUX_inst
(
	.sel(select) ,	// input [1:0] sel_sig
	.IU(IU) ,	// input [7:0] IU_sig
	.AU(RESULT) ,	// input [7:0] AU_sig
	.OU(OU) 	// output [7:0] OU_sig
);

OU OU_inst
(
	.CLOCK(CLOCK) ,	// input  CLOCK_sig
	.RESET(RESET) ,	// input  RESET_sig
	.LOADOU(ENTER) ,	// input  LOADOU_sig
	.binary(OU) ,	// input [7:0] binary_sig
	.hexOnes(HEXONES) ,	// output [0:6] hexOnes_sig
	.hexTens(HEXTENS) ,	// output [0:6] hexTens_sig
	.hexHundreds(HEXHUNDREDS) ,	// output [0:6] hexHundreds_sig
	.hexSign(HEXSIGN) 	// output [0:6] hexSign_sig
);

endmodule
