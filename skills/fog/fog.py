#!/usr/bin/env python3
"""Build and read fog.html. The page carries its own state, so it is also /fog's memory.

  fog.py render <state.json> <fog.html>   fill template.html with the state, write the page
  fog.py extract <fog.html>               print the state stored in an existing page (or {} if none)
"""
import json
import sys
from pathlib import Path

TEMPLATE = Path(__file__).with_name("template.html")
START = '<script type="application/json" id="fog-state">'
END = "</script>"


def split(page):
    i = page.index(START) + len(START)
    return page[:i], page[i:page.index(END, i)], page[page.index(END, i):]


def render(state_path, out_path):
    state = json.loads(Path(state_path).read_text(encoding="utf-8"))
    # "</" would end the <script> block early; JSON allows the escaped form.
    data = json.dumps(state, ensure_ascii=False, indent=1).replace("</", "<\\/")
    head, _, tail = split(TEMPLATE.read_text(encoding="utf-8"))
    title = state.get("project", "Fog").strip() or "Fog"
    head = head.replace("<title>Fog map</title>", f"<title>{title} fog map</title>", 1)
    Path(out_path).write_text(head + "\n" + data + "\n" + tail, encoding="utf-8")
    print(f"Wrote {out_path}")


def extract(page_path):
    p = Path(page_path)
    if not p.exists():
        print("{}")
        return
    try:
        print(split(p.read_text(encoding="utf-8"))[1].strip() or "{}")
    except ValueError:
        print("{}")


if __name__ == "__main__":
    if len(sys.argv) == 4 and sys.argv[1] == "render":
        render(sys.argv[2], sys.argv[3])
    elif len(sys.argv) == 3 and sys.argv[1] == "extract":
        extract(sys.argv[2])
    else:
        sys.exit(__doc__)
