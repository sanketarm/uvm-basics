class router_env extends uvm_env;
`uvm_component_utils(router_env);

router_agent       agent_h [router_pkg::NPORT];
router_coverage    coverage_h;
router_scoreboard  scoreboard_h;
 
function new(string name, uvm_component parent);
  super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
  //string port_str;
  foreach (agent_h[i]) begin
    //port_str = $psprintf("agent%d",i);
    agent_h[i] = router_agent::type_id::create($sformatf("agent%d",i), this);
    //port_str = $psprintf("agent%d*",i);
    uvm_config_db #(bit [3:0])              ::set(this, $sformatf("agent%d*",i), "port", i);
    uvm_config_db #(uvm_active_passive_enum)::set(this, $sformatf("agent%d*",i), "is_active", UVM_ACTIVE);
  end
  coverage_h   = router_coverage::type_id::create("coverage", this);
  scoreboard_h = router_scoreboard::type_id::create("scoreboard", this);
  `uvm_info("msg", "ENV Done !", UVM_NONE)
endfunction: build_phase

function void connect_phase(uvm_phase phase);
  `uvm_info("msg", "Connecting ENV", UVM_NONE)
  foreach (agent_h[i]) begin
    agent_h[i].monitor_h.aport.connect(coverage_h.analysis_export);
    agent_h[i].monitor_h.aport.connect(scoreboard_h.analysis_export);
  end
  `uvm_info("msg", "Connecting ENV Done !", UVM_NONE)
endfunction: connect_phase

endclass: router_env