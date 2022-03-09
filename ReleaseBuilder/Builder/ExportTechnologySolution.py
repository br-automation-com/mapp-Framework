import argparse
import os
import tempfile
import shutil
from DirUtils import ZipDirectory

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-v', '--version', help='Project Version', dest='version', required=False, default="V0.0.9.000")
    
    args = parser.parse_args()

    tempDir = tempfile.TemporaryDirectory()
    ts = rf'{tempDir.name}\FrameworkImporter_TS'
    shutil.copytree(rf'{args.project}', ts)
    ZipDirectory(ts, rf'{args.project}.zip')

if __name__ == '__main__':
    main()