{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default =
          with pkgs;
          mkShell {
            shellHook = ''
              # Work-around for `dotnet test` breaking in the combined dotnet package when its output is forwarded to a file
              export MSBUILDTERMINALLOGGER=true
            '';
            buildInputs = [
              (dotnetCorePackages.combinePackages [
                dotnet-sdk_8
                dotnet-sdk_9
              ])
            ];
          };
      }
    );
}
