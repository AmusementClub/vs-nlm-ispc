import shutil
import sys
from pathlib import Path
from typing import Any

from hatchling.builders.hooks.plugin.interface import BuildHookInterface
from packaging import tags


class CustomHook(BuildHookInterface[Any]):
    if sys.platform == "win32":
        source_dir = Path("install/bin")
    else:
        source_dir = Path("install/lib")

    target_dir = Path("vapoursynth/plugins")

    def initialize(self, version: str, build_data: dict[str, Any]) -> None:
        build_data["pure_python"] = False
        build_data["tag"] = f"py3-none-{next(tags.platform_tags())}"
        self.target_dir.mkdir(parents=True, exist_ok=True)
        for file_path in self.source_dir.glob("*"):
            if file_path.is_file() and file_path.suffix in [".dll", ".so", ".dylib"]:
                shutil.copy2(file_path, self.target_dir)
