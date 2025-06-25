export PATH="$PATH:/Users/hoan.lac/.foundry/bin"
export PATH=$PATH:/usr/local/go/bin

# # Get GitHub token from keychain with error checking
# if ! GITHUB_TOKEN=$(security find-generic-password -a $USER -s github-token -w 2>/dev/null); then
#     echo "Warning: GitHub token not found in keychain. Please add it using:"
#     echo "security add-generic-password -a \$USER -s github-token -w your_token_here"
# else
#     export GITHUB_TOKEN
#     export HOMEBREW_GITHUB_TOKEN=$GITHUB_TOKEN
# fi
