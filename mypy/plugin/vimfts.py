#===============================================================================
# Imports
#===============================================================================
import os.path
import re
import vim
import xml.etree.ElementTree
#===============================================================================
# Globals
#===============================================================================
# Dictionary of project to build configurations
dict_prj_cfg    = {}
str_cprj        = '.cproject'

#===============================================================================
# Functions
#===============================================================================
def GetCdtBuildConfig(prjpath, vvar_wsprj_cfg = "tmp_wsprj_cfg"):
    """Locate and parse FTS project file (CDT .cproject) and parse for
    build configuratoins

    :prjpath: Path to folder containing CDT .cproject file
    :vdict_wsprj_cfg: String specifying vim dict variable

    """
    if prjpath is None:
        print '[vimfts] GetCdtBuildConfig: Invalid project path!'
        return

    # Form .cproject file path
    if prjpath.endswith(str_cprj):
        prjpath = prjpath[:-len(str_cprj)]
    prjpath = os.path.join(prjpath, str_cprj)
    if not os.path.isfile(prjpath):
        print '[vimfts] GetCdtBuildConfig: Cannot find .cproject file in:'
        print '\t' + prjpath
        return

    cfg_xpath = ".//configuration[@artifactExtension='axf']"
    root = xml.etree.ElementTree.parse(prjpath).getroot()
    cfg_lst = []
    for e in root.findall(cfg_xpath):
        if 'name' in e.attrib:
            cfg_lst.append(e.attrib['name'])
    # Return the list of configurations as a comma separated string
    vim.command('let ' + vvar_wsprj_cfg + '="' + ','.join(cfg_lst) + '"')
