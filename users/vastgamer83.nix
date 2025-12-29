{ config, pkgs, ... }:
let 
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		kitty = "kitty";
		hypr = "hypr";
		nvim = "nvim";
		rofi = "rofi";
		scripts = "scripts";
		tmux = "tmux";
		waybar = "waybar";
		yazi = "yazi";
	};
in
{
	home.username = "vastgamer83";
	home.homeDirectory = "/home/vastgamer83";
	home.stateVersion = "25.11";

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
		fzf
		wl-clipboard
		yazi
		neofetch
		gnumake
		pavucontrol

		steam
		# modrinth-app
		prismlauncher

		discord
	];
}
