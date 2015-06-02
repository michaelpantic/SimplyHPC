reset
set terminal pdf size 5,3 color
load 'gnuplot-styles.plt'
set output "../gplt-cost.pdf"
set title "Cost of 1 Hour of 1 GFLOPs HPCG Throughput" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.75,0
set ylabel "Cost per GFLOPs [$]" offset 1.5,0,0
set grid
set logscale x 2
set xtics (1,2,4,8,16,32,64)
set xrange [1:64]
set yrange [0:14]
set key autotitle columnhead
set key inside left top


set datafile separator '\t'
plot '../../results/petsc/forplots/dollar_gflop.txt'  using 1:6 w linespoints ls 11, \
'' using 1:5 w linespoints ls 12, \
'' using 1:4 w linespoints ls 13, \
'' using 1:3 w linespoints ls 14, \
'' using 1:2 w linespoints ls 15, \

 

unset output
