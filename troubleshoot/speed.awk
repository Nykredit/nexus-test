# Sample run:
# awk -f speed.awk gha-nk/build.log > gha-nk/speed.dat

BEGIN {
    FS = "[ ()Z]+"
}

/Downloaded/ {
    size = $8 == "MB" ? 1000000*$7 : $8 == "kB" ? 1000*$7 : $7
    totalSize += size
    speed = $11 == "MB/s" ? 1000000*$10 : $11 == "kB/s" ? 1000*$10 : $10
    speedSum += speed
    ++files
    print $1, size, speed
}

END {
    print files " files downloaded, total size approximately " totalSize/1000000 " MB. Average speed: " speedSum/files " B/s" > "/dev/stderr"
}
