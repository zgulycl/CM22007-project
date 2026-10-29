.PHONY: req run kill wipe

req:
	@bash tools/req.sh

run:
	@bash tools/run.sh

kill:
	@bash tools/kill.sh

wipe:
	@bash tools/wipe.sh
