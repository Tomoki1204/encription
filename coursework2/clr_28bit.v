/* Copyright (C) 2017 Daniel Page <csdsp@bristol.ac.uk>
 *
 * Use of this source code is restricted per the CC BY-NC-ND license, a copy of 
 * which can be found via http://creativecommons.org (and should be included as 
 * LICENSE.txt within the associated archive or repository).
 */

module clr_28bit( output wire [ 27 : 0 ] r,
                   input wire [ 27 : 0 ] x,
                   input wire [  3 : 0 ] y );

  // Stage 1: complete this module implementation
  reg [1:0]f;
  always @(*) begin
    case (y)
      4'b0000:f = 2'b01;
      4'b0001:f = 2'b01;
      4'b1000:f = 2'b01;
      4'b1111:f = 2'b01;
      default:f = 2'b10;
    endcase

  end
  
  assign r = (x << f) | (x >> (28 - f));

endmodule
