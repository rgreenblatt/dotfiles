import subprocess
import os

from ranger.container.file import File
from ranger.api.commands import Command


class fzf_search(Command):
    def execute(self):
        if self.arg(1):
            args = self.rest(1)
        else:
            args = ''
        if self.quantifier:
            # match only directories
            command = os.environ["FZF_DIR_COMMAND"] + " " + args + " | fzf +m"
        else:
            # match files and directories
            command = os.environ[
                "FZF_DEFAULT_COMMAND"] + " " + args + " | fzf +m"
        fzf = self.fm.execute_command(command,
                                      universal_newlines=True,
                                      stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class fzf_rg_general(Command):
    @staticmethod
    def searcher():
        raise NotImplementedError()

    def execute(self):
        if self.arg(1):
            search_string = self.rest(1)
        else:
            self.fm.notify("Usage: %s <search string>" % self.get_name(),
                           bad=True)
            return

        command = (self.searcher() + " '%s' " % search_string +
                   " | fzf +m | awk -F':' '{print $1}'")
        fzf = self.fm.execute_command(command,
                                      universal_newlines=True,
                                      stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            self.fm.execute_file(File(fzf_file))


class fzf_rga(fzf_rg_general):
    @staticmethod
    def searcher():
        return "rga"


class fzf_rg(fzf_rg_general):
    @staticmethod
    def searcher():
        return "rg"
