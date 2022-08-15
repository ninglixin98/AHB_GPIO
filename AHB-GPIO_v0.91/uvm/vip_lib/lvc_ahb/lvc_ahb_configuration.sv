`ifndef LVC_AHB_CONFIGURATION_SV
`define LVC_AHB_CONFIGURATION_SV


class lvc_ahb_configuration extends uvm_object;
  `uvm_object_utils_begin(lvc_ahb_configuration)
  `uvm_object_utils_end

  function new(string name = "lvc_ahb_configuration");
    super.new(name);
  endfunction


endclass

`endif // LVC_AHB_CONFIGURATION_SV
