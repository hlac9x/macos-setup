{ pkgs, ... }:

let
  username = "hlac";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";
  environment.systemPackages = with pkgs; [
    eksctl
    ssm-session-manager-plugin
    yarn
  ];
  homebrew = {
    brews = [
      "docker-buildx"
      "docker-completion"
      "docker-compose"
      "docker-credential-helper"
      "docker"
      "mas"     #To use masApps
    ];
    # masApps = {
    #   # Need to be signed into the Mac App Store
    #   "Microsoft To Do" = 1274495053;
    #   "Microsoft Outlook" = 985367838;
    #   "Azure VPN Client" = 1553936137;
    #   "WireGuard" = 1451685025;
    #   "Messenger" = 1480068668;
    # };
    casks = [
      "adguard"
      "anydesk"
      "cursor"
      "dbeaver-community"
      "discord"
      "google-cloud-sdk"
      "istat-menus"
      "lens"
      "microsoft-office"
      "raindropio"
      "slack"
      "surfshark"
      "vlc"
      "whatsapp"
      "zalo"
      "zoom"
      "signal"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file = {
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
        ".config/1Password/ssh/agent.toml" = {
          source = ../files/1password/agent.toml;
        };
        ".config/alacritty/alacritty.toml" = {
          source =  ../files/alacritty/alacritty.toml;
        };
        ".ssh" = {
          source = ../files/ssh/personal;
          recursive = true;
        };
        ".aliases" = {
          source = ../files/alias/personal/aliases;
        };
        ".config/git" = {
          source = ../files/git/personal;
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
      };
      # home.file.".config/alacritty/alacritty.toml".text = builtins.readFile ../files/alacritty.toml;
      home.packages = with pkgs; [

      ];
    };
  };

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
