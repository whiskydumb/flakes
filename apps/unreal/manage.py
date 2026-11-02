import argparse
import json
import logging
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import stat
import tempfile
import zipfile


def validate_version(version: str) -> str:
    if not re.fullmatch(r"[0-9]+\.[0-9]+\.[0-9]+", version):
        raise ValueError("version must have the form 5.8.4")
    return version


def install(archive: Path, root: Path) -> None:
    with zipfile.ZipFile(archive) as source:
        metadata = source.getinfo("Engine/Build/Build.version")
        if metadata.file_size > 65536:
            raise ValueError("unexpectedly large Engine/Build/Build.version")
        version_data = json.loads(source.read(metadata))
        version = validate_version(".".join(str(version_data[key]) for key in (
            "MajorVersion", "MinorVersion", "PatchVersion"
        )))
        destination = root / version
        if destination.exists() or destination.is_symlink():
            raise ValueError(f"{destination} already exists; existing installs are never overwritten")

        members = source.infolist()
        for member in members:
            path = PurePosixPath(member.filename)
            mode = member.external_attr >> 16
            if path.is_absolute() or ".." in path.parts or "\\" in member.filename:
                raise ValueError(f"unsafe archive path: {member.filename}")
            if stat.S_IFMT(mode) not in (0, stat.S_IFREG, stat.S_IFDIR):
                raise ValueError(f"unsupported special archive entry: {member.filename}")
        source.getinfo("Engine/Binaries/Linux/UnrealEditor")
        required = sum(member.file_size for member in members) + 2 * 1024**3
        root.mkdir(parents=True, exist_ok=True)
        if shutil.disk_usage(root).free < required:
            raise ValueError(f"need at least {required / 1024**3:.1f} GiB free in {root}")

        logging.info("installing Unreal %s into %s", version, destination)
        with tempfile.TemporaryDirectory(prefix=".install-", dir=root) as temporary:
            staging = Path(temporary)
            for member in members:
                target = Path(source.extract(member, staging))
                if not member.is_dir():
                    target.chmod(0o755 if (member.external_attr >> 16) & 0o111 else 0o644)
            editor = staging / "Engine/Binaries/Linux/UnrealEditor"
            if not editor.is_file() or not os.access(editor, os.X_OK):
                raise ValueError("archive does not contain an executable Linux UnrealEditor")
            staging.rename(destination)
        logging.info("installed; run: unreal-select %s", version)


def select(version: str, root: Path) -> None:
    destination = root / validate_version(version)
    editor = destination / "Engine/Binaries/Linux/UnrealEditor"
    if not editor.is_file() or not os.access(editor, os.X_OK):
        raise ValueError(f"no executable Unreal installation in {destination}")
    current = root / "current"
    if current.exists() and not current.is_symlink():
        raise ValueError(f"{current} is not a symlink; refusing to replace it")
    with tempfile.TemporaryDirectory(prefix=".select-", dir=root) as temporary:
        link = Path(temporary) / "current"
        link.symlink_to(destination)
        link.replace(current)
    logging.info("selected Unreal %s", version)


def main() -> int:
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    parser = argparse.ArgumentParser(description="Install or select a local Unreal Linux release")
    parser.add_argument("command", choices=("install", "select"))
    parser.add_argument("value", help="Linux ZIP path or installed version")
    args = parser.parse_args()
    root = Path(os.environ.get("UNREAL_HOME", str(Path.home() / "Applications/Unreal"))).expanduser()
    if not root.is_absolute():
        parser.error("UNREAL_HOME must be an absolute path")
    try:
        if args.command == "install":
            install(Path(args.value).expanduser(), root)
        else:
            select(args.value, root)
    except (OSError, ValueError, KeyError, zipfile.BadZipFile, RuntimeError) as error:
        logging.error("Unreal %s failed: %s", args.command, error)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
