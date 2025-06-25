# Automated macOS workstation setup

A comprehensive macOS workstation setup using Nix, nix-darwin, home-manager, and Homebrew to create a reproducible development environment.

## Prerequisites

- macOS 13 (Ventura) or later
- At least 20GB of free disk space
- Administrator access
- Internet connection
- Apple ID (for Mac App Store apps)

## Features

- **Package Management**: Install and manage packages with [Nix](https://nixos.org/download.html#nix-install-macos), [nix-darwin](https://github.com/LnL7/nix-darwin), [home-manager](https://github.com/nix-community/home-manager), and [Homebrew](https://brew.sh)
- **System Configuration**: Automated system settings and preferences
- **Dotfiles Management**: Centralized configuration for development tools
- **Security Settings**: Preconfigured security and privacy settings
- **Development Environment**: Ready-to-use setup for various development workflows
- **Multiple Profiles**: Support for personal, work, and VM configurations

## Repository Structure

```
.
├── flake.nix              # Main Nix flake configuration
├── configuration.nix      # System-wide configuration entry point
├── Makefile              # Build and setup automation
├── home/                 # User-specific configurations
│   ├── personal.nix      # Personal machine configuration
│   ├── work.nix          # Work machine configuration
│   └── vm.nix            # Virtual machine configuration
├── modules/              # Modular system configurations
│   ├── packages.nix      # Package definitions
│   ├── system.nix        # System preferences
│   ├── security.nix      # Security settings
│   └── nix.nix           # Nix configuration
├── files/                # Configuration files and dotfiles
│   ├── dotfiles/         # Shell and terminal dotfiles
│   ├── git/              # Git configurations
│   ├── nvim/             # Neovim configuration
│   ├── ssh/              # SSH configurations
│   └── [other tools]/    # Various tool configurations
└── shell.nix             # Development shell configuration
```

## Quick Start

### 1. Prepare Your System

**Important**: Do not enable FileVault before installing Nix, as it can cause issues with the installation.

1. Go to **System Settings → Privacy & Security → Full Disk Access**
2. Add and enable **Terminal** application
3. Ensure you have administrator privileges

### 2. Customize Configuration

Before installation, update the configuration files with your details:

1. **Edit `flake.nix`**: Update the `darwinConfigurations` section with your hostname:
   ```nix
   "your-hostname" = darwin.lib.darwinSystem {
     system = "aarch64-darwin"; # or "x86_64-darwin" for Intel Macs
     modules = [
       ./configuration.nix
       home-manager.darwinModules.home-manager
       ./home/personal.nix  # or work.nix, vm.nix
     ];
   ```

2. **Edit your home configuration** (e.g., `home/personal.nix`):
   - Change `username = "hoanlac";` to your username
   - Update the apps and packages list to your preferences
   - Modify system preferences in the `system.defaults` section

### 3. Install

```bash
git clone https://github.com/hlac9x/macos-setup
cd macos-setup
make
```

### 4. Reboot

After installation completes, reboot your system to ensure all changes take effect.

## Available Make Targets

- `make` or `make build`: Full installation and system rebuild
- `make update`: Update all packages (Nix flakes and Homebrew)
- `make rosetta`: Install Rosetta 2 (for Apple Silicon Macs)
- `make add-cron-job`: Add automated backup job
- `make remove-cron-job`: Remove automated backup job

## Configuration Profiles

The setup supports multiple configuration profiles:

- **Personal** (`home/personal.nix`): Personal development setup
- **Work** (`home/work.nix`): Work-specific configuration
- **VM** (`home/vm.nix`): Virtual machine optimized setup

Each profile can have different:
- Package sets
- Dotfile configurations
- System preferences
- Homebrew apps and casks

## Troubleshooting

### Common Issues

1. **Nix Installation Fails**
   - Ensure you have sufficient disk space (20GB+)
   - Check if FileVault is disabled during installation
   - Verify Terminal has Full Disk Access permissions
   - Try running: `sudo rm /etc/nix/nix.conf` and retry

2. **Hostname Not Found Error**
   - Check your hostname with: `hostname -s`
   - Update `flake.nix` to match your actual hostname
   - Or create a new configuration block with your hostname

3. **Package Installation Issues**
   - Clean up old packages: `nix-collect-garbage -d`
   - Update flake inputs: `nix flake update`
   - Check network connectivity
   - Verify nixpkgs version compatibility

4. **System Preferences Not Applied**
   - Ensure you have administrator privileges
   - Check privacy settings allow system modification
   - Try logging out and back in
   - Run: `sudo /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u`

5. **Homebrew Issues**
   - Verify Homebrew installation: `/opt/homebrew/bin/brew --version`
   - Update Homebrew: `brew update && brew upgrade`
   - Check cask installation permissions

### Getting Help

- Review [nix-darwin documentation](https://github.com/LnL7/nix-darwin)
- Check [home-manager documentation](https://github.com/nix-community/home-manager)
- Search existing issues in this repository
- Open a new issue with detailed error information

## Testing in Virtual Machine

For safe testing before applying to your main system:

1. Install [UTM](https://getutm.app) virtualization software
2. Download [macOS IPSW recovery file](https://ipsw.me/product/Mac) for your target version
3. Create a new macOS VM in UTM using the IPSW file
4. In the VM, run: `xcode-select --install`
5. Clone the VM (for easy rollback - UTM doesn't support snapshots yet)
6. Test the installation process in the cloned VM

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgements

- [Setup nix, nix-darwin and home-manager from scratch on an M1 Macbook Pro](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
- [Nix Darwin](https://github.com/LnL7/nix-darwin) by Daiderd Jordan
- [Home Manager](https://github.com/nix-community/home-manager) by the Nix community
- [Nixpkgs](https://github.com/NixOS/nixpkgs) by the NixOS community
