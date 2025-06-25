{ config, pkgs, ... }:
{
  # Import modular configurations
  imports = [
    ./modules/packages.nix
    ./modules/system.nix
    ./modules/security.nix
    ./modules/nix.nix
  ];
}
