{
  networking.firewall.enable = true;
  security.sudo.wheelNeedsPassword = true;

  security.pki.caCertificateBlacklist = [
    "Comodo AAA Services root"
  ];
}
