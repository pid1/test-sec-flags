Results
=======

Getting useful results output from:

xz
--

``grep real xz-test* | awk '{print $2}' | awk '!(NR%2){printf(NR/2)":"p":";print$0"  "}{p=$0}'``

ffmpeg
------

``grep utime ffmpeg-test*``

unixbench
---------

``grep "Index Score" unixbench-test* | awk '{print $5}' | awk '!(NR%2){printf(NR/2)":"p":";print$0"  "}{p=$0}'``
