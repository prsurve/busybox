#!/bin/sh
run_io()
{

    df -h /mnt/test | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
    do
    echo $output
    usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
    partition=$(echo $output | awk '{ print $2 }' )
    if [ $usep -ge 90 ]; then
        echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)"
        echo "Alert: Almost out of disk space $usep%"
        sleep 30
        break
    else
        echo "Running io space is sufficent"
        hostname=$(hostname -f)
        file=$(date +"%d-%m-%Y_%H-%M-%S"-$hostname)
        dd if=/dev/urandom of=/mnt/test/$file bs=20M count=1
        sync
        md5sum_data=$(md5sum /mnt/test/$file | awk '{print$1}')
        python3 /write_metadata.py --metadata_file_name metadata.json --key $file --value $md5sum_data
        
    fi
    done
}

while true; do
    date -u
    echo "Starting next iteration"
    echo
    run_io

    # Do the above every 5 minutes 
    sleep 300
done
