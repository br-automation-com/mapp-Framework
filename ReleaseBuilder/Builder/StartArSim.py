import os
import argparse
import sys
import time
import socket
from subprocess import Popen

def launchArSim(simulationDir) -> socket:
    print('starting ArSim')
    Popen(f'"{simulationDir}\\ar000loader.exe" -i127.0.0.1 -p4003', shell=False)

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    connected = False
    while not connected:
        try:
            s.connect(('127.0.0.1',4003))
            connected = True
        except Exception as e:
            print (e)
            pass #Do nothing, just try again
    print('Connected to ArSim')
    s.settimeout(2)
    return s

def waitForRunMode(s) -> bool:
    maxRetries = 400
    while True:
        maxRetries -= 1
        if (maxRetries <= 0):
            print('ArSim did not start')
            return False
        #print('Checking for ArSim Run mode')
        try:
            s.send(b'<Status Command="10"/>')
            data = s.recv(1024)
            #print(data)
            if data == b'<AR status RUN Command="99"/>\x00':
                s.close()
                print('ArSim started')
                return True
            time.sleep(0.5)
        except Exception as e:
            print(e)
            pass

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--simulationDirectory', help='ArSim installation directory', dest='simulationDir', required=True)
    args = parser.parse_args()

    s = launchArSim(args.simulationDir)
    returnVal = waitForRunMode(s)
    time.sleep(2)
    sys.exit(0 if (returnVal == True) else 1)
    return

if __name__ == '__main__':
    main()