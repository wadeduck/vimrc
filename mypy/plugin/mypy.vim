if exists("loaded_mypy")
    finish
endif

let loaded_mypy = 1

if has("python")
    let s:mypyfolder = expand('<sfile>:p:h')
python << EOF
import sys
import vim
mypyfolder = vim.eval('s:mypyfolder')
if mypyfolder not in sys.path:
    sys.path.append(mypyfolder)
    import vimfts
    sys.path.remove(mypyfolder)
EOF
endif
