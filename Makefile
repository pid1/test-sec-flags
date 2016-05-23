UNIXBENCH=./unixbench-tests.sh
FFMPEG=./ffmpeg-tests.sh
XZ=./xz-tests.sh

.PHONY: unixbench xz ffmpeg

all: unixbench xz ffmpeg

unixbench:
	${UNIXBENCH}

unixbench-1:
	${UNIXBENCH} 1

unixbench-2:
	${UNIXBENCH} 2

unixbench-3:
	${UNIXBENCH} 3

unixbench-4:
	${UNIXBENCH} 4

unixbench-5:
	${UNIXBENCH} 5

unixbench-6:
	${UNIXBENCH} 6

unixbench-7:
	${UNIXBENCH} 7

unixbench-8:
	${UNIXBENCH} 8

xz:
	${XZ}

xz-1:
	${XZ} 1

xz-2:
	${XZ} 2

xz-3:
	${XZ} 3

xz-4:
	${XZ} 4

xz-5:
	${XZ} 5

xz-6:
	${XZ} 6

xz-7:
	${XZ} 7

xz-8:
	${XZ} 8

ffmpeg:
	${FFMPEG}

ffmpeg-1:
	${FFMPEG} 1

ffmpeg-2:
	${FFMPEG} 2

ffmpeg-3:
	${FFMPEG} 3

ffmpeg-4:
	${FFMPEG} 4

ffmpeg-5:
	${FFMPEG} 5

ffmpeg-6:
	${FFMPEG} 6

ffmpeg-7:
	${FFMPEG} 7

ffmpeg-8:
	${FFMPEG} 8
