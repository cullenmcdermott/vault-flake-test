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
    };
}
