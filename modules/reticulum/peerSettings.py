
import json
import msgpack
import sys


DEFAULTS = {
	"served_file_requests": 0,
	"served_page_requests": 0,
	"last_announce": 0.0,
	"last_lxmf_sync": 0.0,
	"node_last_announce": 0.0,
}

raw = json.load(sys.stdin)
payload = dict(DEFAULTS)
payload.update(raw)

payload["propagation_node"] = bytes.fromhex(raw["propagation_node"])

sys.stdout.buffer.write(msgpack.packb(payload, use_bin_type=True))
