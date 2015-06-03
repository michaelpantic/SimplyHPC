reset
set terminal pdf size 5,3 color
load 'gnuplot-styles.plt'
set output "../gplt-a8-weak-pipe.pdf"
set title "Weak Scaling Azure A8 nodes" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.5,0
set ylabel "Calculation time [s]" offset 0.5,0,0

set grid mxtics, xtics ls 21, ls 20
set grid mytics, ytics ls 21, ls 20
set xtics 2
set ytics 10


set logscale y
set logscale x
set xrange [8:512]
set yrange [10:10000]
set key title "Nodes per Processor"
set key autotitle columnhead
set key inside right bottom
 set key enhanced opaque
set format y "1E%T"
plot '../../results/ansys/pipe/A8/weakscaling.dat'  using 1:2 w linespoints ls 22, \
'' using 1:3 w linespoints ls 23, \
'' using 1:4 w linespoints ls 24, \
'' using 1:5 w linespoints  ls 25


 

unset output
