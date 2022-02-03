import argparse
import os
import tempfile
import shutil
from DirUtils import ZipDirectory

def updateLink(dir, file, version):
    with open(os.path.join(dir, file), "r+") as f:
        new_f = f.readlines()
        f.seek(0)
        for line in new_f:
            if (line.find(rf'C:\BrAutomation\AS410\AS\TechnologySolutions\mapp Framework\V') != -1):
                line = rf'<Object Type="File" Reference="true">C:\BrAutomation\AS410\AS\TechnologySolutions\mapp Framework\{version}\Importer\FrameworkImporter.exe</Object>'
            f.write(line)
        f.truncate()

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--project', help='Project Directory', dest='project', required=True)
    parser.add_argument('-v', '--version', help='Project Version', dest='version', required=False, default="V0.0.9.000")
    
    args = parser.parse_args()

    updateLink(rf'{args.project}\Logical\mappFrameworkImporter\\', 'Package.pkg', args.version)
    tempDir = tempfile.TemporaryDirectory()
    ts = rf'{tempDir.name}\FrameworkImporter_TS'
    shutil.copytree(rf'{args.project}', ts)
    ZipDirectory(ts, rf'{args.project}.zip')

if __name__ == '__main__':
    main()