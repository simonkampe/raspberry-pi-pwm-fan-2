{
  description = ''
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachSystem [ flake-utils.lib.system.aarch64-linux ] (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ ];
      config.allowUnfree = true;
    };
  in rec
  {
    packages.raspberry-pi-pwm-fan-2 = pkgs.stdenv.mkDerivation {
      pname = "raspberry-pi-pwm-fan-2";
      version = "2024-04-04";

      src = pkgs.fetchFromGitHub {
        owner = "folkhack";
        repo = "raspberry-pi-pwm-fan-2";
        rev = "d057875";
        sha256 = "sha256-CevQXwQj4Y8iKmTDzzoVlx51ke1tWOX6gBtlHGpiNdY=";
      };

      buildPhase = ''
        make compile
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp pwm_fan_control2 $out/bin/
      '';
    };
  });
}
