{ config, pkgs, ... }:
let 
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		alacritty = "alacritty";
		hypr = "hypr";
		nvim = "nvim";
		rofi = "rofi";
		scripts = "scripts";
		tmux = "tmux";
		waybar = "waybar";
	};
in
{
	home.username = "jsmith-entity";
	home.homeDirectory = "/home/jsmith-entity";
	home.stateVersion = "25.05";

	# Default shell - zsh
	programs.zsh = {
		enable = true;
		shellAliases = {
			c = "clear; ls";
		};
		initContent = ''
			source ${dotfiles}/zsh/.zshrc
		'';
	};

	# Config files
	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;
	}) configs;

	home.packages = with pkgs; [
		git
		home-manager
		tmux
		rofi
		waybar
		oh-my-zsh
		fzf
		wl-clipboard
	];
}
