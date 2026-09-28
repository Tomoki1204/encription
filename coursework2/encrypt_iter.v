/* Copyright (C) 2017 Daniel Page <csdsp@bristol.ac.uk>
 *
 * Use of this source code is restricted per the CC BY-NC-ND license, a copy of 
 * which can be found via http://creativecommons.org (and should be included as 
 * LICENSE.txt within the associated archive or repository).
 */

`include "params.h"

module encrypt_iter(  input wire [ `N_K - 1 : 0 ]   k,   //  input    data: cipher key
                      input wire [ `N_B - 1 : 0 ]   m,   //  input    data:  plaintext message
                     output wire [ `N_B - 1 : 0 ]   c,   // output    data: ciphertext message

                      input wire                  clk,   //  input control:       clock signal
                      input wire                  rst,   //  input control:       reset signal
                      input wire                  req,   //  input control:     request signal
                     output wire                  ack ); // output control: acknowledge signal

  // Stage 3: complete this module implementation
 
  reg [1:0]state; //0:idle, 1:compute, 2:wait



  reg [63:0] ip_o;
  reg [31:0] l, r;
  reg [47:0] round_keys[0:15];
  reg [3:0]  r1;


  wire [63:0] ip_r;
  wire [31:0] round_l_o, round_r_o;
  wire [47:0] key_o;
  wire [63:0] final_merge;
  wire [63:0] fp_o;


  perm_IP u_ip(
    .x(m), 
    .r(ip_r));

  split_2 u_split(
    .x(ip_o), 
    .r0(r1), 
    .r1(l));

  round u_round(
    .xl(l), 
    .xr(r1), 
    .k(round_keys[r]), 
    .rl(round_l_o), 
    .rr(round_r_o));

  merge_2 u_merge(
    .x1(r1), 
    .x0(l), 
    .r(final_merge));

  perm_FP u_fp(
    .x(final_merge), 
    .r(fp_o));

  key_schedule u_ks(
    .x(k), 
    .i(r1), 
    .k(key_o)); 

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= 2'b00;
      ack   <= 0;
      r1 <= 0;
    end else begin
      case (state)

        2'b00: begin
          ack <= 0;
          if (req) begin
            ip_o <= ip_r; 
            state <= 2'b01;
            r1 <= 0;
          end
        end

        2'b01: begin
          round_keys[r] <= key_o;

          if (r1 > 0) begin
            l <= round_l_o;
            r <= round_r_o;
          end

          if (r1 == 15) begin
            state <= 2'b10;
          end else begin
            r1 <= r1 + 1;
          end
        end

        2'b10: begin
          c <= fp_o;
          ack <= 1;

          if (!req) begin
            state <= 2'b00;
            ack <= 0;
          end
        end

      endcase
    end
  end
endmodule
