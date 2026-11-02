{ pkgs }:
let
  compiler = pkgs.llvmPackages.clang.override {
    bintools = pkgs.llvmPackages.bintools;
  };
in
pkgs.mkShell.override { stdenv = pkgs.overrideCC pkgs.stdenv compiler; } {
  name = "cpp";
  packages = with pkgs; [
    llvmPackages.clang-tools
    llvmPackages.llvm
    llvmPackages.lld
    llvmPackages.lldb
    cmake
    ninja
    pkg-config
    mold
    just
  ];
}
