class test2 extends uvm_test;
`uvm_component_utils(test2)

my_env my_env_h;

function new (string name, uvm_component parent);
  super.new(name,parent);
endfunction : new

task run_phase(uvm_phase phase);
  seq_of_commands seq;
  seq = seq_of_commands::type_id::create("seq");
  seq.how_many.constraint_mode(0); // turn internal constraint off and replace it by the following constraint
  assert (seq.randomize() with {seq.n > 10 && seq.n < 20;}); 
  phase.raise_objection(this);
  seq.start(my_env_h.my_agent_h.my_sequencer_h);
  phase.drop_objection(this);
endtask
endclass: test2