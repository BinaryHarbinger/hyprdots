#!/bin/python
import argparse
import re
from pathlib import Path

SCSS_VAR_REGEX = re.compile(
    r'^\s*\$(?P<name>[a-zA-Z0-9_-]+)\s*:\s*(?P<value>.+?)\s*;'
)

REF_REGEX = re.compile(r'^\$(?P<name>[a-zA-Z0-9_-]+)$')

def scss_name_to_python(name: str) -> str:
    return name.replace("-", "_").lower()

def parse_scss_variables(text: str) -> dict:
    raw = {}

    for line in text.splitlines():
        match = SCSS_VAR_REGEX.match(line)
        if not match:
            continue

        py_name = scss_name_to_python(match.group("name"))
        value = match.group("value").strip()

        raw[py_name] = value

    return raw

def resolve_variables(raw: dict) -> dict:
    resolved = {}
    resolving = set()

    def resolve(name: str):
        if name in resolved:
            return resolved[name]

        if name in resolving:
            raise RuntimeError(f"Circular SCSS variable reference involving {name}")

        resolving.add(name)
        value = raw[name]

        # Pure reference: $other_var
        ref_match = REF_REGEX.match(value)
        if ref_match:
            target = scss_name_to_python(ref_match.group("name"))
            if target not in raw:
                raise KeyError(f"Unknown SCSS variable ${ref_match.group('name')}")
            resolved[name] = target
        else:
            # Literal value
            resolved[name] = f'"{value}"'

        resolving.remove(name)
        return resolved[name]

    for key in raw:
        resolve(key)

    return resolved

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("scss", type=Path, help="Path to theme.scss")
    parser.add_argument("py", type=Path, help="Path to theme.py")
    args = parser.parse_args()

    scss_text = args.scss.read_text(encoding="utf-8")

    raw = parse_scss_variables(scss_text)
    resolved = resolve_variables(raw)

    args.py.parent.mkdir(parents=True, exist_ok=True)

    with args.py.open("w", encoding="utf-8") as f:
        f.write("# Auto-generated from SCSS. Do not edit manually.\n\n")
        for name, value in resolved.items():
            f.write(f"{name} = {value}\n")

if __name__ == "__main__":
    main()
