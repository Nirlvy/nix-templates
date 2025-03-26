{
  description = "python env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      devshell,
      nixpkgs,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ devshell.flakeModule ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        {
          devshells.default = {
            env = [ ];
            commands = [ ];
            packages = with pkgs; [
              (python3.withPackages (ps: with ps; [ requestly ]))
              ruff
            ];
          };
        };
    };
}
