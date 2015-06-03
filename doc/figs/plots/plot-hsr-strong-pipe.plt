reset
set terminal pdf size 8,3 color
load 'gnuplot-styles.plt'
set output "../gplt-hsr-strong-pipe.pdf"
set multiplot layout 1,2 title "Strong Scaling of Ansys CFX on On-Premises Cluster nodes"

set title "Runtime" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.75,0
set ylabel "Calculation time [s]" offset 0.5,0,0
set logscale y
set xtics (1,8,16,24,32,40,48,56,64)
set xrange [1:64]
set yrange [10:120000]
set format y "1E%T"
set key autotitle columnhead
set key off

plot '../../results/ansys/pipe/HSR/results.dat'  using 1:2 w linespoints ls 11 title 'pipe01', \
'' using 1:9 w linespoints ls 12 title 'pipe02', \
'' using 1:16 w linespoints ls 13 title 'pipe06', \
'' using 1:23 w linespoints ls 14 title 'pipe04', \
'' using 1:30 w linespoints ls 15 title 'pipe05', \
'' using 1:37 w linespoints ls 16 title 'pipe07', \
'' using 1:44 w linespoints ls 17 title 'pipe08' 
 

#unset output



#reset
#set terminal pdf size 5,3 color
#load 'gnuplot-styles.plt'
#set output "../gplt-a8-strong-pipe-efficiency.pdf"
unset logscale y
set format y "%.1f"
set title "Efficiency" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.75,0
set ylabel "Efficiency" offset 0.5,0,0
set xtics (1,8,16,24,32,40,48,56,64)
set xrange [1:64]
set yrange [0:1.1]
set key autotitle columnhead


set key outside left center

plot '../../results/ansys/pipe/HSR/results.dat'  using 1:6 w linespoints ls 11 title 'pipe01', \
'' using 1:13 w linespoints ls 12 title 'pipe02', \
'' using 1:20 w linespoints ls 13 title 'pipe06', \
'' using 1:27 w linespoints ls 14 title 'pipe04', \
'' using 1:34 w linespoints ls 15 title 'pipe05', \
'' using 1:41 w linespoints ls 16 title 'pipe07', \
'' using 1:48 w linespoints ls 17 title 'pipe08', \
(1) w lines 

 
unset multiplot
unset output
