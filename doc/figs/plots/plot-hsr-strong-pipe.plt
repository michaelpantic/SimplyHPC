reset
set terminal pdf size 5,3 color
set output "../gplt-hsr-strong-pipe.pdf"
set title "Strong Scaling on HSR cluster nodes" offset 0,-0.5, 0
set xlabel "Total number of cores (|Nodes|*6)" offset 0,0.75,0
set ylabel "Calculation time [s]" offset 1.5,0,0
set grid

set style line 11 lw 2 lc rgb '#0072bd' # blue
set style line 12 lw 2 lc rgb '#d95319' # orange
set style line 13 lw 2 lc rgb '#edb120' # yellow
set style line 14 lw 2 lc rgb '#7e2f8e' # purple
set style line 15 lw 2 lc rgb '#77ac30' # green
set style line 16 lw 2 lc rgb '#4dbeee' # light-blue
set style line 17 lw 2 lc rgb '#a2142f' # red
set xtics (6,12,24,36,48,60)
set xrange [6:60]
set yrange [0:10000]
set key autotitle columnhead
set key inside right top
set datafile separator '\t'
plot 'hsr-strong-pipe.dat'  using 1:2 w linespoints ls 11, \
'' using 1:3 w linespoints ls 12, \
'' using 1:4 w linespoints ls 13, \
'' using 1:5 w linespoints ls 14, \
'' using 1:6 w linespoints ls 15
 

unset output
