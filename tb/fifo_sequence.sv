// tb/fifo_sequence.sv
class fifo_base_sequence extends uvm_sequence #(fifo_seq_item);

    `uvm_object_utils(fifo_base_sequence)

    function new(string name = "fifo_base_sequence");
        super.new(name);
    endfunction

    task body();
        fifo_seq_item item;

        repeat(20) begin
            item = fifo_seq_item::type_id::create("item");
            start_item(item);
            assert(item.randomize() with {
                wr_en dist {1 := 70, 0 := 30};
                rd_en dist {1 := 50, 0 := 50};
            });
            `uvm_info("SEQ", $sformatf("Generated item: wr_en=%0b wr_data=%02h rd_en=%0b", 
                                       item.wr_en, item.wr_data, item.rd_en), UVM_MEDIUM)
            finish_item(item);
        end
    endtask

endclass