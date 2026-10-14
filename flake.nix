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
            appstream-glib
            desktop-file-utils
            meson
            ninja
            pkg-config
            wrapGAppsHook4
            rustPlatform.cargoSetupHook
            cargo
            rustc
            rustPlatform.bindgenHook
          ];

          buildInputs = with pkgs; [
            gdk-pixbuf
            glib
            gst_all_1.gstreamer
            gst_all_1.gst-plugins-base
            (gst_all_1.gst-plugins-bad.override { enableZbar = true; })
            gst_all_1.gst-plugins-good
            gst_all_1.gst-plugins-rs
            gtk4
            libadwaita
            openssl
            pipewire
            sqlite
            wayland
            zbar
          ];
        };

        # Output package
        # packages.default = pkgs.callPackage ./. { inherit pkgs; };
      }
    );
}
