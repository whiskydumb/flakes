{ lib, config, ... }:
{
  config = lib.mkIf config.settings.amd.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
