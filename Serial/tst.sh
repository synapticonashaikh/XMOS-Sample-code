#!/usr/bin/env bash

fifo_name="myfifo"; #init a fifo
rm $fifo_name #(better to )remove and cearte a new one

#check if fifo not exist
[ -p $fifo_name ] || mkfifo $fifo_name; #create one
exec 3<> $fifo_name;

./a.out < <(
    while true; do #while loop
        sleep 0.01 #create a small delay to reduce load on processor
        if read line; then  #if there is data received from fifo
            if [[ "$line" =~ "upload" ]]; then
                  value=`cat pycode.py`  
                  echo "$value"  
            else
                 echo $line # send it to xe file
            fi
        fi  
    done <"$fifo_name"
)