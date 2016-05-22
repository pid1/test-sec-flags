#!/usr/bin/env python
import sys

from matplotlib.pyplot import bar, show, savefig, legend
import matplotlib.pyplot as pp

import numpy as np

COLCOUNT = 8
RESNO = 2

WIDTH = .25
COLORS = [ "b", "g", "r", "c", "m", "y", "k", "B" ]
PATTERNS = [ "", "/" , "\\" , "|" , "-" , "x" , "+", "o", "O", ".", "*" ]
TICKS = [
        "1. stack-protector, partial relro",
        "2. + stack-check",
        "3. + PIE",
        "4. + PIE, -fstack-check",
        "5. full relro, PIE",
        "6. + -fstack-check",
        "7. + -fno-plt",
        "8. + PIE, -fno-plt",
        ]


def main(filename = 'res.txt'):

    experiments = []
    benchmark_numbers = []

    
    with open(filename) as fp:
        for line in fp:

            try:
                (number, res1, res2) = line.strip().split(":")
                number = int(number)
                benchmark_numbers.append(number)
                this_benchmark = [float(res1), float(res2)]
                i = number - 1
                experiments.append(max(this_benchmark))

                ind = [number - WIDTH + WIDTH*x for x in range(0, 2)]
                pl = bar(ind, this_benchmark, width = WIDTH, color=COLORS[i],
                         hatch=PATTERNS[i], label = TICKS[i])

            except Exception as e:
                print(e)
                import pdb; pdb.set_trace()


    pp.xlabel("Benchmark", fontsize=50)
    pp.ylabel("Benchmark Score", fontsize=50)

    fig = pp.figure(1)
    sp = fig.add_subplot(111)


    maximum_score = max(this_benchmark) + .5 * max(this_benchmark)
    
    minimum_score = 0
    sp.set_ylim(ymin=minimum_score, ymax=maximum_score)
    sp.set_xlim(xmin=0, xmax=max(benchmark_numbers) + 1)

    for tick in sp.xaxis.get_major_ticks():
        tick.label.set_fontsize(25)

    for tick in sp.yaxis.get_major_ticks():
        tick.label.set_fontsize(25)


    legend(loc='upper left', ncol=3, prop={'size':25})

    show()


if __name__ == '__main__':

    if len(sys.argv) > 1:
        main(sys.argv[1])
    else:
        main()


