UNIXBENCH=./unixbench-tests.sh
FFMPEG=./ffmpeg-tests.sh
XZ=./xz-tests.sh

.PHONY: unixbench xz ffmpeg

all: unixbench xz ffmpeg

unixbench unixbench-1 unixbench-2 unixbench-3 unixbench-4 unixbench-5 unixbench-6 unixbench-7 unixbench-8:
	${UNIXBENCH} $(@:unixbench-%=%)

xz xz-1 xz-2 xz-3 xz-4 xz-5 xz-6 xz-7 xz-8:
	${XZ} $(@:xz-%=%)

ffmpeg ffmpeg-1 ffmpeg-2 ffmpeg-3 ffmpeg-4 ffmpeg-5 ffmpeg-6 ffmpeg-7 ffmpeg-8:
	${FFMPEG} $(@:ffmpeg-%=%)
