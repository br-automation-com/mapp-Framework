import os
import tempfile
import shutil

def removeDir(directory):
    try:
        if (os.path.exists(directory)):
            tempDirName = tempfile.TemporaryDirectory().name
            os.rename(directory, tempDirName)
            shutil.rmtree(tempDirName)
    except:
        return

def CleanDirectory(directory):
    CreateDirectory(directory)
    contents = [os.path.join(directory, i) for i in os.listdir(directory)]
    [os.remove(i) if os.path.isfile(i) or os.path.islink(i) else shutil.rmtree(i) for i in contents]

def CreateDirectory(directory):
    if (os.path.exists(directory) == False):
        os.mkdir(directory)