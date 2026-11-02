{ pkgs, rustPkgs }:
let
  toolchain = rustPkgs.rust-bin.stable."1.97.1".minimal.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
      "clippy"
    ];
  };
  formatter = rustPkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.rustfmt);
in
pkgs.mkShell {
  name = "rust";
  packages = with pkgs; [
    toolchain
    formatter
    just
    typos
    lldb
    pkg-config
    cargo-nextest
    cargo-edit
    cargo-audit
    cargo-deny
  ];
  RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
  RUSTFMT = "${formatter}/bin/rustfmt";
  RUST_FMT_COMMAND = "cargo fmt";
}
