/*
 * Replicate the operation of tail lights on old Thunderbirds.
 *
 * L:  left signal
 * R:  right signal
 * H:  hazard signal
 *
 * TL: left tail light
 * TR: right tail light
 *
 */
module taillights (input clk, L, R, H, output reg [2:0] TL, TR);
	always @(posedge clk) begin
		if (1 == H) begin
			if (TL == 3'b000 && TR == 3'b000) begin
				TL <= 3'b111;
				TR <= 3'b111;
			end
			else begin
				TL <= 3'b000;
				TR <= 3'b000;
			end
		end
		else if (1 == L) begin
			TR <= 3'b000;

			if (TL == 3'b000) begin
				TL <= 3'b001;
			end
			else if (TL == 3'b001) begin
				TL <= 3'b011;
			end
			else if (TL == 3'b011) begin
				TL <= 3'b111;
			end
			else begin
				TL <= 3'b000;
			end
		end
		else if (1 == R) begin
			TL <= 3'b000;

			if (TR == 3'b000) begin
				TR <= 3'b001;
			end
			else if (TR == 3'b001) begin
				TR <= 3'b011;
			end
			else if (TR == 3'b011) begin
				TR <= 3'b111;
			end
			else begin
				TR <= 3'b000;
			end
		end
	end
endmodule
