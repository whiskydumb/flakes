{
  config,
  lib,
  pkgs,
  ...
}:
let
  agent = pkgs.writeShellScript "soteria-session" ''
    set -euo pipefail
    session_id="$(${pkgs.systemd}/bin/loginctl show-user "$(${pkgs.coreutils}/bin/id -u)" --property=Display --value)"
    if [[ -z "$session_id" ]]; then
      printf '%s\n' 'soteria: logind has no display session for this user' >&2
      exit 1
    fi
    export XDG_SESSION_ID="$session_id"
    exec ${lib.getExe config.security.soteria.package}
  '';
in
{
  security.polkit.enable = true;
  security.soteria.enable = true;
  systemd.user.services.polkit-soteria = {
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = lib.mkForce agent;
      Environment = lib.optionals config.virtualisation.vmware.guest.enable [
        "LIBGL_ALWAYS_SOFTWARE=1"
      ];
    };
  };
}
