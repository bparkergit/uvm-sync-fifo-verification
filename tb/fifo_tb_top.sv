// tb/fifo_tb_top.sv
`timescale 1ns / 1ps

`include "tb/fifo_pkg.sv"
import fifo_pkg::*;

module fifo_tb_top;

    // Parameters (match DUT)
    parameter int DEPTH = 16;
    parameter int WIDTH = 8;

    // Clock and reset
    logic clk = 0;
    logic rst_n = 0;

    always #5 clk = ~clk;

    // Interface instance
    fifo_if #(.DEPTH(DEPTH), .WIDTH(WIDTH)) fifo_if_inst (.clk(clk), .rst_n(rst_n));

    // DUT instance
    sync_fifo #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(fifo_if_inst.wr_en),
        .wr_data(fifo_if_inst.wr_data),
        .rd_en(fifo_if_inst.rd_en),
        .rd_data(fifo_if_inst.rd_data),
        .full(fifo_if_inst.full),
        .empty(fifo_if_inst.empty)
    );

    // UVM initial block
    initial begin
        uvm_config_db #(virtual fifo_if #(.DEPTH(DEPTH), .WIDTH(WIDTH)))::set(null, "uvm_test_top.env.agent.*", "vif", fifo_if_inst);
        run_test("fifo_base_test");  // we'll create this next
    end

    // Optional: dump waves
    initial begin
        $dumpfile("fifo_uvm.vcd");
        $dumpvars(0, fifo_tb_top);
    end

endmodule