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
    {
      packages.aarch64-darwin.vault =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        in
        pkgs.buildGoModule {
          pname = "vault";
          version = "1.9.0";
          src = pkgs.fetchFromGitHub {
            owner = "hashicorp";
            repo = "vault";
            rev = "v1.17.0";
            sha256 = null;
          };
          vendorHash = "sha256-vT1n4FN0s9rQFj4HuXPm6lvNdzWZMyrzeWAanHOQqCg";

          subPackages = [ "." ];
        };
      packages.aarch64-linux.vault =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
        in
        pkgs.buildGoModule {
          pname = "vault";
          version = "1.9.0";
          src = pkgs.fetchFromGitHub {
            owner = "hashicorp";
            repo = "vault";
            rev = "v1.17.0";
            sha256 = null;
          };
          vendorHash = "sha256-vT1n4FN0s9rQFj4HuXPm6lvNdzWZMyrzeWAanHOQqCg";

          subPackages = [ "." ];
        };
    };
}
