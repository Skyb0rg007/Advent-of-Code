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
          inputsFrom = [
            self.packages.${system}.day1
            self.packages.${system}.day2
            self.packages.${system}.day3
            self.packages.${system}.day4
            self.packages.${system}.day5
            self.packages.${system}.day6
            self.packages.${system}.day7
            self.packages.${system}.day8
            self.packages.${system}.day9
            self.packages.${system}.day10
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
            dontPatch = true;
            dontConfigure = true;
            dontBuild = true;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.ps1 $out/bin/day2
              chmod +x $out/bin/day2
            '';
            buildInputs = [pkgs.powershell];
            doCheck = true;
            checkPhase = ''
              ${pkgs.powershell}/bin/pwsh -Command Invoke-ScriptAnalyzer solution.ps1
            '';
            checkInputs = [self.packages.${system}.PSScriptAnalyzer];
            meta.mainProgram = "day2";
          };
          day3 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-03";
            version = "0.1.0";
            src = ./03;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.pl $out/bin/day3
              chmod +x $out/bin/day3
            '';
            buildInputs = [pkgs.perl];
            meta.mainProgram = "day3";
          };
          day4 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-04";
            version = "0.1.0";
            src = ./04;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.red $out/bin/day4
              chmod +x $out/bin/day4
            '';
            buildInputs = [pkgs.red];
            meta.mainProgram = "day4";
          };
          day5 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-05";
            version = "0.1.0";
            src = ./05;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.awk $out/bin/day5
              chmod +x $out/bin/day5
            '';
            buildInputs = [pkgs.gawk];
            meta.mainProgram = "day5";
          };
          day6 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-06";
            version = "0.1.0";
            src = ./06;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.raku $out/bin/day6
              chmod +x $out/bin/day6
            '';
            buildInputs = [pkgs.rakudo];
            meta.mainProgram = "day6";
          };
          day7 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-07";
            version = "0.1.0";
            src = ./07;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.sh $out/bin/day7
              chmod +x $out/bin/day7
            '';
            propagatedBuildInputs = [pkgs.bc];
            buildInputs = [pkgs.bash];
            meta.mainProgram = "day7";
          };
          day8 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-08";
            version = "0.1.0";
            src = ./08;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.tcl $out/bin/day8
              chmod +x $out/bin/day8
            '';
            buildInputs = [pkgs.tcl-9_0];
            meta.mainProgram = "day8";
          };
          day9 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-09";
            version = "0.1.0";
            src = ./09;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.clj $out/bin/day9
              chmod +x $out/bin/day9
            '';
            buildInputs = [pkgs.clojure];
            meta.mainProgram = "day9";
          };
          day10 = pkgs.stdenvNoCC.mkDerivation {
            pname = "aoc-2024-10";
            version = "0.1.0";
            src = ./10;
            installPhase = ''
              mkdir -p $out/bin
              cp solution.fs $out/bin/day10
              chmod +x $out/bin/day10
            '';
            buildInputs = [pkgs.gforth];
            meta.mainProgram = "day10";
          };
          PSScriptAnalyzer = pkgs.stdenvNoCC.mkDerivation (self: {
            pname = "PSScriptAnalyzer";
            version = "1.23.0";
            src = pkgs.fetchzip {
              url = "https://www.powershellgallery.com/api/v2/package/PSScriptAnalyzer/1.23.0";
              hash = "sha256-9saUmpOcyxuBt/Wn5ifHHTXW+/ftlkBiYKI8k/hzbw0=";
              stripRoot = false;
              extension = "zip";
            };
            installPhase = ''
              mkdir -p $out/share/powershell/Modules/${self.pname}/${self.version}
              for f in ${self.src}/*; do
                case $f in
                  \[Content_Types].xml) ;;
                  _rels) ;;
                  package) ;;
                  *.nuspec) ;;
                  *)
                    cp -r "$f" $out/share/powershell/Modules/${self.pname}/${self.version}
                esac
              done

              mkdir -p $out/nix-support
              cat > $out/nix-support/setup-hook <<EOF
              addToSearchPathWithCustomDelimiter ";" PSModulePath "$out/share/powershell/Modules"
              EOF
              chmod +x $out/nix-support/setup-hook
            '';
          });
        };
        formatter = pkgs.alejandra;
      }
    );
}
