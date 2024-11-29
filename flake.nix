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
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      # Helper to generate outputs for each system
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          pkgs.buildGoModule {
            pname = "vault";
            version = "1.9.1";
            src = pkgs.fetchFromGitHub {
              owner = "hashicorp";
              repo = "vault";
              rev = "v1.17.0";
              sha256 = null;
            };
            vendorHash = "sha256-VUiBfJ+AJqnuBt5SawjVcldeMnRonxh0/JBNVPbLk+U=";

            subPackages = [ "." ];
          };
      });
    };
  #pkgs.buildGoModule {
  #  pname = "vault";
  #  version = "1.9.1";
  #  src = pkgs.fetchFromGitHub {
  #    owner = "hashicorp";
  #    repo = "vault";
  #    rev = "v1.17.0";
  #    sha256 = null;
  #  };
  #  vendorHash = "sha256-VUiBfJ+AJqnuBt5SawjVcldeMnRonxh0/JBNVPbLk+U=";

  #  subPackages = [ "." ];
  #  #packages.aarch64-linux.vault =
  #  #  let
  #  #    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  #  #  in
  #  #  pkgs.buildGoModule {
  #  #    pname = "vault";
  #  #    version = "1.9.1";
  #  #    src = pkgs.fetchFromGitHub {
  #  #      owner = "hashicorp";
  #  #      repo = "vault";
  #  #      rev = "v1.17.0";
  #  #      sha256 = null;
  #  #    };
  #  #    vendorHash = "sha256-VUiBfJ+AJqnuBt5SawjVcldeMnRonxh0/JBNVPbLk+U=";

  #  #    subPackages = [ "." ];
  #  #  };
  #};
}
