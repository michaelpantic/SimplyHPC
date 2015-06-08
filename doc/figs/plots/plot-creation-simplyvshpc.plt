reset
set terminal pdf size 5,3 color
load 'gnuplot-styles.plt'
set output "../gplt-creation-simplyvshpc.pdf"
set title "Set-up time Cloud Cluster w A8 nodes"
set xlabel "Number of A8 nodes"
set ylabel "Time [hh:mm:ss]"
set grid y
set style data histograms


set boxwidth 0.5
set style fill solid 1.0  border -1
set key inside left top
 set key width -5	
  set ydata time
set xtics add ("" -1)
set xtics add ("8" 0)
set xtics add ("16" 1)
set xtics add ("32" 2)
set xtics add ("" 3)
set xtics add ("8" 4)
set xtics add ("16" 5)
set xtics add ("32" 6)
set xtics add ("" 7)

set timefmt "%H:%M:s"
set yrange ["0:00:00":"3:00:00"]
#color rgb '#0072bd'
set key autotitle columnhead 

set style histogram rowstacked
set datafile separator '\t'
plot \
newhistogram "SimplyHPC",\
"../../results/petsc/forplots/create_simplyhpc.txt" using 2:xtic(1) ls 11,\
"" using 3:xtic(1) ls 12 ,\
newhistogram "HPCPack",\
"../../results/petsc/forplots/create_hpcpack.txt" using 2:xtic(1) ls 13 ,\
""  using 3:xtic(1) ls 14,\
"" using 4:xtic(1) ls 15



unset output
