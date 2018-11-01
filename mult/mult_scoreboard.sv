class mult_scoreboard extends uvm_subscriber #(mult_input_t);
`uvm_component_utils(mult_scoreboard);

function new(string name, uvm_component parent);
  super.new(name,parent);
endfunction: new

function void write(mult_input_t t);
  int expected_output; 
  string data_str;
  expected_output = t.A * t.B;

  data_str = $sprintf("%d x % d = %d (actual); %d (expected)",t.A, t.B, t.dout, expected_output);

  if (expected_output != t.dout)
    `uvm_error("SELF CHECKER", {"FAIL: ",data_str})
  else
    `uvm_info ("SELF CHECKER", {"PASS: ", data_str}, UVM_HIGH)
endfunction: write

endclass: mult_scoreboard