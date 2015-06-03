reset
set terminal pdf size 5,3 color
load 'gnuplot-styles.plt'
set output "../gplt-creation-simplyvshpc.pdf"
set title "Set-up time Azure Cluster w A4 nodes"
set xlabel "Number of A4 nodes"
set ylabel "Time [hh:mm:ss]"
set grid y
set style data histograms


set boxwidth 0.5
set style fill solid 1.0  border -1
set key inside left top
 set key width -5	
  set ydata time

set timefmt "%H:%M:s"
set yrange ["0:00:00":"1:10:00"]
#color rgb '#0072bd'
set key autotitle columnhead 

set style histogram rowstacked
set datafile separator '\t'
plot \
newhistogram "SimplyHPC",\
"../../results/petsc/forplots/create_simplyhpc.txt" using 2:xtic(1) ls 11,\
newhistogram "HPCPack",\
"../../results/petsc/forplots/create_hpcpack.txt" using 8:xticlabel(1) ls 12 title "Create Net/Storage/Service" ,\
""  using 5:xtic(1) ls 15,\
"" using 6:xtic(1) ls 16,\
"" using 7:xtic(1) ls 13


unset output
