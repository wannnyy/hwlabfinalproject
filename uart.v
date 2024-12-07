`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2021 09:59:35 PM
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
// Honestly this is from github
//////////////////////////////////////////////////////////////////////////////////


module uart(
    input clk,
    input rx,
    input [7:0] data_transmit,
    input dte, // data_transmit_enable
    output tx,
    output [7:0] data_received,
    output received
    );
    
    reg en, last_rec;
    wire [7:0] data;
    wire baud;
    wire sent;
    assign data = (dte) ? data_transmit : data_received;
    baudrate_gen baudrate_gen(clk, baud);
    uart_rx receiver(baud, rx, received, data_received);
    uart_tx transmitter(baud, data, en, sent, tx);
    
    always @(posedge baud) begin
        if (en) en = 0;
        if ((~last_rec & received) || dte) begin // if received or pass enable
            en = 1;
        end
        last_rec = received;
    end
    
endmodule