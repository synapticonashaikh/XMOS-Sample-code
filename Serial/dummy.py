import subprocess
from time import sleep
import os


process = subprocess.Popen("./run.sh", stdin=subprocess.PIPE, stdout=subprocess.PIPE)

sleep (4)
fifo_file = "myfifo"
fifo = open(fifo_file, 'w')
while True:      
    fifo.write("# check $\n")
    sleep(.1)
    fifo.flush()
     