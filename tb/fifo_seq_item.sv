// tb/fifo_seq_item.sv
class fifo_seq_item extends uvm_sequence_item;

    rand bit         wr_en;
    rand bit [7:0]   wr_data;
    rand bit         rd_en;

    bit [7:0]        rd_data;
    bit              full;
    bit              empty;

    constraint valid_wr_rd {
        !(wr_en && rd_en);
    }

    `uvm_object_utils_begin(fifo_seq_item)
        `uvm_field_int(wr_en,   UVM_ALL_ON)
        `uvm_field_int(wr_data, UVM_ALL_ON)
        `uvm_field_int(rd_en,   UVM_ALL_ON)
        `uvm_field_int(rd_data, UVM_ALL_ON)
        `uvm_field_int(full,    UVM_ALL_ON)
        `uvm_field_int(empty,   UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction

endclass