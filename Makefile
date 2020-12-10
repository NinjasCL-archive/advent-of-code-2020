WREN_VERSION = 0.3.0

.PHONY: example wren-macos wren-linux

wm wren-macos:
	@wget https://github.com/wren-lang/wren-cli/releases/download/${WREN_VERSION}/wren_cli-mac-${WREN_VERSION}.zip
	@unzip -o wren_cli-mac-${WREN_VERSION}.zip
	@rm -f wren_cli-mac-${WREN_VERSION}.zip
	@rm -f readme.md
	@mv wren_cli wren
	@ls

wl wren-linux:
	@wget https://github.com/wren-lang/wren-cli/releases/download/${WREN_VERSION}/wren_cli-linux-${WREN_VERSION}.zip
	@unzip -o wren_cli-linux-${WREN_VERSION}.zip
	@rm -f wren_cli-linux-${WREN_VERSION}.zip
	@rm -f wren_cli-linux-${WREN_VERSION}/readme.md
	@mv wren_cli-linux-${WREN_VERSION}/wren_cli wren
	@rm -rf wren_cli-linux-${WREN_VERSION}
	@ls

d1p1 day1p1:
	./wren day/1/part1.wren

d1p2 day1p2:
	./wren day/1/part2.wren

d2p1 day2p1:
	./wren day/2/part1.wren

d2p2 day2p2:
	./wren day/2/part2.wren

d3p1 day3p1:
	./wren day/3/part1.wren

d3p2 day3p2:
	./wren day/3/part2.wren

d4p1 day4p1:
	./wren day/4/part1.wren

d4p2 day4p2:
	./wren day/4/part2.wren
