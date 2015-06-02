reset
set terminal pdf size 5,3 color
load 'gnuplot-styles.plt'
set output "../gplt-gflops-hpcg.pdf"
set title "GFLOPs HPCG" offset 0,-0.5, 0
set xlabel "Total number of cores" offset 0,0.75,0
set ylabel "HPCG Result [GFLOPs]"  offset 1.5,0,0
set grid
set logscale x 2

set xtics (1,2,4,8,16,32,64)
set xrange [1:64]
set yrange [0:40]
set key autotitle columnhead
set key inside left top


set datafile separator '\t'
f(x) = x*0.761287
plot '../../results/petsc/forplots/gflops_hpcg.txt'  using 1:2 w linespoints ls 11, \
f(x) ls 16 title 'A8 (ideal scaling)' , \
'' using 1:3 w linespoints ls 12, \
'' using 1:4 w linespoints ls 14

 

unset output
