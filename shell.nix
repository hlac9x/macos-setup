# Default package revision
# To update, copy the new revision from https://status.nixos.org (nixpkgs-unstable)
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6c43a3495a11.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.argocd
    pkgs.azure-cli
    pkgs.gh
    pkgs.istioctl
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.kustomize
    pkgs.sops
    # pkgs.terragrunt
    (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/d171f5d.tar.gz") {}).terragrunt
    pkgs.tflint
    pkgs.yq-go

    # Pinned revisions (try to avoid it unless we have to use a specific version)
    #
    # To find the revision of a specific package version:
    #   - Go to https://search.nixos.org and find the package
    #   - Click the source button to view the Nix expression
    #   - Click History and find the commit contains the version
    # Example: https://github.com/NixOS/nixpkgs/commit/18692f7718b8568f1738a334397db887e27e26ae
    #
    (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/18692f7.tar.gz") {}).terraform
  ];
}