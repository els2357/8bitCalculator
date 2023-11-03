module MUX(
	input [1:0] sel,
	input [7:0] IU, AU,
	output [7:0] OU
);

	assign OU = sel[0] ? AU : IU;
	
endmodule 