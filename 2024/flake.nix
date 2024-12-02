{
  description = "Advent of Code 2024";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShell = pkgs.mkShellNoCC {
          buildInputs = [
            (pkgs.lua54Packages.lua.withPackages (ps: [ps.inspect]))
            pkgs.lua54Packages.luarocks
          ];
          inputFrom = [
            self.packages.${system}.day1
            self.packages.${system}.day2
          ];
        };
        packages = {
          day1 = pkgs.lua54Packages.buildLuaApplication {
            pname = "aoc-2024-01";
            version = "0.1.0";
            rockspecVersion = "0.1.0-1";
            src = ./01;
            rockspecFilename = ./01/aoc-2024-01-0.1.0-1.rockspec;
            knownRockspec = ./01/aoc-2024-01-0.1.0-1.rockspec;
            propagatedBuildInputs = [pkgs.lua54Packages.inspect];
            meta.mainProgram = "day1";
          };
          day2 = pkgs.stdenv.mkDerivation {
            pname = "aoc-2024-02";
            version = "0.1.0";
            src = ./02;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.ps1 $out/bin/day2
              chmod +x $out/bin/day2
            '';
            buildInputs = [pkgs.powershell];
            propagatedBuildInputs = [pkgs.powershell];
            nativeBuildInputs = [pkgs.powershell];
          };
        };
        formatter = pkgs.alejandra;
      }
    );
}
