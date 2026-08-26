import json
from collections import defaultdict

def load(path):
    return json.load(open(path))

def summarize(records):
    result = defaultdict(list)
    for r in records:
        result[r["status"]].append(r["id"])
    return result
