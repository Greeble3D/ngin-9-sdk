#!/usr/bin/env python3

import os

ASSET_CATEGORY = "physics_objects"


def filename_to_title(name: str) -> str:
    name = name.replace("_", " ").replace("-", " ").strip()
    parts = [p for p in name.split() if p]
    return " ".join(p.capitalize() for p in parts)


def title_to_key(title: str) -> str:
    return title.replace(" ", "-")


def process_directory(root: str):
    for dirpath, _, filenames in os.walk(root):
        for file in filenames:
            if file.lower().endswith(".tscn"):
                base = os.path.splitext(file)[0]

                name = filename_to_title(base)
                key = title_to_key(name).lower()

                cfg_path = os.path.join(dirpath, base + ".cfg")

                content = (
                    "[asset]\n"
                    f'name = "{name}"\n'
                    f'key = "{key}"\n'
                    f'asset_category = "{ASSET_CATEGORY}"\n'
                )

                with open(cfg_path, "w", encoding="utf-8") as f:
                    f.write(content)

                print(f"Created: {cfg_path}")


if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.abspath(__file__))
    process_directory(script_dir)
