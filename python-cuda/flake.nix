{
  description = "python and cuda virtual environments";

  nixConfig = {
    extra-substituters = [ "https://cuda-maintainers.cachix.org" ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
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
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              cudaSupport = true;
            };
          };
        in
        {
          devshells.default = rec {
            env = [
              {
                name = "CUDA_PATH";
                value = "${pkgs.cudatoolkit}";
              }
              {
                name = "LD_LIBRARY_PATH";
                value = pkgs.lib.makeLibraryPath packages;
              }
              {
                name = "EXTRA_LDFLAGS";
                value = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
              }
              {
                name = "EXTRA_CCFLAGS";
                value = "-I/usr/include";
              }
            ];
            commands = [ ];
            packages = with pkgs; [
              python310
              ruff

              git
              gitRepo
              gnupg
              autoconf
              curl
              procps
              gnumake
              util-linux
              m4
              gperf
              unzip
              cudatoolkit
              linuxPackages.nvidia_x11
              libGLU
              libGL
              xorg.libXi
              xorg.libXmu
              freeglut
              xorg.libXext
              xorg.libX11
              xorg.libXv
              xorg.libXrandr
              zlib
              ncurses5
              stdenv.cc
              binutils

              # sd need
              gperftools
              glib.out
              glibc
            ];
          };
        };
    };
}
