from git import Repo
import re

class GitRepo:
    def __init__(self, projectDir):
        self.tag = ''
        self.count = ''
        self.hash = ''
        self.majorVersion = 0
        self.minorVersion = 0
        self.buildVersion = 0
        self.__readGitInfo(projectDir)

    def __readGitInfo(self, projectDir):
        repo = Repo(projectDir)
        
        self.tag = 0
        self.majorVersion = 0
        self.minorVersion = 0
        self.buildVersion = 9
        
        p = re.compile('V?(\d+)\.(\d+)\.(\d+)')
        tags = [s for s in repo.tags if p.match(s.tag.tag)]
        tags = sorted(tags, key=lambda t: t.commit.committed_datetime)
        
        if (len(tags) > 0):
            self.tag = tags[-1].tag.tag
            if (self.tag.startswith('V') == False):
                self.tag = 'V' + self.tag
            m = p.search(self.tag)
            self.majorVersion = m.group(1)
            self.minorVersion = m.group(2)
            if (len(self.minorVersion) < 2):
                self.minorVersion = '0' + self.minorVersion
            self.buildVersion = m.group(3)
            if (repo.active_branch.name == 'develop'):
                self.buildVersion = 9
            self.count = len(list(repo.iter_commits())) - len(list(repo.iter_commits(tags[-1].commit)))
        else:
            self.count = len(list(repo.iter_commits()))
        self.gitHash = 'g' + repo.git.rev_parse(repo.head.commit.hexsha, short=True)
