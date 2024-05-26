/* verilator lint_off PINCONNECTEMPTY */

module alu(
    input [3:0] a,
    input [3:0] b,
    input [2:0] s,
    output reg [3:0] y
); 
    // alu has two input operand a and b.
    // It executes different operation over input a and b based on input s
    // then generate result to output y
    
    // TODO: implement your 4bits ALU design here and using your own fulladder module in this module
    // For testbench verifying, do not modify input and output pin

    wire[2:0] cr0, cr1, cr;
    wire[3:0] negb;
    wire[3:0] res0, res1;

    fullAdder fa_00(.cin(1'b0), .a(a[0]), .b(b[0]), .s(res0[0]), .cout(cr0[0]));
    fullAdder fa_01(.cin(cr0[0]), .a(a[1]), .b(b[1]), .s(res0[1]), .cout(cr0[1]));
    fullAdder fa_02(.cin(cr0[1]), .a(a[2]), .b(b[2]), .s(res0[2]), .cout(cr0[2]));
    fullAdder fa_03(.cin(cr0[2]), .a(a[3]), .b(b[3]), .s(res0[3]), .cout());

    fullAdder fa_10(.cin(1'b0), .a(a[0]), .b(negb[0]), .s(res1[0]), .cout(cr1[0]));
    fullAdder fa_11(.cin(cr1[0]), .a(a[1]), .b(negb[1]), .s(res1[1]), .cout(cr1[1]));
    fullAdder fa_12(.cin(cr1[1]), .a(a[2]), .b(negb[2]), .s(res1[2]), .cout(cr1[2]));
    fullAdder fa_13(.cin(cr1[2]), .a(a[3]), .b(negb[3]), .s(res1[3]), .cout());

    fullAdder fa_0(.cin(1'b0), .a(~b[0]), .b(1'b1), .s(negb[0]), .cout(cr[0]));
    fullAdder fa_1(.cin(cr[0]), .a(~b[1]), .b(1'b0), .s(negb[1]), .cout(cr[1]));
    fullAdder fa_2(.cin(cr[1]), .a(~b[2]), .b(1'b0), .s(negb[2]), .cout(cr[2]));
    fullAdder fa_3(.cin(cr[2]), .a(~b[3]), .b(1'b0), .s(negb[3]), .cout());
    

    always @(*) begin
        case (s)
          3'b000: assign y = res0;
          3'b001: assign y = res1;
          3'b010: assign y = ~a;
          3'b011: assign y = a & b;
          3'b100: assign y = a | b;
          3'b101: assign y = a ^ b;
          3'b110: assign y = a > b ? 1 : 0;
          3'b111: assign y = a == b ? 1 : 0;
        endcase
    end

endmodule

