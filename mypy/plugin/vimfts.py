#===============================================================================
# Imports
#===============================================================================
import os
import re
import subprocess
import vim
import xml.etree.ElementTree
#===============================================================================
# Globals
#===============================================================================
# Dictionary of project to build configurations
dict_prj_cfg    = {}
str_cprj        = '.cproject'

# DS-5 v5.21.1 specific path
ds5build        = r'C:\Program Files\DS-5 v5.21.1\bin\eclipsec.exe'
bcmd            = ' '.join(
    [
        ds5build,
        r'-nosplash',
        r'-application org.eclipse.cdt.managedbuilder.core.headlessbuild',
    ]
)
bcmd_ws_para    = r'-data'
bcmd_prj_para   = r'-cleanBuild'

# GC repo workspace path
re_gcrepo       = re.compile(r'\\projects\\FTS_GC\\\w+', re.IGNORECASE)
re_gcrepo_core  = re.compile(r'\\projects\\FTS_GC\\Core', re.IGNORECASE)
lst_gcrepo_lib_prj = [
     r'C:\Projects\FTS_GC\Core_Lib_Nos',
     r'C:\Projects\FTS_GC\Core_Lib_Device',
     r'C:\Projects\FTS_GC\Core_Lib_CoreIp']

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


def RunBuildCmd(wspath, prj, bc):
    """Run build command, redirect and filter command output to stdout

    :ws: Path to CDT workspace
    :prj: Name of project to be built
    :bc: Build configuration
    :returns: None

    """
    # TODO: Continue coding from here
    pass


def ListAllFtsSrcFiles(dr):
    '''List absolute path of all FTS source files (.c, .h, .s)
    
    :dr: input directory
    :returns: list of absolute file paths
    '''
    lst = []
    for root, dirs, files in os.walk(dr):
        for f in files:
            if f.endswith('.c') or f.endswith('.h') or f.endswith('.s'):
                p = os.path.abspath(os.path.join(root, f))
                lst.append(p)

    return lst


def GenerateFtsSrcFileList(dr, force = False):
    """Generate cscope file list 'cscope.files' in specified folder

    :dr: input directory
    :force: re-generate file list, overwrite exist list file if any
    :returns: None

    """
    if force is not True:
        if os.path.isfile(os.path.join(dr, 'cscope.files')):
            return

    lst = ListAllFtsSrcFiles(dr)

    # Check for GC repo and add library project files
    if re_gcrepo.search(dr) is not None and re_gcrepo_core.search(dr) is None:
        for libprj in lst_gcrepo_lib_prj:
            lst += ListAllFtsSrcFiles(libprj)

    if lst is not None and len(lst) > 0:
        # Output to cscope.files in directory
        flist = open(os.path.join(dr, 'cscope.files'), 'w')
        if flist is not None:
            flist.write('\n'.join(lst))
            flist.close()


def GenerateCscopeDb(dr):
    """Generate cscope db file for specified directory.

    :dr: directory to generate cscope db file
    :returns: path to cscope db file

    """
    dr = os.path.join(dr, '')
    cmd = 'cscope -bqR -P "' + dr + '"'
    p = subprocess.Popen(cmd, cwd=dr, shell=True)
    p.communicate()
    return os.path.join(dr, 'cscope.out')


#def GenerateGcLibCscopeDb():
#    """Generate cscope db files for GC repo lib projects.
#
#    :returns: list of GC repo lib cscope db files
#
#    """
#    lst = []
#    for libprj in lst_gcrepo_lib_prj:
#        GenerateFtsSrcFileList(libprj)
#        lst.append(GenerateCscopeDb(libprj))
#    return lst


def GenAndAddCscopeDb(dr):
    """Generate cscope db and add to vim cscope connections.

    :dr: directory to generate cscope db file
    :returns: None

    """
    f = GenerateCscopeDb(dr)
    # Use python to add cscope db to utilize easy path maniputlation
    print 'cscope add ' + f
    vim.command('cscope add ' + f)


def CallCdtBuild(ws, prj, cfg, md='cb'):
    """Build specified workspace, project and configuration using CDT headless build.

    :ws: workspace path
    :prj: project name
    :cfg: build configuration
    :md: build mode (build or clean build)

    """
    cmd = ' '.join(
        [
            bcmd,
            bcmd_ws_para,
            ws,
            bcmd_prj_para,
            prj + '/' + cfg
        ]
    )
    p = subprocess.Popen(cmd, shell=True, stdout=PIPE)
    stdo, stde = p.communicate()
