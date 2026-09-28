/* Copyright (C) 2017 Daniel Page <csdsp@bristol.ac.uk>
 *
 * Use of this source code is restricted per the CC BY-NC-ND license, a copy of 
 * which can be found via http://creativecommons.org (and should be included as 
 * LICENSE.txt within the associated archive or repository).
 */

/* Modules that split x into n subwords, where r_i denotes the i-th subword for 
 * 0 <= i < n; the size of subwords, and thus the number and size of inputs and
 * outputs, depends on the module.
 */

module split_0( output wire [ 27 : 0 ] r0,
                output wire [ 27 : 0 ] r1,
                 input wire [ 55 : 0 ]  x );

  assign { r1, r0 } = x;

endmodule

module split_1( output wire [  5 : 0 ] r0,
                output wire [  5 : 0 ] r1,
                output wire [  5 : 0 ] r2,
                output wire [  5 : 0 ] r3,
                output wire [  5 : 0 ] r4,
                output wire [  5 : 0 ] r5,
                output wire [  5 : 0 ] r6,
                output wire [  5 : 0 ] r7,
                 input wire [ 47 : 0 ]  x );

  assign { r7, r6, r5, r4, r3, r2, r1, r0 } = x;

endmodule

module split_2( output wire [ 31 : 0 ] r0,
                output wire [ 31 : 0 ] r1,
                 input wire [ 63 : 0 ]  x );

  assign { r1, r0 } = x;

endmodule

/* Modules that merge r from n subwords, where x_i denotes the i-th subword for 
 * 0 <= i < n; the size of subwords, and thus the number and size of inputs and
 * outputs, depends on the module.
 */

module merge_0( output wire [ 55 : 0 ]  r,
                 input wire [ 27 : 0 ] x0,
                 input wire [ 27 : 0 ] x1 );

  assign r = { x1, x0 };

endmodule

module merge_1( output wire [ 31 : 0 ]  r,
                 input wire [  3 : 0 ] x0,
                 input wire [  3 : 0 ] x1,
                 input wire [  3 : 0 ] x2,
                 input wire [  3 : 0 ] x3,
                 input wire [  3 : 0 ] x4,
                 input wire [  3 : 0 ] x5,
                 input wire [  3 : 0 ] x6,
                 input wire [  3 : 0 ] x7 );

  assign r = { x7, x6, x5, x4, x3, x2, x1, x0 };

endmodule

module merge_2( output wire [ 63 : 0 ]  r,
                 input wire [ 31 : 0 ] x0,
                 input wire [ 31 : 0 ] x1 );

  assign r = { x1, x0 };

endmodule

/* Modules that implement various permutations used in DES, namely
 *
 * - IP,  the (64-to-64)-bit "initial"            permutation,  
 * - FP,  the (64-to-64)-bit   "final"            permutation,
 * - E,   the (32-to-48)-bit "expansion"          permutation,
 * - P,   the (32-to-32)-bit "permute"            permutation,
 * - PC1, the (64-to-56)-bit "permuted choice #1" permutation, and
 * - PC2, the (56-to-48)-bit "permuted choice #2" permutation
 * 
 * where, for a given n-bit to m-bit permutation f, the corresponding module 
 * will compute the n-bit output r = f( x ) from the m-bit input x.
 */

module perm_IP( output wire [ 63 : 0 ] r, 
                 input wire [ 63 : 0 ] x );

  assign r = { x[  6 ], x[ 14 ], x[ 22 ], x[ 30 ], x[ 38 ], x[ 46 ], x[ 54 ], x[ 62 ], 
               x[  4 ], x[ 12 ], x[ 20 ], x[ 28 ], x[ 36 ], x[ 44 ], x[ 52 ], x[ 60 ], 
               x[  2 ], x[ 10 ], x[ 18 ], x[ 26 ], x[ 34 ], x[ 42 ], x[ 50 ], x[ 58 ], 
               x[  0 ], x[  8 ], x[ 16 ], x[ 24 ], x[ 32 ], x[ 40 ], x[ 48 ], x[ 56 ], 
               x[  7 ], x[ 15 ], x[ 23 ], x[ 31 ], x[ 39 ], x[ 47 ], x[ 55 ], x[ 63 ], 
               x[  5 ], x[ 13 ], x[ 21 ], x[ 29 ], x[ 37 ], x[ 45 ], x[ 53 ], x[ 61 ], 
               x[  3 ], x[ 11 ], x[ 19 ], x[ 27 ], x[ 35 ], x[ 43 ], x[ 51 ], x[ 59 ], 
               x[  1 ], x[  9 ], x[ 17 ], x[ 25 ], x[ 33 ], x[ 41 ], x[ 49 ], x[ 57 ] };

endmodule

module perm_FP( output wire [ 63 : 0 ] r, 
                 input wire [ 63 : 0 ] x );

  assign r = { x[ 24 ], x[ 56 ], x[ 16 ], x[ 48 ], x[  8 ], x[ 40 ], x[  0 ], x[ 32 ], 
               x[ 25 ], x[ 57 ], x[ 17 ], x[ 49 ], x[  9 ], x[ 41 ], x[  1 ], x[ 33 ], 
               x[ 26 ], x[ 58 ], x[ 18 ], x[ 50 ], x[ 10 ], x[ 42 ], x[  2 ], x[ 34 ], 
               x[ 27 ], x[ 59 ], x[ 19 ], x[ 51 ], x[ 11 ], x[ 43 ], x[  3 ], x[ 35 ], 
               x[ 28 ], x[ 60 ], x[ 20 ], x[ 52 ], x[ 12 ], x[ 44 ], x[  4 ], x[ 36 ], 
               x[ 29 ], x[ 61 ], x[ 21 ], x[ 53 ], x[ 13 ], x[ 45 ], x[  5 ], x[ 37 ], 
               x[ 30 ], x[ 62 ], x[ 22 ], x[ 54 ], x[ 14 ], x[ 46 ], x[  6 ], x[ 38 ], 
               x[ 31 ], x[ 63 ], x[ 23 ], x[ 55 ], x[ 15 ], x[ 47 ], x[  7 ], x[ 39 ] };

endmodule

module perm_E( output wire [ 47 : 0 ] r, 
                input wire [ 31 : 0 ] x );

  assign r = { x[  0 ], x[ 31 ], x[ 30 ], x[ 29 ], x[ 28 ], x[ 27 ], x[ 28 ], x[ 27 ], 
               x[ 26 ], x[ 25 ], x[ 24 ], x[ 23 ], x[ 24 ], x[ 23 ], x[ 22 ], x[ 21 ], 
               x[ 20 ], x[ 19 ], x[ 20 ], x[ 19 ], x[ 18 ], x[ 17 ], x[ 16 ], x[ 15 ], 
               x[ 16 ], x[ 15 ], x[ 14 ], x[ 13 ], x[ 12 ], x[ 11 ], x[ 12 ], x[ 11 ], 
               x[ 10 ], x[  9 ], x[  8 ], x[  7 ], x[  8 ], x[  7 ], x[  6 ], x[  5 ], 
               x[  4 ], x[  3 ], x[  4 ], x[  3 ], x[  2 ], x[  1 ], x[  0 ], x[ 31 ] };

endmodule

module perm_P( output wire [ 31 : 0 ] r, 
                input wire [ 31 : 0 ] x );

  assign r = { x[ 16 ], x[ 25 ], x[ 12 ], x[ 11 ], x[  3 ], x[ 20 ], x[  4 ], x[ 15 ], 
               x[ 31 ], x[ 17 ], x[  9 ], x[  6 ], x[ 27 ], x[ 14 ], x[  1 ], x[ 22 ], 
               x[ 30 ], x[ 24 ], x[  8 ], x[ 18 ], x[  0 ], x[  5 ], x[ 29 ], x[ 23 ], 
               x[ 13 ], x[ 19 ], x[  2 ], x[ 26 ], x[ 10 ], x[ 21 ], x[ 28 ], x[  7 ] };

endmodule

module perm_PC1( output wire [ 55 : 0 ] r, 
                  input wire [ 63 : 0 ] x );

  assign r = { x[  7 ], x[ 15 ], x[ 23 ], x[ 31 ], x[ 39 ], x[ 47 ], x[ 55 ], x[ 63 ], 
               x[  6 ], x[ 14 ], x[ 22 ], x[ 30 ], x[ 38 ], x[ 46 ], x[ 54 ], x[ 62 ], 
               x[  5 ], x[ 13 ], x[ 21 ], x[ 29 ], x[ 37 ], x[ 45 ], x[ 53 ], x[ 61 ], 
               x[  4 ], x[ 12 ], x[ 20 ], x[ 28 ], x[  1 ], x[  9 ], x[ 17 ], x[ 25 ], 
               x[ 33 ], x[ 41 ], x[ 49 ], x[ 57 ], x[  2 ], x[ 10 ], x[ 18 ], x[ 26 ], 
               x[ 34 ], x[ 42 ], x[ 50 ], x[ 58 ], x[  3 ], x[ 11 ], x[ 19 ], x[ 27 ], 
               x[ 35 ], x[ 43 ], x[ 51 ], x[ 59 ], x[ 36 ], x[ 44 ], x[ 52 ], x[ 60 ] };

endmodule

module perm_PC2( output wire [ 47 :0 ] r, 
                  input wire [ 55 :0 ] x );

  assign r = { x[ 42 ], x[ 39 ], x[ 45 ], x[ 32 ], x[ 55 ], x[ 51 ], x[ 53 ], x[ 28 ], 
               x[ 41 ], x[ 50 ], x[ 35 ], x[ 46 ], x[ 33 ], x[ 37 ], x[ 44 ], x[ 52 ], 
               x[ 30 ], x[ 48 ], x[ 40 ], x[ 49 ], x[ 29 ], x[ 36 ], x[ 43 ], x[ 54 ], 
               x[ 15 ], x[  4 ], x[ 25 ], x[ 19 ], x[  9 ], x[  1 ], x[ 26 ], x[ 16 ], 
               x[  5 ], x[ 11 ], x[ 23 ], x[  8 ], x[ 12 ], x[  7 ], x[ 17 ], x[  0 ], 
               x[ 22 ], x[  3 ], x[ 10 ], x[ 14 ], x[  6 ], x[ 20 ], x[ 27 ], x[ 24 ] };

endmodule

/* Modules that implement the DES (6-to-4)-bit S-boxes, which are basically just
 * look-up (or substitution) tables; the i-th module computes a 4-bit output 
 * 
 * r = S-box_i( x ) 
 * 
 * given a 6-bit input x.  Note that the implementation strategy used, i.e., use 
 * of a multipliexers to select an r based on x, is strictly focused on clarity; 
 * there is significant opportunity for optimisation as a result.
 */

module sbox_0( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'hD :
             ( x == 6'h01 ) ? 4'h1 :
             ( x == 6'h02 ) ? 4'h2 :
             ( x == 6'h03 ) ? 4'hF :
             ( x == 6'h04 ) ? 4'h8 :
             ( x == 6'h05 ) ? 4'hD :
             ( x == 6'h06 ) ? 4'h4 :
             ( x == 6'h07 ) ? 4'h8 :
             ( x == 6'h08 ) ? 4'h6 :
             ( x == 6'h09 ) ? 4'hA :
             ( x == 6'h0A ) ? 4'hF :
             ( x == 6'h0B ) ? 4'h3 :
             ( x == 6'h0C ) ? 4'hB :
             ( x == 6'h0D ) ? 4'h7 :
             ( x == 6'h0E ) ? 4'h1 :
             ( x == 6'h0F ) ? 4'h4 :
             ( x == 6'h10 ) ? 4'hA :
             ( x == 6'h11 ) ? 4'hC :
             ( x == 6'h12 ) ? 4'h9 :
             ( x == 6'h13 ) ? 4'h5 :
             ( x == 6'h14 ) ? 4'h3 :
             ( x == 6'h15 ) ? 4'h6 :
             ( x == 6'h16 ) ? 4'hE :
             ( x == 6'h17 ) ? 4'hB :
             ( x == 6'h18 ) ? 4'h5 :
             ( x == 6'h19 ) ? 4'h0 :
             ( x == 6'h1A ) ? 4'h0 :
             ( x == 6'h1B ) ? 4'hE :
             ( x == 6'h1C ) ? 4'hC :
             ( x == 6'h1D ) ? 4'h9 :
             ( x == 6'h1E ) ? 4'h7 :
             ( x == 6'h1F ) ? 4'h2 :
             ( x == 6'h20 ) ? 4'h7 :
             ( x == 6'h21 ) ? 4'h2 :
             ( x == 6'h22 ) ? 4'hB :
             ( x == 6'h23 ) ? 4'h1 :
             ( x == 6'h24 ) ? 4'h4 :
             ( x == 6'h25 ) ? 4'hE :
             ( x == 6'h26 ) ? 4'h1 :
             ( x == 6'h27 ) ? 4'h7 :
             ( x == 6'h28 ) ? 4'h9 :
             ( x == 6'h29 ) ? 4'h4 :
             ( x == 6'h2A ) ? 4'hC :
             ( x == 6'h2B ) ? 4'hA :
             ( x == 6'h2C ) ? 4'hE :
             ( x == 6'h2D ) ? 4'h8 :
             ( x == 6'h2E ) ? 4'h2 :
             ( x == 6'h2F ) ? 4'hD :
             ( x == 6'h30 ) ? 4'h0 :
             ( x == 6'h31 ) ? 4'hF :
             ( x == 6'h32 ) ? 4'h6 :
             ( x == 6'h33 ) ? 4'hC :
             ( x == 6'h34 ) ? 4'hA :
             ( x == 6'h35 ) ? 4'h9 :
             ( x == 6'h36 ) ? 4'hD :
             ( x == 6'h37 ) ? 4'h0 :
             ( x == 6'h38 ) ? 4'hF :
             ( x == 6'h39 ) ? 4'h3 :
             ( x == 6'h3A ) ? 4'h3 :
             ( x == 6'h3B ) ? 4'h5 :
             ( x == 6'h3C ) ? 4'h5 :
             ( x == 6'h3D ) ? 4'h6 :
             ( x == 6'h3E ) ? 4'h8 :
             ( x == 6'h3F ) ? 4'hB : 4'h0;

endmodule

module sbox_1( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'h4 :
             ( x == 6'h01 ) ? 4'hD :
             ( x == 6'h02 ) ? 4'hB :
             ( x == 6'h03 ) ? 4'h0 :
             ( x == 6'h04 ) ? 4'h2 :
             ( x == 6'h05 ) ? 4'hB :
             ( x == 6'h06 ) ? 4'hE :
             ( x == 6'h07 ) ? 4'h7 :
             ( x == 6'h08 ) ? 4'hF :
             ( x == 6'h09 ) ? 4'h4 :
             ( x == 6'h0A ) ? 4'h0 :
             ( x == 6'h0B ) ? 4'h9 :
             ( x == 6'h0C ) ? 4'h8 :
             ( x == 6'h0D ) ? 4'h1 :
             ( x == 6'h0E ) ? 4'hD :
             ( x == 6'h0F ) ? 4'hA :
             ( x == 6'h10 ) ? 4'h3 :
             ( x == 6'h11 ) ? 4'hE :
             ( x == 6'h12 ) ? 4'hC :
             ( x == 6'h13 ) ? 4'h3 :
             ( x == 6'h14 ) ? 4'h9 :
             ( x == 6'h15 ) ? 4'h5 :
             ( x == 6'h16 ) ? 4'h7 :
             ( x == 6'h17 ) ? 4'hC :
             ( x == 6'h18 ) ? 4'h5 :
             ( x == 6'h19 ) ? 4'h2 :
             ( x == 6'h1A ) ? 4'hA :
             ( x == 6'h1B ) ? 4'hF :
             ( x == 6'h1C ) ? 4'h6 :
             ( x == 6'h1D ) ? 4'h8 :
             ( x == 6'h1E ) ? 4'h1 :
             ( x == 6'h1F ) ? 4'h6 :
             ( x == 6'h20 ) ? 4'h1 :
             ( x == 6'h21 ) ? 4'h6 :
             ( x == 6'h22 ) ? 4'h4 :
             ( x == 6'h23 ) ? 4'hB :
             ( x == 6'h24 ) ? 4'hB :
             ( x == 6'h25 ) ? 4'hD :
             ( x == 6'h26 ) ? 4'hD :
             ( x == 6'h27 ) ? 4'h8 :
             ( x == 6'h28 ) ? 4'hC :
             ( x == 6'h29 ) ? 4'h1 :
             ( x == 6'h2A ) ? 4'h3 :
             ( x == 6'h2B ) ? 4'h4 :
             ( x == 6'h2C ) ? 4'h7 :
             ( x == 6'h2D ) ? 4'hA :
             ( x == 6'h2E ) ? 4'hE :
             ( x == 6'h2F ) ? 4'h7 :
             ( x == 6'h30 ) ? 4'hA :
             ( x == 6'h31 ) ? 4'h9 :
             ( x == 6'h32 ) ? 4'hF :
             ( x == 6'h33 ) ? 4'h5 :
             ( x == 6'h34 ) ? 4'h6 :
             ( x == 6'h35 ) ? 4'h0 :
             ( x == 6'h36 ) ? 4'h8 :
             ( x == 6'h37 ) ? 4'hF :
             ( x == 6'h38 ) ? 4'h0 :
             ( x == 6'h39 ) ? 4'hE :
             ( x == 6'h3A ) ? 4'h5 :
             ( x == 6'h3B ) ? 4'h2 :
             ( x == 6'h3C ) ? 4'h9 :
             ( x == 6'h3D ) ? 4'h3 :
             ( x == 6'h3E ) ? 4'h2 :
             ( x == 6'h3F ) ? 4'hC : 4'h0;

endmodule

module sbox_2( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'hC :
             ( x == 6'h01 ) ? 4'hA :
             ( x == 6'h02 ) ? 4'h1 :
             ( x == 6'h03 ) ? 4'hF :
             ( x == 6'h04 ) ? 4'hA :
             ( x == 6'h05 ) ? 4'h4 :
             ( x == 6'h06 ) ? 4'hF :
             ( x == 6'h07 ) ? 4'h2 :
             ( x == 6'h08 ) ? 4'h9 :
             ( x == 6'h09 ) ? 4'h7 :
             ( x == 6'h0A ) ? 4'h2 :
             ( x == 6'h0B ) ? 4'hC :
             ( x == 6'h0C ) ? 4'h6 :
             ( x == 6'h0D ) ? 4'h9 :
             ( x == 6'h0E ) ? 4'h8 :
             ( x == 6'h0F ) ? 4'h5 :
             ( x == 6'h10 ) ? 4'h0 :
             ( x == 6'h11 ) ? 4'h6 :
             ( x == 6'h12 ) ? 4'hD :
             ( x == 6'h13 ) ? 4'h1 :
             ( x == 6'h14 ) ? 4'h3 :
             ( x == 6'h15 ) ? 4'hD :
             ( x == 6'h16 ) ? 4'h4 :
             ( x == 6'h17 ) ? 4'hE :
             ( x == 6'h18 ) ? 4'hE :
             ( x == 6'h19 ) ? 4'h0 :
             ( x == 6'h1A ) ? 4'h7 :
             ( x == 6'h1B ) ? 4'hB :
             ( x == 6'h1C ) ? 4'h5 :
             ( x == 6'h1D ) ? 4'h3 :
             ( x == 6'h1E ) ? 4'hB :
             ( x == 6'h1F ) ? 4'h8 :
             ( x == 6'h20 ) ? 4'h9 :
             ( x == 6'h21 ) ? 4'h4 :
             ( x == 6'h22 ) ? 4'hE :
             ( x == 6'h23 ) ? 4'h3 :
             ( x == 6'h24 ) ? 4'hF :
             ( x == 6'h25 ) ? 4'h2 :
             ( x == 6'h26 ) ? 4'h5 :
             ( x == 6'h27 ) ? 4'hC :
             ( x == 6'h28 ) ? 4'h2 :
             ( x == 6'h29 ) ? 4'h9 :
             ( x == 6'h2A ) ? 4'h8 :
             ( x == 6'h2B ) ? 4'h5 :
             ( x == 6'h2C ) ? 4'hC :
             ( x == 6'h2D ) ? 4'hF :
             ( x == 6'h2E ) ? 4'h3 :
             ( x == 6'h2F ) ? 4'hA :
             ( x == 6'h30 ) ? 4'h7 :
             ( x == 6'h31 ) ? 4'hB :
             ( x == 6'h32 ) ? 4'h0 :
             ( x == 6'h33 ) ? 4'hE :
             ( x == 6'h34 ) ? 4'h4 :
             ( x == 6'h35 ) ? 4'h1 :
             ( x == 6'h36 ) ? 4'hA :
             ( x == 6'h37 ) ? 4'h7 :
             ( x == 6'h38 ) ? 4'h1 :
             ( x == 6'h39 ) ? 4'h6 :
             ( x == 6'h3A ) ? 4'hD :
             ( x == 6'h3B ) ? 4'h0 :
             ( x == 6'h3C ) ? 4'hB :
             ( x == 6'h3D ) ? 4'h8 :
             ( x == 6'h3E ) ? 4'h6 :
             ( x == 6'h3F ) ? 4'hD : 4'h0;

endmodule

module sbox_3( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'h2 :
             ( x == 6'h01 ) ? 4'hE :
             ( x == 6'h02 ) ? 4'hC :
             ( x == 6'h03 ) ? 4'hB :
             ( x == 6'h04 ) ? 4'h4 :
             ( x == 6'h05 ) ? 4'h2 :
             ( x == 6'h06 ) ? 4'h1 :
             ( x == 6'h07 ) ? 4'hC :
             ( x == 6'h08 ) ? 4'h7 :
             ( x == 6'h09 ) ? 4'h4 :
             ( x == 6'h0A ) ? 4'hA :
             ( x == 6'h0B ) ? 4'h7 :
             ( x == 6'h0C ) ? 4'hB :
             ( x == 6'h0D ) ? 4'hD :
             ( x == 6'h0E ) ? 4'h6 :
             ( x == 6'h0F ) ? 4'h1 :
             ( x == 6'h10 ) ? 4'h8 :
             ( x == 6'h11 ) ? 4'h5 :
             ( x == 6'h12 ) ? 4'h5 :
             ( x == 6'h13 ) ? 4'h0 :
             ( x == 6'h14 ) ? 4'h3 :
             ( x == 6'h15 ) ? 4'hF :
             ( x == 6'h16 ) ? 4'hF :
             ( x == 6'h17 ) ? 4'hA :
             ( x == 6'h18 ) ? 4'hD :
             ( x == 6'h19 ) ? 4'h3 :
             ( x == 6'h1A ) ? 4'h0 :
             ( x == 6'h1B ) ? 4'h9 :
             ( x == 6'h1C ) ? 4'hE :
             ( x == 6'h1D ) ? 4'h8 :
             ( x == 6'h1E ) ? 4'h9 :
             ( x == 6'h1F ) ? 4'h6 :
             ( x == 6'h20 ) ? 4'h4 :
             ( x == 6'h21 ) ? 4'hB :
             ( x == 6'h22 ) ? 4'h2 :
             ( x == 6'h23 ) ? 4'h8 :
             ( x == 6'h24 ) ? 4'h1 :
             ( x == 6'h25 ) ? 4'hC :
             ( x == 6'h26 ) ? 4'hB :
             ( x == 6'h27 ) ? 4'h7 :
             ( x == 6'h28 ) ? 4'hA :
             ( x == 6'h29 ) ? 4'h1 :
             ( x == 6'h2A ) ? 4'hD :
             ( x == 6'h2B ) ? 4'hE :
             ( x == 6'h2C ) ? 4'h7 :
             ( x == 6'h2D ) ? 4'h2 :
             ( x == 6'h2E ) ? 4'h8 :
             ( x == 6'h2F ) ? 4'hD :
             ( x == 6'h30 ) ? 4'hF :
             ( x == 6'h31 ) ? 4'h6 :
             ( x == 6'h32 ) ? 4'h9 :
             ( x == 6'h33 ) ? 4'hF :
             ( x == 6'h34 ) ? 4'hC :
             ( x == 6'h35 ) ? 4'h0 :
             ( x == 6'h36 ) ? 4'h5 :
             ( x == 6'h37 ) ? 4'h9 :
             ( x == 6'h38 ) ? 4'h6 :
             ( x == 6'h39 ) ? 4'hA :
             ( x == 6'h3A ) ? 4'h3 :
             ( x == 6'h3B ) ? 4'h4 :
             ( x == 6'h3C ) ? 4'h0 :
             ( x == 6'h3D ) ? 4'h5 :
             ( x == 6'h3E ) ? 4'hE :
             ( x == 6'h3F ) ? 4'h3 : 4'h0;

endmodule

module sbox_4( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'h7 :
             ( x == 6'h01 ) ? 4'hD :
             ( x == 6'h02 ) ? 4'hD :
             ( x == 6'h03 ) ? 4'h8 :
             ( x == 6'h04 ) ? 4'hE :
             ( x == 6'h05 ) ? 4'hB :
             ( x == 6'h06 ) ? 4'h3 :
             ( x == 6'h07 ) ? 4'h5 :
             ( x == 6'h08 ) ? 4'h0 :
             ( x == 6'h09 ) ? 4'h6 :
             ( x == 6'h0A ) ? 4'h6 :
             ( x == 6'h0B ) ? 4'hF :
             ( x == 6'h0C ) ? 4'h9 :
             ( x == 6'h0D ) ? 4'h0 :
             ( x == 6'h0E ) ? 4'hA :
             ( x == 6'h0F ) ? 4'h3 :
             ( x == 6'h10 ) ? 4'h1 :
             ( x == 6'h11 ) ? 4'h4 :
             ( x == 6'h12 ) ? 4'h2 :
             ( x == 6'h13 ) ? 4'h7 :
             ( x == 6'h14 ) ? 4'h8 :
             ( x == 6'h15 ) ? 4'h2 :
             ( x == 6'h16 ) ? 4'h5 :
             ( x == 6'h17 ) ? 4'hC :
             ( x == 6'h18 ) ? 4'hB :
             ( x == 6'h19 ) ? 4'h1 :
             ( x == 6'h1A ) ? 4'hC :
             ( x == 6'h1B ) ? 4'hA :
             ( x == 6'h1C ) ? 4'h4 :
             ( x == 6'h1D ) ? 4'hE :
             ( x == 6'h1E ) ? 4'hF :
             ( x == 6'h1F ) ? 4'h9 :
             ( x == 6'h20 ) ? 4'hA :
             ( x == 6'h21 ) ? 4'h3 :
             ( x == 6'h22 ) ? 4'h6 :
             ( x == 6'h23 ) ? 4'hF :
             ( x == 6'h24 ) ? 4'h9 :
             ( x == 6'h25 ) ? 4'h0 :
             ( x == 6'h26 ) ? 4'h0 :
             ( x == 6'h27 ) ? 4'h6 :
             ( x == 6'h28 ) ? 4'hC :
             ( x == 6'h29 ) ? 4'hA :
             ( x == 6'h2A ) ? 4'hB :
             ( x == 6'h2B ) ? 4'h1 :
             ( x == 6'h2C ) ? 4'h7 :
             ( x == 6'h2D ) ? 4'hD :
             ( x == 6'h2E ) ? 4'hD :
             ( x == 6'h2F ) ? 4'h8 :
             ( x == 6'h30 ) ? 4'hF :
             ( x == 6'h31 ) ? 4'h9 :
             ( x == 6'h32 ) ? 4'h1 :
             ( x == 6'h33 ) ? 4'h4 :
             ( x == 6'h34 ) ? 4'h3 :
             ( x == 6'h35 ) ? 4'h5 :
             ( x == 6'h36 ) ? 4'hE :
             ( x == 6'h37 ) ? 4'hB :
             ( x == 6'h38 ) ? 4'h5 :
             ( x == 6'h39 ) ? 4'hC :
             ( x == 6'h3A ) ? 4'h2 :
             ( x == 6'h3B ) ? 4'h7 :
             ( x == 6'h3C ) ? 4'h8 :
             ( x == 6'h3D ) ? 4'h2 :
             ( x == 6'h3E ) ? 4'h4 :
             ( x == 6'h3F ) ? 4'hE : 4'h0;

endmodule

module sbox_5( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'hA :
             ( x == 6'h01 ) ? 4'hD :
             ( x == 6'h02 ) ? 4'h0 :
             ( x == 6'h03 ) ? 4'h7 :
             ( x == 6'h04 ) ? 4'h9 :
             ( x == 6'h05 ) ? 4'h0 :
             ( x == 6'h06 ) ? 4'hE :
             ( x == 6'h07 ) ? 4'h9 :
             ( x == 6'h08 ) ? 4'h6 :
             ( x == 6'h09 ) ? 4'h3 :
             ( x == 6'h0A ) ? 4'h3 :
             ( x == 6'h0B ) ? 4'h4 :
             ( x == 6'h0C ) ? 4'hF :
             ( x == 6'h0D ) ? 4'h6 :
             ( x == 6'h0E ) ? 4'h5 :
             ( x == 6'h0F ) ? 4'hA :
             ( x == 6'h10 ) ? 4'h1 :
             ( x == 6'h11 ) ? 4'h2 :
             ( x == 6'h12 ) ? 4'hD :
             ( x == 6'h13 ) ? 4'h8 :
             ( x == 6'h14 ) ? 4'hC :
             ( x == 6'h15 ) ? 4'h5 :
             ( x == 6'h16 ) ? 4'h7 :
             ( x == 6'h17 ) ? 4'hE :
             ( x == 6'h18 ) ? 4'hB :
             ( x == 6'h19 ) ? 4'hC :
             ( x == 6'h1A ) ? 4'h4 :
             ( x == 6'h1B ) ? 4'hB :
             ( x == 6'h1C ) ? 4'h2 :
             ( x == 6'h1D ) ? 4'hF :
             ( x == 6'h1E ) ? 4'h8 :
             ( x == 6'h1F ) ? 4'h1 :
             ( x == 6'h20 ) ? 4'hD :
             ( x == 6'h21 ) ? 4'h1 :
             ( x == 6'h22 ) ? 4'h6 :
             ( x == 6'h23 ) ? 4'hA :
             ( x == 6'h24 ) ? 4'h4 :
             ( x == 6'h25 ) ? 4'hD :
             ( x == 6'h26 ) ? 4'h9 :
             ( x == 6'h27 ) ? 4'h0 :
             ( x == 6'h28 ) ? 4'h8 :
             ( x == 6'h29 ) ? 4'h6 :
             ( x == 6'h2A ) ? 4'hF :
             ( x == 6'h2B ) ? 4'h9 :
             ( x == 6'h2C ) ? 4'h3 :
             ( x == 6'h2D ) ? 4'h8 :
             ( x == 6'h2E ) ? 4'h0 :
             ( x == 6'h2F ) ? 4'h7 :
             ( x == 6'h30 ) ? 4'hB :
             ( x == 6'h31 ) ? 4'h4 :
             ( x == 6'h32 ) ? 4'h1 :
             ( x == 6'h33 ) ? 4'hF :
             ( x == 6'h34 ) ? 4'h2 :
             ( x == 6'h35 ) ? 4'hE :
             ( x == 6'h36 ) ? 4'hC :
             ( x == 6'h37 ) ? 4'h3 :
             ( x == 6'h38 ) ? 4'h5 :
             ( x == 6'h39 ) ? 4'hB :
             ( x == 6'h3A ) ? 4'hA :
             ( x == 6'h3B ) ? 4'h5 :
             ( x == 6'h3C ) ? 4'hE :
             ( x == 6'h3D ) ? 4'h2 :
             ( x == 6'h3E ) ? 4'h7 :
             ( x == 6'h3F ) ? 4'hC : 4'h0;

endmodule

module sbox_6( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'hF :
             ( x == 6'h01 ) ? 4'h3 :
             ( x == 6'h02 ) ? 4'h1 :
             ( x == 6'h03 ) ? 4'hD :
             ( x == 6'h04 ) ? 4'h8 :
             ( x == 6'h05 ) ? 4'h4 :
             ( x == 6'h06 ) ? 4'hE :
             ( x == 6'h07 ) ? 4'h7 :
             ( x == 6'h08 ) ? 4'h6 :
             ( x == 6'h09 ) ? 4'hF :
             ( x == 6'h0A ) ? 4'hB :
             ( x == 6'h0B ) ? 4'h2 :
             ( x == 6'h0C ) ? 4'h3 :
             ( x == 6'h0D ) ? 4'h8 :
             ( x == 6'h0E ) ? 4'h4 :
             ( x == 6'h0F ) ? 4'hE :
             ( x == 6'h10 ) ? 4'h9 :
             ( x == 6'h11 ) ? 4'hC :
             ( x == 6'h12 ) ? 4'h7 :
             ( x == 6'h13 ) ? 4'h0 :
             ( x == 6'h14 ) ? 4'h2 :
             ( x == 6'h15 ) ? 4'h1 :
             ( x == 6'h16 ) ? 4'hD :
             ( x == 6'h17 ) ? 4'hA :
             ( x == 6'h18 ) ? 4'hC :
             ( x == 6'h19 ) ? 4'h6 :
             ( x == 6'h1A ) ? 4'h0 :
             ( x == 6'h1B ) ? 4'h9 :
             ( x == 6'h1C ) ? 4'h5 :
             ( x == 6'h1D ) ? 4'hB :
             ( x == 6'h1E ) ? 4'hA :
             ( x == 6'h1F ) ? 4'h5 :
             ( x == 6'h20 ) ? 4'h0 :
             ( x == 6'h21 ) ? 4'hD :
             ( x == 6'h22 ) ? 4'hE :
             ( x == 6'h23 ) ? 4'h8 :
             ( x == 6'h24 ) ? 4'h7 :
             ( x == 6'h25 ) ? 4'hA :
             ( x == 6'h26 ) ? 4'hB :
             ( x == 6'h27 ) ? 4'h1 :
             ( x == 6'h28 ) ? 4'hA :
             ( x == 6'h29 ) ? 4'h3 :
             ( x == 6'h2A ) ? 4'h4 :
             ( x == 6'h2B ) ? 4'hF :
             ( x == 6'h2C ) ? 4'hD :
             ( x == 6'h2D ) ? 4'h4 :
             ( x == 6'h2E ) ? 4'h1 :
             ( x == 6'h2F ) ? 4'h2 :
             ( x == 6'h30 ) ? 4'h5 :
             ( x == 6'h31 ) ? 4'hB :
             ( x == 6'h32 ) ? 4'h8 :
             ( x == 6'h33 ) ? 4'h6 :
             ( x == 6'h34 ) ? 4'hC :
             ( x == 6'h35 ) ? 4'h7 :
             ( x == 6'h36 ) ? 4'h6 :
             ( x == 6'h37 ) ? 4'hC :
             ( x == 6'h38 ) ? 4'h9 :
             ( x == 6'h39 ) ? 4'h0 :
             ( x == 6'h3A ) ? 4'h3 :
             ( x == 6'h3B ) ? 4'h5 :
             ( x == 6'h3C ) ? 4'h2 :
             ( x == 6'h3D ) ? 4'hE :
             ( x == 6'h3E ) ? 4'hF :
             ( x == 6'h3F ) ? 4'h9 : 4'h0;

endmodule

module sbox_7( output wire [ 3 : 0 ] r, 
                input wire [ 5 : 0 ] x );

  assign r = ( x == 6'h00 ) ? 4'hE :
             ( x == 6'h01 ) ? 4'h0 :
             ( x == 6'h02 ) ? 4'h4 :
             ( x == 6'h03 ) ? 4'hF :
             ( x == 6'h04 ) ? 4'hD :
             ( x == 6'h05 ) ? 4'h7 :
             ( x == 6'h06 ) ? 4'h1 :
             ( x == 6'h07 ) ? 4'h4 :
             ( x == 6'h08 ) ? 4'h2 :
             ( x == 6'h09 ) ? 4'hE :
             ( x == 6'h0A ) ? 4'hF :
             ( x == 6'h0B ) ? 4'h2 :
             ( x == 6'h0C ) ? 4'hB :
             ( x == 6'h0D ) ? 4'hD :
             ( x == 6'h0E ) ? 4'h8 :
             ( x == 6'h0F ) ? 4'h1 :
             ( x == 6'h10 ) ? 4'h3 :
             ( x == 6'h11 ) ? 4'hA :
             ( x == 6'h12 ) ? 4'hA :
             ( x == 6'h13 ) ? 4'h6 :
             ( x == 6'h14 ) ? 4'h6 :
             ( x == 6'h15 ) ? 4'hC :
             ( x == 6'h16 ) ? 4'hC :
             ( x == 6'h17 ) ? 4'hB :
             ( x == 6'h18 ) ? 4'h5 :
             ( x == 6'h19 ) ? 4'h9 :
             ( x == 6'h1A ) ? 4'h9 :
             ( x == 6'h1B ) ? 4'h5 :
             ( x == 6'h1C ) ? 4'h0 :
             ( x == 6'h1D ) ? 4'h3 :
             ( x == 6'h1E ) ? 4'h7 :
             ( x == 6'h1F ) ? 4'h8 :
             ( x == 6'h20 ) ? 4'h4 :
             ( x == 6'h21 ) ? 4'hF :
             ( x == 6'h22 ) ? 4'h1 :
             ( x == 6'h23 ) ? 4'hC :
             ( x == 6'h24 ) ? 4'hE :
             ( x == 6'h25 ) ? 4'h8 :
             ( x == 6'h26 ) ? 4'h8 :
             ( x == 6'h27 ) ? 4'h2 :
             ( x == 6'h28 ) ? 4'hD :
             ( x == 6'h29 ) ? 4'h4 :
             ( x == 6'h2A ) ? 4'h6 :
             ( x == 6'h2B ) ? 4'h9 :
             ( x == 6'h2C ) ? 4'h2 :
             ( x == 6'h2D ) ? 4'h1 :
             ( x == 6'h2E ) ? 4'hB :
             ( x == 6'h2F ) ? 4'h7 :
             ( x == 6'h30 ) ? 4'hF :
             ( x == 6'h31 ) ? 4'h5 :
             ( x == 6'h32 ) ? 4'hC :
             ( x == 6'h33 ) ? 4'hB :
             ( x == 6'h34 ) ? 4'h9 :
             ( x == 6'h35 ) ? 4'h3 :
             ( x == 6'h36 ) ? 4'h7 :
             ( x == 6'h37 ) ? 4'hE :
             ( x == 6'h38 ) ? 4'h3 :
             ( x == 6'h39 ) ? 4'hA :
             ( x == 6'h3A ) ? 4'hA :
             ( x == 6'h3B ) ? 4'h0 :
             ( x == 6'h3C ) ? 4'h5 :
             ( x == 6'h3D ) ? 4'h6 :
             ( x == 6'h3E ) ? 4'h0 :
             ( x == 6'h3F ) ? 4'hD : 4'h0;

endmodule
