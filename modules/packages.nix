{ config, pkgs, ... }:

let
  # Version pinning for critical packages
  pinned = {
    python = pkgs.python312;
    nodejs = pkgs.nodejs_22;
    terraform = pkgs.terraform_1_7;
    kubectl = pkgs.kubectl_1_28;
  };

  # Package groups
  development = with pkgs; [
    # Language servers and tools
    gopls
    lua-language-server
    nodePackages.typescript-language-server
    pyright
    terraform-ls

    # Development tools
    git
    git-lfs
    pre-commit
    direnv
    virtualenv
    pyenv

    # Networking tools
    inetutils
  ];

  devops = with pkgs; [
    # Kubernetes tools
    kubectl
    kubectl-tree
    kubectx
    kubelogin
    kubent
    kubernetes-helm
    kustomize

    # Cloud tools
    aws-iam-authenticator
    awscli2
    azure-cli

    # Infrastructure tools
    terraform
    terraform-docs
  ];

  utilities = with pkgs; [
    # File operations
    bat
    fd
    ripgrep
    tree
    wget
    curl
    aria

    # Shell tools
    fzf
    zoxide
    direnv

    # Text processing
    jq
    yq
    gh

    # Security
    gnupg
    mkcert

  ];

  editors = with pkgs; [
    neovim
  ];
in
{
  # List packages installed in system profile
  environment.systemPackages =
    development ++
    devops ++
    utilities ++
    editors ++
    [ pkgs.coreutils ];  # Essential system utilities

  environment.systemPath = [
    config.homebrew.brewPrefix
  ];

  fonts.packages = with pkgs; [
    meslo-lgs-nf
    anonymousPro
  ];

  # Homebrew packages with better organization
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    # Organized taps
    taps = [
      { name = "buildpacks/tap"; }
      { name = "kreuzwerker/taps"; }
      { name = "robscott/tap"; }
      { name = "robusta-dev/homebrew-krr"; }
      { name = "terraform-docs/tap"; }
      { name = "warrensbox/tap"; }
    ];

    # Development tools
    brews = [
      "python@3.11"
      "helm-docs"
      "kubecolor"
      "mas"
      "robscott/tap/kube-capacity"
      "terraform-docs"
      "tfenv"
      "tgenv"
    ];

    # GUI Applications
    casks = [
      #AI
      "chatgpt"

      # Security
      "1password"
      "gpg-suite"
      # "lulu"

      # Development
      # "visual-studio-code"
      "alacritty"
      "cursor"
      # "wezterm"
      "orbstack"
      # "evkey"

      # Productivity
      "notion"
      "remote-desktop-manager"
      "shottr"
      "openkey"

      # System utilities
      "bartender"
      "monitorcontrol"

      # File management
      "keka"

      # Browsers
      "microsoft-edge"
    ];
  };
}
