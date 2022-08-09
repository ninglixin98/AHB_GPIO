`ifndef LVC_AHB_AGENT_CONFIGURATION_SV
`define LVC_AHB_AGENT_CONFIGURATION_SV


class lvc_ahb_agent_configuration extends uvm_object;

  bit is_active = 1;

  `uvm_object_utils_begin(lvc_ahb_agent_configuration)
  `uvm_object_utils_end

  function new(string name = "lvc_ahb_agent_configuration");
    super.new(name);
  endfunction


endclass

`endif // LVC_AHB_AGENT_CONFIGURATION_SV
