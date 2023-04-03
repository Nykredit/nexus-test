set term png size 1024,768
set output "speed-vs-size.png"

set title "Download speed"
set xlabel "Size (Bytes)"
set ylabel "Speed (B/s)"

plot "gha-nk/speed.dat" using 2:3
