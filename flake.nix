{
  description = "A beginning of an awesome project bootstrapped with bleur/templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    # @ inputs
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter = pkgs.nixfmt-tree;

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            nixd
            nixfmt
            rustc
            rustfmt
            rust-analyzer
            cargo
            clippy
            rustPlatform.bindgenHook
            just
            just-lsp
            appstream-glib
            desktop-file-utils
            meson
            ninja
            pkg-config
            wrapGAppsHook4
            rustPlatform.cargoSetupHook
            rustPlatform.bindgenHook
          ];

          buildInputs = with pkgs; [
            gdk-pixbuf
            glib
            gtk4
            libadwaita
            openssl
          ];
        };

        # Output package
        # packages.default = pkgs.callPackage ./. { inherit pkgs; };
      }
    );
}
