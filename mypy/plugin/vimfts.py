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
dict_fn_prj     = {}

#===============================================================================
# Functions
#===============================================================================
def ParseWorkspace(fn = None, ppath = None):
    if fn is None:
        fn = vim.current.buffer.name
    if fn is None:
        print "vimfts: File name is empty!"
        return
    fn = fn.lower()
    if fn in dict_fn_prj:
        return

    if ppath is None:
        ppath = fn
    if ppath is None:
        print "vimfts: Project path is not found!"
        return
    ppath = ppath.lower()

    m = re.search(r'[c-z]:\\projects\\(?P<ws>\w+)\\(?P<prj>\w+)', ppath)
    if m is None:
        print "vimfts: Workspace and/or Project folder not found!"
        print ppath
        return

    prj = m.group('ws') + '|' + m.group('prj')
    dict_fn_prj[fn] = prj
    return
