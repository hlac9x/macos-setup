{ config, pkgs, ... }:
{
  # Nix settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@admin"
      ];
    };
    optimise = {
      automatic = true;
    };
  };

  # Nix packages config
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Auto upgrade nix package and the daemon service
  # services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = true;
    promptInit = "";
  };
  programs.direnv = {
      enable = true;
      silent = true;
  };
} 
