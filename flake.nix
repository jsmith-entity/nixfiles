{
	description = "NixOS";
	inputs = {
		nixpks.url = "nixpkgs/nixos-25.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	};

	outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, ... }: 
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
	in
	{
		nixosConfigurations.computer144 = nixpkgs.lib.nixosSystem {
			system = "${system}";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.jsmith-entity = import ./users/jsmith-entity.nix;
						backupFileExtension = "backup";
					};
				}
				{
					nixpkgs.overlays = [
						neovim-nightly-overlay.overlays.default
					];
				}
			];
		};		
	};
}
