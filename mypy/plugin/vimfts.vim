if exists("loaded_mypy")
    finish
endif

let loaded_mypy = 1

"----------- File Type Specific autocmd -------------------------------------{{{
if has("autocmd")
"----------- FTS Workspace Files --------------------------------------------{{{
    augroup BufEnter_FTS
        autocmd!
        autocmd BufWinEnter *.\(h\|c\|s\)   call <SID>FtsWorkspaceCheck()
    augroup END
"----------- End of FTS Workspace Files -------------------------------------}}}
endif
"----------- End of File Type Specific autocmd ------------------------------}}}
"----------- User Commands --------------------------------------------------{{{
command! -nargs=* -complete=custom,<SID>CdtBuildCmdComplete MyBuild call s:CallCdtBuild(<q-args>)
"----------- End of User Commands -------------------------------------------}}}
"----------- Vimscript Functions ------------------------------------------{{{
"----------- FtsWorkspaceCheck() ------------------------------------------{{{
function! s:FtsWorkspaceCheck()
    " Skip if run in diff mode
    if &diff
        return
    endif

    if !exists('b:vimfts_isFtsWorkspace')
        let filepath = expand('%:p')
        let matchlst = matchlist(filepath, '\v\c(\w:\\projects\\\w{1,})\\(\w{1,})')
        if !empty(matchlst)
            " Looks like a FTS workspace
            let b:vimfts_isFtsWorkspace = 1
            if !has_key(g:vimfts_dict_fn_wsprj, filepath)
                " Add file to dictionary
                let g:vimfts_dict_fn_wsprj[filepath] = matchlst[0]
            endif
            let g:vimfts_cur_ws = matchlst[1]
            let g:vimfts_cur_prj = matchlst[2]
        else
            let b:vimfts_isFtsWorkspace = 0
        endif

        if b:vimfts_isFtsWorkspace ==# 1
            if !has_key(g:vimfts_dict_wsprj_cfglst, matchlst[0])
                " Add project build configurations to list
                call <SID>GetCdtBuildConfig(matchlst[0])
                " Attempt to generate & add cscope file
                call <SID>GenAndAddCscopeDb(matchlst[0])
            endif

            call <SID>SetFtsAbbrev()
        endif
    elseif b:vimfts_isFtsWorkspace ==# 1
        let matchlst = matchlist(expand('%:p'), '\v\c\w:\\projects\\(\w{1,})\\(\w{1,})')
        let g:vimfts_cur_ws = matchlst[1]
        let g:vimfts_cur_prj = matchlst[2]
    endif
endfunction
"--------------------------------------------------------------------------}}}
"----------- SetFtsAbbrev() -----------------------------------------------){{{
function! s:SetFtsAbbrev()
    iabbrev <buffer>    true        TRUE
    iabbrev <buffer>    false       FALSE
    iabbrev <buffer>    s8          int8_t s8_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    s8p         int8_t *s8p_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    u8          uint8_t u8_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    u8p         uint8_t *u8p_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    s16         int16_t s16_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    s16p        int16_t *s16p_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    u16         uint16_t u16_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    u16p        uint16_t *u16p_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    s32         int32_t s32_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    s32p        int32_t *s32p_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    u32         uint32_t u32_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    u32p        uint32_t *u32p_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    bl          bool_t b_<c-r>=<SID>Eatchar('\s')<cr>
    iabbrev <buffer>    bool        bool_t
    iabbrev <buffer>    int8        int8_t
    iabbrev <buffer>    uint8       uint8_t
    iabbrev <buffer>    int16       int16_t
    iabbrev <buffer>    uint16      uint16_t
    iabbrev <buffer>    int32       int32_t
    iabbrev <buffer>    uint32      uint32_t
endfunction
"--------------------------------------------------------------------------}}}
"----------- End of Vimscript Functions -----------------------------------}}}
"----------- Python Functions ---------------------------------------------{{{
"----------- GetCdtBuildConfig Function -----------------------------------{{{
function! s:GetCdtBuildConfig(prjpath)
    let tmp_wsprj_cfg = 'somenonexistconfig'
    execute 'python vimfts.GetCdtBuildConfig('
            \ . shellescape(a:prjpath) . ', '
            \ . '"tmp_wsprj_cfg"' . ')'
    if tmp_wsprj_cfg !=# 'somenonexistconfig'
        let g:vimfts_dict_wsprj_cfglst[a:prjpath] = split(tmp_wsprj_cfg, ',')
    endif
endfunction
"----------- End of GetCdtBuildConfig Function ----------------------------}}}
"----------- GenAndAddCscopeDb Function -----------------------------------{{{
function! s:GenAndAddCscopeDb(prjpath)
    " Call python function to generate cscope list
    execute 'python vimfts.GenerateFtsSrcFileList('
            \ . shellescape(a:prjpath) . ')'
    " Kill all cscope connections (normally there should be only one anyway)
    execute 'cscope kill -1'
    " Generate and add cscope index files
    execute 'python vimfts.GenAndAddCscopeDb('
            \ . shellescape(a:prjpath) . ')'
endfunction
"----------- End of GenAndAddCscopeDb Function ----------------------------}}}
"----------- GenerateGcLibCscopeDb Function -------------------------------{{{
function! s:GenerateGcLibCscopeDb()
    " Call python function to generate cscope db for lib projects
    execute 'python vimfts.GenerateGcLibCscopeDb()'
endfunction
"----------- End of GenerateGcLibCscopeDb Function ------------------------}}}
"----------- CdtBuildCmdComplete Function ---------------------------------{{{
function! s:CdtBuildCmdComplete(ArgLead, CmdLine, CursorPos)
    " TODO: Complete build command with currently loaded workspace and projects
    echom a:CmdLine
    return "Apple\nBanana\nCat\nDog"
endfunction
"----------- End of CdtBuildCmdComplete Function --------------------------}}}
"----------- CallCdtBuild Function ----------------------------------------{{{
function! s:CallCdtBuild(workspace, project, buildcfg)
    " Pass current workspace, project and build configuration to python
    " TODO: Continue coding here
endfunction
"----------- End of CallCdtBuild Function ---------------------------------}}}
"----------- End of Python Function ---------------------------------------}}}

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
