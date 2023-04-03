# Sample run:
# awk -f download-speed.awk home-nk/build.log | sort > home-nk/download-speed.csv

function printDownload(file, size, sizeUnit, speed, speedUnit,    sz, sp) {
    sz = sizeUnit == "MB" ? 1000000*size : sizeUnit == "kB" ? 1000*size : size
    sp = speedUnit == "MB/s" ? 1000000*speed : speedUnit == "kB/s" ? 1000*speed : speed
    totalSize += sz
    speedSum += sp
    ++files
    printf "\"%s\";%d;%d\n", file, sz, sp
}

BEGIN {
    FS = "[ ()Z]+"
}

# gha-home
/Downloaded from local: https:\/\/7776-185-15-74-210\.eu\.ngrok\.io\/repository\/maven-public\// {
    match($0, /https:\/\/7776-185-15-74-210\.eu\.ngrok\.io\/repository\/maven-public\/(\S+)/, m)
    printDownload(m[1], $7, $8, $10, $11)
}

# gha-nk
/\[INFO\] Downloaded from nykredit: https:\/\/maven\.tools\.nykredit\.it\// {
    match($0, /https:\/\/maven\.tools\.nykredit\.it\/(\S+)/, m)
    printDownload(m[1], $7, $8, $10, $11)
}

# home-nk
/^Downloaded from nykredit: https:\/\/maven\.tools\.nykredit\.it\// {
    match($0, /https:\/\/maven\.tools\.nykredit\.it\/(\S+)/, m)
    printDownload(m[1], $5, $6, $8, $9)
}

END {
    print files " files downloaded, total size approximately " totalSize/1000000 " MB. Average speed: " speedSum/files " B/s" > "/dev/stderr"
}
