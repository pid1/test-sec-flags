UNIXBENCH=./test-unixbench
FFMPEG=./test-ffmpeg
XZ=./test-xz

.PHONY: test-unixbench test-xz test-ffmpeg

all: test-unixbench test-xz test-ffmpeg

test-unixbench test-unixbench-1 test-unixbench-2 test-unixbench-3 test-unixbench-4 test-unixbench-5 test-unixbench-6 test-unixbench-7 test-unixbench-8:
	${UNIXBENCH} $(subst test-unixbench,,$(@:test-unixbench-%=%))

test-xz test-xz-1 test-xz-2 test-xz-3 test-xz-4 test-xz-5 test-xz-6 test-xz-7 test-xz-8:
	${XZ} $(subst test-xz,,$(@:test-xz-%=%))

test-ffmpeg test-ffmpeg-1 test-ffmpeg-2 test-ffmpeg-3 test-ffmpeg-4 test-ffmpeg-5 test-ffmpeg-6 test-ffmpeg-7 test-ffmpeg-8: setup
	${FFMPEG} $(subst test-ffmpeg,,$(@:test-ffmpeg-%=%))

setup: submodules
	mkdir -p .env/lib/hardening-wrapper
	make -C hardening-wrapper PREFIX=/ DESTDIR="$(shell pwd)/.env"
	sed -r 's|/etc/hardening-wrapper.conf|/dev/null|g' -i .env/lib/hardening-wrapper/bin/*

submodules:
	git submodule update --init --rebase
