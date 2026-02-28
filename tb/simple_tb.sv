`timescale 1ns / 1ps

module tb_sync_fifo;

    parameter DEPTH = 16;
    parameter WIDTH = 8;

    reg                  clk = 0;
    reg                  rst_n = 0;
    reg                  wr_en = 0;
    reg  [WIDTH-1:0]     wr_data = 0;
    reg                  rd_en = 0;
    wire [WIDTH-1:0]     rd_data;
    wire                 full;
    wire                 empty;

    // Instantiate DUT
    sync_fifo #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .wr_data(wr_data),
        .rd_en(rd_en),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

    // Clock generator
    always #5 clk = ~clk;  // 100 MHz

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_sync_fifo);

        // Reset
        rst_n = 0;
        #20;
        rst_n = 1;

        // Write 5 items
        repeat(5) begin
            @(posedge clk);
            wr_en = 1;
            wr_data = $random;
            $display("Write: %h", wr_data);
        end
        @(posedge clk);
        wr_en = 0;

        // Read them back
        #20;
        repeat(5) begin
            @(posedge clk);
            rd_en = 1;
            #1;  // small delay to see data
            $display("Read : %h", rd_data);
        end
        @(posedge clk);
        rd_en = 0;

        #100;
        $finish;
    end

endmodule