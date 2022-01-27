import os
import shutil
import sys
import argparse

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--simulationDirectory', help='ArSim installation directory', dest='simulationDir', required=True)
    args = parser.parse_args()

    cmd_result = os.system('"' + args.simulationDir + '\\ar000stop.exe"')
    print('ArSim stopped')
    print(cmd_result)
    sys.exit(cmd_result)
    return

if __name__ == '__main__':
    main()