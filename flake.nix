{
  description = "HashiCorp Vault build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system: {
        vault =
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          pkgs.buildGoModule {
            pname = "vault";
            version = "1.17.0"; # Updated to match rev
            src = pkgs.fetchFromGitHub {
              owner = "hashicorp";
              repo = "vault";
              rev = "v1.17.0";
              sha256 = "sha256-rWaHseFFpKgb6xh8NiitJBLy2Jh8hiu4n4+gcwHXElg="; # Replace with actual sha
            };
            vendorHash = "sha256-vT1n4FN0s9rQFj4HuXPm6lvNdzWZMyrzeWAanHOQqCg";
            subPackages = [ "." ];
          };
        default = self.packages.${system}.vault;
      });
    };
}
