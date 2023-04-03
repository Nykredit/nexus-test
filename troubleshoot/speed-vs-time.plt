set term png size 1024,768
set output "speed-vs-time.png"

stats "gha-nk/speed.dat" using 1:3 nooutput 

set timefmt "%Y-%m-%dT%H:%M:%S"
set xdata time
set title "Download speed"
set xlabel "Time"
set ylabel "Speed B/s"

plot "gha-nk/speed.dat" using 1:3 w lp lt 1 t 'Speed', \
    '' u 1:(STATS_mean_y) w l lt 2 lw 2 t 'Avg speed'
