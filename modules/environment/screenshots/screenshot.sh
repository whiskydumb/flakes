set -euo pipefail

exec 9>"${XDG_RUNTIME_DIR:?}/screenshot.lock"
flock -n 9 || exit 0

if region="$(slurp -b 0a0a0d99 -c e2596bff -w 2)"; then
    [[ -n "${region}" ]] || exit 0
else
    status=$?
    if [[ "${status}" -eq 1 ]]; then exit 0; fi
    notify-send -u critical "Screenshot failed" "Could not select a screen region."
    exit "${status}"
fi

capture="$(mktemp --suffix=.png)"
trap 'rm -f -- "${capture}"' EXIT
sleep 0.1
if ! grim -g "${region}" "${capture}"; then
    notify-send -u critical "Screenshot failed" "grim could not capture the selected region."
    exit 1
fi

pictures="$(xdg-user-dir PICTURES)"
destination="${pictures}/Screenshots"
mkdir -p -- "${destination}"
satty --filename "${capture}" --output-filename "${destination}/Screenshot-%Y-%m-%d_%H-%M-%S.png"
