{ config, pkgs, ... }:
{
  # Security settings
  security.pam.services.sudo_local.touchIdAuth = true;

  # Network security settings
  networking.knownNetworkServices = [ "Wi-Fi" "Ethernet" ];
  networking.dns = [ "1.1.1.1" ];  # Cloudflare DNS for better privacy and performance

  # Services
  services = {
    tailscale.enable = false;  # VPN service, disabled by default
  };
} 
