/* Copyright (C) 2017 Daniel Page <csdsp@bristol.ac.uk>
 *
 * Use of this source code is restricted per the CC BY-NC-ND license, a copy of 
 * which can be found via http://creativecommons.org (and should be included as 
 * LICENSE.txt within the associated archive or repository).
 */

module key_schedule( output wire [ 55 : 0 ] r,
                     output wire [ 47 : 0 ] k,
                      input wire [ 55 : 0 ] x,
                      input wire [  3 : 0 ] i );

  // Stage 1: complete this module implementation

  wire [27:0]r1, r0;
  wire [27:0]x1, x0;
  wire [55:0]merge_r;

  split_0 s(
    .x(x),
    .r1(r1),
    .r0(r0)
  );

  clr_28bit m1(
    .r(x1),
    .x(r1),
    .y(i)
  );

  clr_28bit m0(
    .r(x0),
    .x(r0),
    .y(i)
  );

  merge_0 m(
    .r(merge_r),
    .x1(x1),
    .x0(x0)
  );


  perm_PC2 p(
    .r(k),
    .x(merge_r)
  );

  assign r = merge_r;
  endmodule
