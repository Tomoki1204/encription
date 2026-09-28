/* Copyright (C) 2017 Daniel Page <csdsp@bristol.ac.uk>
 *
 * Use of this source code is restricted per the CC BY-NC-ND license, a copy of 
 * which can be found via http://creativecommons.org (and should be included as 
 * LICENSE.txt within the associated archive or repository).
 */

module round( output wire [ 31 : 0 ] rl,
              output wire [ 31 : 0 ] rr,
               input wire [ 31 : 0 ] xl,
               input wire [ 31 : 0 ] xr,
               input wire [ 47 : 0 ] k );

  // Stage 1: complete this module implementation
  wire [47:0]perm_r, xor_r;
  wire [5:0]r0, r1, r2, r3, r4, r5, r6, r7;
  wire [3:0]r_s0, r_s1, r_s2, r_s3, r_s4, r_s5, r_s6, r_s7;
  wire [31:0]merge1_r;
  wire [31:0]perm_p_r;


  perm_E pE(
    .x(xr),
    .r(perm_r)
  );

  //xor x1(xor_r, perm_r, k);
  assign xor_r = perm_r ^ k;

  split_1 sp1(
    .x(xor_r),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .r5(r5),
    .r6(r6),
    .r7(r7)
  );

  sbox_0 sb0(
    .x(r0),
    .r(r_s0)
  );

  sbox_1 sb1(
    .x(r1),
    .r(r_s1)
  );

  sbox_2 sb2(
    .x(r2),
    .r(r_s2)
  );

  sbox_3 sb3(
    .x(r3),
    .r(r_s3)
  );

  sbox_4 sb4(
    .x(r4),
    .r(r_s4)
  );

  sbox_5 sb5(
    .x(r5),
    .r(r_s5)
  );

  sbox_6 sb6(
    .x(r6),
    .r(r_s6)
  );

  sbox_7 sb7(
    .x(r7),
    .r(r_s7)
  );

  merge_1 m1(
    .x0(r_s0),
    .x1(r_s1),
    .x2(r_s2),
    .x3(r_s3),
    .x4(r_s4),
    .x5(r_s5),
    .x6(r_s6),
    .x7(r_s7),
    .r(merge1_r)
  );

  perm_P pp(
    .x(merge1_r),
    .r(perm_p_r)
  );

  //xor x2(rr, x1, perm_p_r);
  assign rr = xl ^ perm_p_r;

  initial begin
    #10
    $display("perm_p =: %h", perm_p_r);
    $display("rr =: %h", rr);
  end

  assign rl = xr;
endmodule
