/* Copyright (C) 2017 Daniel Page <csdsp@bristol.ac.uk>
 *
 * Use of this source code is restricted per the CC BY-NC-ND license, a copy of 
 * which can be found via http://creativecommons.org (and should be included as 
 * LICENSE.txt within the associated archive or repository).
 */

`include "params.h"

module encrypt_comb(  input wire [ `N_K - 1 : 0 ]   k,   //  input    data: cipher key
                      input wire [ `N_B - 1 : 0 ]   m,   //  input    data:  plaintext message
                     output wire [ `N_B - 1 : 0 ]   c ); // output    data: ciphertext message

  // Stage 2: complete this module implementation







 wire [3:0]i1;
 wire [31:0] r1, r0;
 wire [55:0] PC_r;
 wire [31:0] round_rl[0:16];
 wire [31:0] round_rr[0:16];
 wire [55:0] key_r[0:16];
 wire [63:0] IP_r, merge_r;
 wire [47:0] k1[0:15];
 //reg [3:0] key_i = 4'b0000;
 wire [63:0] merge2_r;

 perm_IP IP(
  .r(IP_r),
  .x(m)
 );

 split_2 sp2(
  .r1(r1),
  .r0(r0),
  .x(IP_r)
 );

 perm_PC1 PC1(
  .r(PC_r),
  .x(k)
 );

 key_schedule ks0(
  .x(PC_r),
  .r(key_r[0]),
  .i(4'b0000),
  .k(k1[0])
 );

  round rd0(
    .xl(r1),
    .xr(r0),
    .rl(round_rl[0]),
    .rr(round_rr[0]),
    .k(k1[0])
  );

  initial begin
    #10
    $display("key_schedule0 r = :%h", key_r[0]);
    $display("key_schedule0 k = :%h", k1[0]);
    $display("round0 rl = :%h", round_rl[0]);
    $display("round0 rr = :%h", round_rr[0]);
  end

 genvar i;
 generate
  for(i = 0; i < 14; i = i+1) begin: loop
    round r(
      .xl(round_rl[i]),
      .xr(round_rr[i]),
      .rl(round_rl[i+1]),
      .rr(round_rr[i+1]),
      .k(k1[i+1])
    );

      key_schedule ks(
        .x(key_r[i]),
        .r(key_r[i+1]),
        .i((i[3:0] + 4'b0001) & 4'b1111),
        .k(k1[i+1])
      );


    initial begin
      #10
      $display("key_schedule %0d r =: %08h, k =: %08h", i+1, key_r[i+1], k1[i+1]);
      $display("round %0d rl =: %08h,  rr =: %08h", i+1, round_rl[i+1], round_rr[i+1]);
    end

  end
 endgenerate

 key_schedule ks15(
  .x(key_r[14]),
  .r(key_r[15]),
  .i(4'b1111),
  .k(k1[15])
 );

 round r15(
  .xl(round_rl[14]),
  .xr(round_rr[14]),
  .k(k1[15]),
  .rl(round_rl[15]),
  .rr(round_rr[15])
 );

   initial begin
    #10
    $display("key_schedule15 r = :%h", key_r[15]);
    $display("key_schedule15 k = :%h", k1[15]);
    $display("round15 rl = :%h", round_rl[15]);
    $display("round15 rr = :%h", round_rr[15]);
  end

 merge_2 m2(
  .x1(round_rr[15]),
  .x0(round_rl[15]),
  .r(merge2_r)
 );

 perm_FP FP(
  .x(merge2_r),
  .r(c)
 );
endmodule
