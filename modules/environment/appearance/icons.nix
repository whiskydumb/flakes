{ pkgs, ... }:
let
  palette = import ./palette.nix;
  folders =
    (pkgs.catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "pink";
    }).overrideAttrs
      (old: {
        postPatch = old.postPatch + ''
          find src -type f -name '*cat-mocha-pink*.svg' -exec sed -i \
            -e 's/#F5C2E7/#${palette.accent}/g' \
            -e 's/#E1AED3/#${palette.blood}/g' \
            -e 's/#CDD6F4/#${palette.foreground}/g' {} +
        '';
      });
in
{
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = folders;
  };
}
