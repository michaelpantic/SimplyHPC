reset
set terminal pdf size 4,3	 color
load 'gnuplot-styles.plt'
set output "../gplt-gflops-ruep.pdf"
set title "GFLOPs PETSc Solver Matrix 'ruep'"  offset 0, -0.5, 0
set xlabel "Total number of cores" offset 0,0.75,0
set ylabel "Throughput PETSc solver [GFLOPs]" offset 1.5,0,0
set grid
set logscale x 2

set xtics (1,2,4,8,16,32,64)
set xrange [1:64]
set yrange [0:40]
set key autotitle columnhead
set key inside left top


set datafile separator '\t'
f(x) = x*1.036
plot '../../results/petsc/forplots/gflops_ruep.txt'  using 1:2 w linespoints ls 11, \
f(x) ls 16 title 'A8 (ideal scaling)' , \
'' using 1:4 w linespoints ls 13, \
'' using 1:5 w linespoints ls 14

 

unset output
