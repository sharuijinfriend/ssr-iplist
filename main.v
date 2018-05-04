module main(
input clk,
input start,
input rst,
input pause,
input conti,
output reg [5:0] scan_sel,///an
output reg [7:0] seg
 );
reg clkout;
reg clkout_0;
reg clkout_1;
reg clkout_2;
reg clkout_3;
reg clkout_4;
reg clkout_5;
reg [19:0] counterclk;
reg [19:0] counterclk_1;
reg rst_all;
reg stop;
parameter total=500000;
reg [2:0] sel;
reg [7:0] seg_0;
reg [4:0] seg_1;
reg [4:0] seg_2;
reg [4:0] seg_3;
reg [4:0] seg_4;
reg [4:0] seg_5;

reg [7:0] seg_out_0;
reg [7:0] seg_out_1;
reg [7:0] seg_out_2;
reg [7:0] seg_out_3;
reg [7:0] seg_out_4;
reg [7:0] seg_out_5;
///////////////////////rst_all
always @(*)
	begin
		rst_all= (~start) || rst;
	end

		
///////////////////////分频器
always @(posedge clk, negedge start)
	begin
		if(~start)
			begin
				counterclk<=0;
				clkout<=0;
			end
		else if (counterclk < total)
				begin
					counterclk<=counterclk+1;
				end
		else
			begin
				counterclk<=0;
				clkout<= ~clkout;    //得到一个100hz的时钟
			end			
	end
always @(posedge clk, negedge start)
	begin
		if(~start)
			begin
				counterclk_1<=0;
				clkout_0<=0;
			end
		else if (counterclk_1 < 10000)
				begin
					counterclk_1<=counterclk_1+1;
				end
		else
			begin
				counterclk_1<=0;
				clkout_0<= ~clkout_0;    //得到一个0.5mhz的时钟
			end			
	end

////////////////////////////暂停信号，复位清零，pause暂停，conti继续
always @(posedge clk,negedge start)
	begin
		if(~start)
			stop<=0;
	    else if(pause)
			stop<=1;
		else if(conti)
			stop<=0;
	end
///////////////////////	数码管6选一
always @(posedge clkout_0, negedge start)
	begin
		if(~start)
			begin
				sel<=7;
			end
		else if(sel<6)
			begin
				sel<=sel+1;
			end	
		else
			begin
				sel<=1;
			end	
	end
///////////////////////译码电路
always @(*)
	begin
		case(sel)
		0		:scan_sel=6'b111111;
		1		:scan_sel=6'b000001;
		2		:scan_sel=6'b000010;
		3		:scan_sel=6'b000100;
		4		:scan_sel=6'b001000;
		5		:scan_sel=6'b010000;
		6		:scan_sel=6'b100000;
		default :scan_sel=6'b000000;
		endcase
	end
////////////////////////第一位
always @(*)
	begin
		seg_0 = 8'b10110110;//s signal
	end
///////////////////////第二位
always @(posedge clkout, posedge rst_all, posedge stop)
	begin
		if(rst_all)
		begin
			seg_1<=0;
			//clkout_1<=0;
		end
		else if(stop)
			seg_1<=seg_1;
		else if(seg_1<9)
			seg_1<=seg_1+1;
		else
			begin
			//clkout_1<=~clkout_1;
			seg_1<=0;
			end
	end
always @(posedge clkout, posedge rst_all)
	begin
		if(rst_all)
		begin
			clkout_1<=1;
		end
		else if(seg_1==9)
			clkout_1<=1;
		else if(seg_1==8)
			clkout_1<=0;
	end
//////////////////////第三位
always @(posedge clkout_1, posedge rst_all)
	begin
		if(rst_all)
		begin
			seg_2<=0;
			//clkout_2<=0;
		end
		else if(stop)
			seg_2<=seg_2;
		else if(seg_2<9)
			seg_2<=seg_2+1;
		else
			begin
			//clkout_2<=~clkout_2;
			seg_2<=0;
			end
	end
always @(posedge clkout_1, posedge rst_all)
	begin
		if(rst_all)
		begin
			clkout_2<=1;
		end
		else if(seg_2==9)
			clkout_2<=1;
		else if(seg_2==8)
			clkout_2<=0;
	end
////////////////////第四位
always @(posedge clkout_2, posedge rst_all)
	begin
		if(rst_all)
		begin
			seg_3<=0;
			//clkout_3<=0;
		end
		else if(stop)
			seg_3<=seg_3;
		else if(seg_3<9)
			seg_3<=seg_3+1;
		else
			begin
			//clkout_3<=~clkout_3;
			seg_3<=0;
			end
	end
always @(posedge clkout_2, posedge rst_all)
	begin
		if(rst_all)
		begin
			clkout_3<=1;
		end
		else if(seg_3==9)
			clkout_3<=1;
		else if(seg_3==8)
			clkout_3<=0;
	end	
////////////////////第五位
always @(posedge clkout_3, posedge rst_all)
	begin
		if(rst_all)
		begin
			seg_4<=0;
			//clkout_4<=0;
		end
		else if(stop)
			seg_4<=seg_4;
		else if(seg_4<9)
			seg_4<=seg_4+1;
		else
			begin
			//clkout_4<=~clkout_4;
			seg_4<=0;
			end
	end
always @(posedge clkout_3, posedge rst_all)
	begin
		if(rst_all)
		begin
			clkout_4<=1;
		end
		else if(seg_4==9)
			clkout_4<=1;
		else if(seg_4==8)
			clkout_4<=0;
	end	
////////////////////////第六位
always @(posedge clkout_4, posedge rst_all)
	begin
		if(rst_all)
		begin
			seg_5<=0;
			//clkout_5<=0;
		end
		else if(stop)
			seg_5<=seg_5;
		else if(seg_5<9)
			seg_5<=seg_5+1;
		else
			begin
			//clkout_5<=~clkout_5;
			seg_5<=0;
			end
	end
always @(posedge clkout_4, posedge rst_all)
	begin
		if(rst_all)
		begin
			clkout_5<=1;
		end
		else if(seg_5==9)
			clkout_5<=1;
		else if(seg_5==8)
			clkout_5<=0;
	end		
////////////////////////将十进制转换成七段译码器编码		
always @(*)
	begin
		seg_out_0=seg_0;
	end
always @(*)
	begin
		case(seg_1)
		0		:seg_out_1=8'b11111100;
		1		:seg_out_1=8'b01100000;
		2		:seg_out_1=8'b11011010;
		3		:seg_out_1=8'b11110010;
		4		:seg_out_1=8'b01100110;
		5		:seg_out_1=8'b10110110;
		6		:seg_out_1=8'b10111110;
		7		:seg_out_1=8'b11100000;
		8		:seg_out_1=8'b11111110;
		9		:seg_out_1=8'b11110110;
		default :seg_out_1=8'b11111111;
		endcase
	end
always @(*)
	begin
		case(seg_2)
		0		:seg_out_2=8'b11111100;
		1		:seg_out_2=8'b01100000;
		2		:seg_out_2=8'b11011010;
		3		:seg_out_2=8'b11110010;
		4		:seg_out_2=8'b01100110;
		5		:seg_out_2=8'b10110110;
		6		:seg_out_2=8'b10111110;
		7		:seg_out_2=8'b11100000;
		8		:seg_out_2=8'b11111110;
		9		:seg_out_2=8'b11110110;
		default :seg_out_2=8'b11111111;
		endcase
	end
always @(*)
	begin
		case(seg_3)
		0		:seg_out_3=8'b11111101;
		1		:seg_out_3=8'b01100001;
		2		:seg_out_3=8'b11011011;
		3		:seg_out_3=8'b11110011;
		4		:seg_out_3=8'b01100111;
		5		:seg_out_3=8'b10110111;
		6		:seg_out_3=8'b10111111;
		7		:seg_out_3=8'b11100001;
		8		:seg_out_3=8'b11111111;
		9		:seg_out_3=8'b11110111;
		default :seg_out_3=8'b11111111;
		endcase
	end
always @(*)
	begin
		case(seg_4)
		0		:seg_out_4=8'b11111100;
		1		:seg_out_4=8'b01100000;
		2		:seg_out_4=8'b11011010;
		3		:seg_out_4=8'b11110010;
		4		:seg_out_4=8'b01100110;
		5		:seg_out_4=8'b10110110;
		6		:seg_out_4=8'b10111110;
		7		:seg_out_4=8'b11100000;
		8		:seg_out_4=8'b11111110;
		9		:seg_out_4=8'b11110110;
		default :seg_out_4=8'b11111111;
		endcase
	end
always @(*)
	begin
		case(seg_5)
		0		:seg_out_5=8'b11111100;
		1		:seg_out_5=8'b01100000;
		2		:seg_out_5=8'b11011010;
		3		:seg_out_5=8'b11110010;
		4		:seg_out_5=8'b01100110;
		5		:seg_out_5=8'b10110110;
		6		:seg_out_5=8'b10111110;
		7		:seg_out_5=8'b11100000;
		8		:seg_out_5=8'b11111110;
		9		:seg_out_5=8'b11110110;
		default :seg_out_5=8'b11111111;
		endcase
	end

always @(*)
	begin
		case(sel)
		1		:seg=seg_out_0;
		2		:seg=seg_out_1;
		3		:seg=seg_out_2;
		4		:seg=seg_out_3;
		5		:seg=seg_out_4;
		6		:seg=seg_out_5;
		default :seg=8'b0;
		endcase
	end
endmodule
















