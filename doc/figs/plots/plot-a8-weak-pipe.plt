reset
set terminal pdf size 5,3 color
set output "../gplt-a8-weak-pipe.pdf"
set title "Weak Scaling on Azure A8 nodes" offset 0,-0.5, 0
set xlabel "Total number of cores (|Nodes|*8)" offset 0,0.75,0
set ylabel "Calculation time [s]" offset 1.5,0,0
set grid
set logscale x 2
set style line 11 lw 2 lc rgb '#0072bd' # blue
set style line 12 lw 2 lc rgb '#d95319' # orange
set style line 13 lw 2 lc rgb '#edb120' # yellow
set style line 14 lw 2 lc rgb '#7e2f8e' # purple
set style line 15 lw 2 lc rgb '#77ac30' # green
set style line 16 lw 2 lc rgb '#4dbeee' # light-blue
set style line 17 lw 2 lc rgb '#a2142f' # red
set xtics (8,16,32,64)
set xrange [8:64]
set yrange [0:3000]
set key autotitle columnhead
set key inside right top
set datafile separator '\t'
plot 'a8-weak-pipe.dat'  using 1:2 w linespoints ls 11, \
'' using 1:3 w linespoints ls 12

unset output
