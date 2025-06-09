{ ... }: {
  # Enable VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  boot.kernelModules = [ "vboxdrv" "vboxnetflt" "vboxnetadp" "vboxpci" ];
  boot.blacklistedKernelModules = [ "kvm_amd" "kvm" ];
  users.users.timm.extraGroups = [ "vboxusers" ];
}
