// tb/tests/fifo_base_test.sv
`ifndef FIFO_BASE_TEST_SV
`define FIFO_BASE_TEST_SV

class fifo_base_test extends uvm_test;

    `uvm_component_utils(fifo_base_test)

    fifo_env env;  // We'll create env later; for now placeholder

    function new(string name = "fifo_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = fifo_env::type_id::create("env", this);  // placeholder
    endfunction

    virtual task run_phase(uvm_phase phase);
        fifo_base_sequence seq;
        phase.raise_objection(this);
        seq = fifo_base_sequence::type_id::create("seq");
        seq.start(null);  // Start on null sequencer for basic test
        phase.drop_objection(this);
    endtask

endclass

`endif