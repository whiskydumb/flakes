{ osConfig, ... }:
let
  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL9AJYF4QA2BV0/kdKD1Cllo5tJHe6ePvFE5OuPGeWYr";
  signing = osConfig.settings.hostName == "mochi";
in
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "whisky";
        email = "me@whisky.sh";
        signingkey = pubkey;
      };

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      commit.gpgsign = signing;

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      fetch.prune = true;
      diff.algorithm = "histogram";

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate --all";
      };
    };
  };

  home.file.".ssh/allowed_signers".text = "me@whisky.sh ${pubkey}";
}
