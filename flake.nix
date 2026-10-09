{
  description = "Development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, ... }: {
        formatter = pkgs.nixfmt;

        devShells.default = pkgs.mkShell {
          packages =
            with pkgs;
            with python3Packages;
            [
              astro-language-server
              biome
              markdown-oxide
              nixd
              nixfmt
              nodejs
              pnpm
              svelte-language-server
              tailwindcss_4
              tailwindcss-language-server
              typescript-language-server
              wrangler
            ];
        };
      };
    };
}
