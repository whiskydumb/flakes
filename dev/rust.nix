{
  pkgs,
  rustPkgs,
  windows ? false,
}:
let
  toolchain = rustPkgs.rust-bin.stable."1.97.1".minimal.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
      "clippy"
    ];
    targets = pkgs.lib.optional windows "x86_64-pc-windows-msvc";
  };
  formatter = rustPkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.rustfmt);
in
pkgs.mkShell (
  {
    name = if windows then "rust-windows" else "rust";
    packages =
      with pkgs;
      [
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
      ]
      ++ pkgs.lib.optionals windows [
        pkgs.cargo-xwin
        pkgs.llvmPackages.clang
        pkgs.llvmPackages.llvm
        pkgs.llvmPackages.lld
      ];
    RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
    RUSTFMT = "${formatter}/bin/rustfmt";
    RUST_FMT_COMMAND = "cargo fmt";
  }
  // pkgs.lib.optionalAttrs windows {
    CARGO_BUILD_TARGET = "x86_64-pc-windows-msvc";
    RUST_CARGO_COMMAND = "cargo xwin";
    XWIN_ARCH = "x86_64";
  }
)
