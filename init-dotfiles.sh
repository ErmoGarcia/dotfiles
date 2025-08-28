# Add zsh plugins
mkdir -p "$HOME/.zsh/themes"
mkdir -p "$HOME/.zsh/plugins"
git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/themes/spaceship-prompt"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/plugins/fast-syntax-highlighting/
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/plugins/fzf-tab

# Add tmux plugins
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
git clone https://github.com/tmux-plugins/tmux-cpu ~/.config/tmux/plugins/tmux-cpu
git clone https://github.com/tmux-plugins/tmux-battery ~/.config/tmux/plugins/tmux-battery
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrrect
