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
              sha256 = "sha256-jnX3sJJIe62y5p5w7xs5IQ5xE/9aWzM02H2x/p7E9gc=";
            };
            vendorHash = "sha256-vElTK22fIu+pGml+1lQvKyDAAfed16A9NQTEdu5dU58=";
            subPackages = [ "." ];
          };
        default = self.packages.${system}.vault;
      });
    };
}
