#===============================================================================
# Imports
#===============================================================================
import re
import vim
#===============================================================================
# Globals
#===============================================================================
# Dictionary of project to build configurations
dict_prj_cfg    = {}

#===============================================================================
# Functions
#===============================================================================
def ParseWorkspace(ppath = None):
    if ppath is None:
        print "vimfts: Project path is not found!"
        return

    ppath = ppath.lower()
    m = re.search(r'[c-z]:\\projects\\(?P<ws>\w+)\\(?P<prj>\w+)', ppath)
    if m is None:
        print "vimfts: Workspace and/or Project folder not found!"
        return

    prj = m.group('ws') + '|' + m.group('prj')

    # If this is new project, add to dictionary; only populate build command
    # when build command is run
    if prj not in dict_prj_cfg:
        dict_prj_cfg[prj] = []

    return
