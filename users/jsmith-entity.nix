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
	home.username = "jsmith-entity";
	home.homeDirectory = "/home/jsmith-entity";
	home.stateVersion = "25.05";

	# Default shell - zsh
	programs.zsh = {
		enable = true;
		shellAliases = {
			c = "clear; ls";
            newproj = "${dotfiles}/scripts/new-project.sh";
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

		typst
		tinymist
		websocat

        grim
        slurp

		opam
		dune_3
		ocamlformat
		ocamlPackages.ocaml-lsp
		ocamlPackages.odoc
		ocamlPackages.utop

        dbeaver-bin
        img2pdf
        pdftk
	];
}
