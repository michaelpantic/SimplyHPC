reset
set terminal pdf size 8,3 color
load 'gnuplot-styles.plt'
set output "../gplt-hsr-weak-pipe.pdf"
set multiplot layout 1,2 title "Weak Scaling of Ansys CFX on On-Premises Cluster nodes"

set title "Runtime" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.5,0
set ylabel "Calculation time [s]" offset 0.5,0,0

set grid mxtics, xtics ls 21, ls 20
set grid mytics, ytics ls 21, ls 20
set xtics (1,6,12,24,48)
set ytics 10

set logscale y
set logscale x 6
set xrange [1:48]
set yrange [10:20000]
set key off
set format y "1E%T"
plot '../../results/ansys/pipe/HSR/weakscaling.dat'  using 1:2 w linespoints ls 11, \
'' using 1:5 w linespoints ls 12 , \
'' using 1:8 w linespoints ls 13, \
'' using 1:11 w linespoints  ls 14,\
'' using 1:14 w linespoints  ls 15

 

unset logscale y
set format y "%.1f"
set title "Efficiency" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.75,0
set ylabel "Efficiency" offset 0.5,0,0
set xtics (1,6,12,24,48)
set xrange [1:60]
set yrange [0:1.1]
set key title "Nodes per Processor"
set key autotitle columnhead
set ytics 0.1

set key outside left center

plot '../../results/ansys/pipe/HSR/weakscaling.dat'  using 1:4 w linespoints ls 11 title '3.72E+04', \
'' using 1:7 w linespoints ls 12 title '7.95E+04', \
'' using 1:10 w linespoints ls 13 title '1.68E+05', \
'' using 1:13 w linespoints ls 14 title '3.35E+05', \
'' using 1:16 w linespoints ls 15 title '6.65E+05',\
(1) w lines ls 1

 
unset multiplot
unset output
