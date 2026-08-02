{
  description = "Local development environment for alduncanson.com";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      forAllSystems =
        function: nixpkgs.lib.genAttrs systems (system: function (import nixpkgs { inherit system; }));
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.caddy
          ];

          shellHook = ''
            echo "$ caddy run"
            echo "Then open http://localhost:8080"
          '';
        };
      });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = "${pkgs.writeShellScript "serve-site" ''
            exec ${pkgs.caddy}/bin/caddy run --config Caddyfile
          ''}";
        };
      });
    };
}
