{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "whisky";
        email = "git@whisky.sh";
        signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      commit.gpgSign = true;
      gpg.format = "ssh";
      alias = {
        st = "status";
        cm = "commit -m";
        p = "push";
        pf = "push --force-with-lease";
        wa = "worktree add";
        wl = "worktree list";
        wd = "worktree remove";
        pretty = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      };
    };
  };
}
