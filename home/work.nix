{ pkgs, ... }:

let
  username = "hlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";
  environment.systemPackages = with pkgs; [
    packer
    sops
  ];

  homebrew = {
    masApps = {
      # Need to be signed into the Mac App Store
      "Azure VPN Client" = 1553936137;
      "WireGuard" = 1451685025;
    };

    brews = [
      "ansible"
      "gh"
    ];
    casks = [
      "1password-cli"
      "openlens"
      "signal"
      "stats"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file = {
        "shell.nix" = {
          source = ../files/shell/shell.nix;
        };
        ".bash_profile" = {
          source = ../files/dotfiles/.bash_profile;
        };
        ".bashrc" = {
          source = ../files/dotfiles/.bashrc;
        };
        ".gitignore" = {
          source = ../files/dotfiles/.gitignore;
        };
        ".p10k.zsh" = {
          source = ../files/dotfiles/.p10k.zsh;
        };
        ".zshenv" = {
          source = ../files/dotfiles/.zshenv;
        };
        ".zshrc" = {
          source = ../files/dotfiles/.zshrc;
        };
        ".config/1Password/ssh/agent.toml" = {
          source = ../files/1password/agent.toml;
        };
        ".config/alacritty/alacritty.toml" = {
          source =  ../files/alacritty/alacritty.toml;
        };
        ".ssh" = {
          source = ../files/ssh/work;
          recursive = true;
        };
        ".aliases" = {
          source = ../files/alias/work/aliases;
        };
        ".config/git" = {
          source = ../files/git/work;
          recursive = true;
        };
        ".config/git/ignore" = {
          source = ../files/git/ignore;
          recursive = true;
        };
        ".config/nvim" = {
          source = ../files/nvim;
          recursive = true;
        };
        ".config/wezterm" = {
          source = ../files/wezterm;
          recursive = true;
        };
        ".aws/config" = {
          source = ../files/aws/work/config;
          recursive = false;
        };
      };
      home.sessionVariables = {
        HOMEBREW_GITHUB_TOKEN = "$GITHUB_TOKEN";
      };
      # home.file.".config/alacritty/alacritty.toml".text = builtins.readFile ../files/alacritty.toml;
      home.packages = with pkgs; [

      ];
    };
  };

  # Manage hosts file
  #environment.etc."hosts" = {
  #  source = ../files/host/work/hosts;
  #};

  system.primaryUser = "hlac";

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.25;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
      tilesize = 50;
        # `1`: Disabled
        # `2`: Mission Control
        # `3`: Application Windows
        # `4`: Desktop
        # `5`: Start Screen Saver
        # `6`: Disable Screen Saver
        # `7`: Dashboard
        # `10`: Put Display to Sleep
        # `11`: Launchpad
        # `12`: Notification Center
        # `13`: Lock Screen
        # `14`: Quick Note
      wvous-tl-corner = 1;
      wvous-bl-corner = 1;
      wvous-tr-corner = 4;
      wvous-br-corner = 14;
    };
  };
}
