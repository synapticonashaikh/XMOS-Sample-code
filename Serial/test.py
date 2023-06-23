import subprocess
from time import sleep

#process = subprocess.Popen("./run.sh", stdin=subprocess.PIPE, stdout=subprocess.PIPE)
process =  subprocess.call(['sh', './run.sh'])

while True:

    input_data = "# check $\n"
    process.stdin.write(input_data.encode())
    process.stdin.flush()

    output = process.stdout.readline().decode().strip()
    print(output)

process.stdin.close()
process.stdout.close()