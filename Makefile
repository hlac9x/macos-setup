.POSIX:
.PHONY: default build update

default: build

/nix:
	curl -L https://nixos.org/nix/install | sh
	# TODO https://github.com/LnL7/nix-darwin/issues/149
	NIX_FIRST_BUILD_UID="305" sudo rm /etc/nix/nix.conf

/run/current-system/sw/bin/darwin-rebuild:
	sudo nix --extra-experimental-features 'nix-command flakes' build https://github.com/LnL7/nix-darwin/archive/master.tar.gz

/opt/homebrew/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/brew-install.sh
	NONINTERACTIVE=1 bash /tmp/brew-install.sh

build: /nix /run/current-system/sw/bin/darwin-rebuild /opt/homebrew/bin/brew
	/nix/var/nix/profiles/default/bin/nix --experimental-features 'nix-command flakes' build ./\#darwinConfigurations.$(shell hostname -s).system
	sudo ./result/sw/bin/darwin-rebuild switch --flake .

update:
	nix flake update && brew upgrade

rosetta:
	sudo softwareupdate --install-rosetta --agree-to-license

####RSYNC#####
# Define the rsync command
RSYNC_CMD = rsync -avz ~/.zsh_history "/Users/hoanlac/OneDrive/Hoan's Data/history/zsh_history"

# Define the cron job entry
CRON_JOB = "*/5 * * * * $(RSYNC_CMD)"

# Target to add the cron job
add-cron-job:
	@echo Adding cron job to run every 5 minutes...
	@(crontab -l ; echo $(CRON_JOB)) | crontab -
	@echo Cron job added successfully.

# Target to remove the cron job
remove-cron-job:
	@echo Removing the cron job...
	@crontab -l | grep -v "$(RSYNC_CMD)" | crontab -
	@echo Cron job removed successfully.
