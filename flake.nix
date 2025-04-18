{
  description = "Flake Intro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";  # Adjust home-manager version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

	nixosConfigurations.arkarAX = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration.nix

			home-manager.nixosModules.home-manager
			{
			      home-manager.useGlobalPkgs = true;
			      home-manager.useUserPackages = true;
			      home-manager.backupFileExtension = "backup";
			      home-manager.users.arkar = ./home;

			      # Optionally, use home-manager.extraSpecialArgs to pass
			      # arguments to home.nix

			      home-manager.extraSpecialArgs = {
				inherit inputs;
			      };
			}

		];

	};


  };
}
