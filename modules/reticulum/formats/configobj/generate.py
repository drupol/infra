import json
import sys

from configobj import ConfigObj


values_path = sys.argv[1]

with open(values_path, "r", encoding="utf-8") as f:
    config = ConfigObj(interpolation=False, encoding="UTF8")

    config.update(json.load(f))

    config.write(sys.stdout.buffer)
