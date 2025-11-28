{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "computer144"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = false;

  services.displayManager.ly.enable = true;

  # Wayland & Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
	  enable = true;
	  pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.jsmith-entity = {
	shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  users.users.vastgamer83 = {
	shell = pkgs.zsh;
	isNormalUser = true;
	extraGroups = [ "wheel" ];
	packages = with pkgs; [
	  tree
	];
  };

  programs.gnupg.agent.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    hyprland
    vim
    git
	kitty
    wget
	unzip
	gcc
	brave
	neovim
  ];


  fonts.packages = with pkgs; [
	iosevka
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-color-emoji
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.extraInit = ''
	export DISPLAY=:0
	export EDITOR=nvim
  '';

  system.stateVersion = "25.05"; # Did you read the comment?
}

