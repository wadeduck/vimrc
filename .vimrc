"=============================================================================
"=========== Settings Start ==================================================
"=============================================================================
"----------- Behavior options ---------------------------------------------{{{
set nocompatible
set backupdir=$HOME/.vim/backup/
set directory=$HOME/.vim/swp/
set runtimepath=$HOME/.vim,$VIMRUNTIME,$HOME/.vim/after,$VIMRUNTIME/after
set viminfo=\"100,%10,'10,/50,:50,@10,f1,h,n~/.viminfo
" Set backup (create *~ file)
set backup
" Set hidden
set hidden
" Set command-line completion
set wildmenu
set wildmode=longest:list
" Increase command history size
set history=300
" Always show status line
set laststatus=2
" Do not refresh window in macro
set lazyredraw
let &errorformat =  '"%f"\, line %l: %trror:  #%n: %m'
let &errorformat .= ',"%f"\, line %l: Error:  #%n-%t: %m'
let &errorformat .= ',"%f"\, line %l: %tarning:  #%n: %m'
let &errorformat .= ',"%f"\, line %l: Warning:  #%n-%t: %m'
" Set filetype plugin enable
filetype plugin indent on
execute pathogen#infect()
"----------- End of Behavior options --------------------------------------}}}
"----------- Display Related Settings -------------------------------------{{{
" Remove toolbar in gvim
set guioptions-=T
" Remove menubar in gvim
set guioptions-=m
" Remove right scroll bar in gvim
set guioptions-=r
" Remove bottom scroll bar in gvim
set guioptions-=b
" Remove left scroll bar when vertical split window
set guioptions-=egLt
" Set ruler (row & col number at right bottom corner) on
" No longer need with Airline
"set ruler
" Set display the command characters typed (Unix default off)
set showcmd
" Set display wrap long lines
set wrap
" Set minimal number of screen lines to keep above/below cursor
set scrolloff=3
" Set highlight current line & column
if has("autocmd")
    augroup Highlight_Cursor
        autocmd!
        autocmd WinEnter    *   set cursorline cursorcolumn
        autocmd WinLeave    *   set nocursorline nocursorcolumn
    augroup END
endif
" Set <tab> & trailing space display
set listchars=tab:>.,trail:.
" Set split windows always same size
"set equalalways
" Set split windows equal in which direction
set eadirection=hor " 'ver', 'hor', 'both'
" Set BackSpace to delete over indent, eol, start of insert
set backspace=indent,eol,start
if has('win32')
    " Override background color
    hi  Normal  guibg=#000000
    set guifont=Powerline\ Consolas:h9
endif
" Maximize gvim window on start
if has("autocmd")
    augroup GUIEnter_Maximize
        autocmd!
        autocmd GUIEnter    * simalt ~x
    augroup END
endif
" Set colorscheme
if !exists('g:colors_name')
    colorscheme mydarkblue
elseif (g:colors_name !=? 'mydarkblue')
    colorscheme mydarkblue
endif
" Set "syntax on" option
syntax on
"----------- End of Display Related Settings ------------------------------}}}
"----------- File Format Settings -----------------------------------------{{{
" Set file format
set fileformats=dos,unix,mac
" Set default encoding
set encoding=utf-8
"----------- End of File Format Settings ----------------------------------}}}
"----------- Editing related Settings -------------------------------------{{{
" Set cursor move to adjust line
set whichwrap=b,s,<,>,[,]
" Auto change directory to current file directory
"set autochdir
" Set auto completion options
set completeopt=longest,menu
" Set complete scan
set complete=.,w,b
" Set auto indent (indent same as previous line)
set autoindent
" Set smart indent (like autoindent, with some auto C indent)
set smartindent
" Set expand tab (with space)
set expandtab
" Set default Tab space
set ts=4
" Set default shiftwidth
set sw=4
" Set default text width
set textwidth=120
" Set wrapmargin where a <eol> will be inserted before hitting textwidth
"set wrapmargin=2
"----------- End of Edit related Settings ---------------------------------}}}
"----------- Folding Options ----------------------------------------------{{{
" Set fold method (manual,indent,expr,marker,syntax,diff)
set foldmethod=syntax
" Set fold level when vim starts (default 0, all closed)
set foldlevel=99
" Set foldmethod to manual during insert
if has("autocmd")
    augroup InsertMode_Fold
        autocmd!
        autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
        autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
    augroup END
endif
"----------- End of Folding Options ---------------------------------------}}}
"----------- Search Options -----------------------------------------------{{{
" Set highlight search keyword
set hlsearch
" Set increment search (start searching while typing keyword)
set incsearch
"----------- End of Search Options ----------------------------------------}}}
"----------- Key Mappings -------------------------------------------------{{{
" Set key mapping settings
" Set time out on defined mappings
set timeout
" Set time out on key-codes
set nottimeout
" Set time in millisecond for mapping time out
set timeoutlen=500
" Set time in millisecond for key-codes mapping
set ttimeoutlen=-1
" Set <leader>
"let mapleader = ","
" Correct global typoes using abbreviations
cabbrev hlep help
iabbrev teh the
iabbrev tehn then
iabbrev waht what
iabbrev THis This
iabbrev improt import
iabbrev pirnt print
iabbrev promt prompt
iabbrev usigend     unsigned
iabbrev usnigned    unsigned
iabbrev unsgined    unsigned
iabbrev unsinged    unsigned
" Set paired symbols
inoremap {      {}<left>
inoremap [      []<left>
inoremap )      )<esc>
                \"9y2l
                \:if '))'=="<c-r>=escape(@9,'"\')<cr>"<bar>
                \  exec 'normal x'<bar>
                \endif<cr>
                \a
inoremap ]      ]<esc>
                \"9y2l
                \:if ']]'=="<c-r>=escape(@9,'"\')<cr>"<bar>
                \  exec 'normal x'<bar>
                \endif<cr>
                \a
inoremap }      }<esc>
                \"9y2l
                \:if '}}'=="<c-r>=escape(@9,'"\')<cr>"<bar>
                \  exec 'normal x'<bar>
                \endif<cr>
                \a
" Set 'p' for 'i(' in operator-pending mode
onoremap p      i(

"----------- File Type Specific autocmd -------------------------------------{{{
if has("autocmd")
"----------- Code Files -----------------------------------------------------{{{
    augroup FileType_Code
        autocmd!
        autocmd FileType    ahk,c,cpp,cs,h,java,javascript,python,vim     set number
        autocmd FileType    ahk,c,cpp,cs,h,java,javascript,python,vim     set relativenumber
        autocmd FileType    ahk,c,cpp,cs,h,java,javascript,python,vim     inoremap <buffer>   {<cr>  {<cr>}<esc>ko
    augroup END
"----------- End of Code Files ----------------------------------------------}}}
"----------- AHK Code Files -------------------------------------------------{{{
    augroup FileType_AHK_Code
        autocmd FileType    ahk                     iabbrev todo    ; TODO: <c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    ahk                     iabbrev TODO    ; TODO: <c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    ahk                     iabbrev NOTE    ; NOTE: <c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    ahk                     iabbrev iff     if ()<left><c-r>=<SID>Eatchar('\s')<cr>
    augroup END
"----------- End of AHK Code Files ------------------------------------------}}}
"----------- C Family Code Files --------------------------------------------{{{
    augroup FileType_C_Code
        autocmd!
        autocmd FileType    c,cpp,cs,h,java         set cindent
        autocmd FileType    c,cpp,cs,h,java         let g:load_doxygen_syntax=1
        autocmd FileType    c,cpp,cs,h,java         iabbrev /*      /*  */<left><left><left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         iabbrev todo    /* TODO:  */<left><left><left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         iabbrev TODO    /* TODO:  */<left><left><left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         iabbrev note    /* NOTE:  */<left><left><left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         iabbrev Note    /* NOTE:  */<left><left><left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         iabbrev NOTE    /* NOTE:  */<left><left><left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         iabbrev iff     if ()<left><c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    c,cpp,cs,h,java         inoremap <buffer>   {      {<cr>}<esc>ko
    augroup END
"----------- End of C Family Files ------------------------------------------}}}
"----------- FTS Workspace Files --------------------------------------------{{{
    augroup BufEnter_FTS
        autocmd!
        autocmd BufWinEnter *.\(h\|c\|s\)           call <SID>ChangeFtsDirectory()
    augroup END
"----------- End of FTS Workspace Files -------------------------------------}}}
"----------- Python Code Files ----------------------------------------------{{{
    augroup FileType_PY_Code
        autocmd!
        autocmd FileType    python                  iabbrev todo    # TODO: <c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    python                  iabbrev TODO    # TODO: <c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    python                  iabbrev NOTE    # NOTE: <c-r>=<SID>Eatchar('\s')<cr>
        autocmd FileType    python                  iabbrev iff     if :<left><c-r>=<SID>Eatchar('\s')<cr>
    augroup END
"----------- End of Python Files --------------------------------------------}}}
"----------- Quickfix Window ------------------------------------------------{{{
    augroup FileType_QF
        autocmd!
        autocmd FileType qf                         nnoremap <buffer> p     :call <SID>QuickfixPreview()<cr>
        autocmd FileType qf                         nnoremap <expr> <buffer> <esc>
                \ (match(w:quickfix_title, 'lcscope') ># -1)?
                \ ':silent lclose<cr>'
                \ : ':silent cclose<cr>'
        autocmd FileType qf                         nnoremap <expr> <buffer> <cr>
                \ (match(w:quickfix_title, 'lcscope') ># -1)?
                \ '<cr>:silent lclose<cr>'
                \ : '<cr>:silent cclose<cr>'
        autocmd FileType qf                         nnoremap <buffer> P     <cr>
        autocmd FileType qf                         nnoremap <expr> <buffer> <c-p>
                \ (match(w:quickfix_title, 'lcscope') ># -1)?
                \ ':silent lprevious<cr>:lopen 5<cr>'
                \ : ':silent cprevious<cr>:copen 5<cr>'
        autocmd FileType qf                         nnoremap <expr> <buffer> <c-n>
                \ (match(w:quickfix_title, 'lcscope') ># -1)?
                \ ':silent lnext<cr>:lopen 5<cr>'
                \ : ':silent cnext<cr>:copen 5<cr>'
    augroup END
"----------- End of Quickfix Window -----------------------------------------}}}
"----------- Tagbar Window --------------------------------------------------{{{
    augroup FileType_TAGBAR
        autocmd!
        autocmd FileType tagbar                     nnoremap <buffer> P     :call <SID>TagbarPreview()<cr>
    augroup END
"----------- End of Tagbar Window -------------------------------------------}}}
"----------- VIM Files ------------------------------------------------------{{{
    augroup FileType_VIM
        autocmd!
        autocmd FileType    vim             setlocal foldmethod=marker
    augroup END
"----------- End of VIM Files -----------------------------------------------}}}
"----------- XML Files ------------------------------------------------------{{{
    augroup FileType_XML
        autocmd!
        autocmd FileType    xml             let g:xml_syntax_folding = 1
        autocmd FileType    xml             setlocal tabstop=2
        autocmd FileType    xml             setlocal shiftwidth=2
    augroup END
"----------- End of XML Files -----------------------------------------------}}}
endif
"----------- End of File Type Specific autocmd ------------------------------}}}
" Use CTRL-U in insert mode to UPPER-CASE current word
inoremap <c-u>      <esc>viwUea
" Use ;; to quickly input substitute command
nnoremap <c-s>     :%s/\v/g<left><left>
" Use <c-/> to quickly input substitute previous search pattern command
"nnoremap <c-/>     :%s/<cr>//g<left><left>
" Use ;w to input substitude word under cursor
"nnoremap ;w     yiw:%s/\v<<c-r>">//g<left><left>
" Use /\v (very magic) by default to search
nnoremap /      /\v
" Use // to search previous search pattern (this is the default
" behaviour. To prevent '/\v')
nnoremap //     //
" Use / to search highlighted pattern in Visual mode
vnoremap /      y/\v<c-r>"<cr>
" Use // to search within highlighted in Visual mode
vnoremap //     /\%V\v
" Use ;; to input substitude pattern selected
"vnoremap ;;     y:%s/\v<c-r>"//g<left><left>
" Use <leader>rc to open ~\.vimrc
nnoremap <leader>rc :vsplit $MYVIMRC<cr>
" Use <leader>rc to source ~\.vimrc
nnoremap <leader>sc :source $MYVIMRC<cr>
" Use <c-k> <c-j> to move one line up/down in display (for wrapped lines)
inoremap <c-k>  <c-o>gk
inoremap <c-j>  <c-o>gj
" Use <c-e> <c-y> to scroll (without moving cursor) 3 lines a time
nnoremap <c-e>  3<c-e>
nnoremap <c-y>  3<c-y>
" Use <c-n>/<c-p> to switch to next/previous buffer
nnoremap <c-n>  :bn<cr>
nnoremap <c-p>  :bp<cr>
" Use <c-j>/<c-k>/<c-h>/<c-l> to navigate to different window
nnoremap <c-j>  <c-w><c-j>
nnoremap <c-k>  <c-w><c-k>
nnoremap <c-h>  <c-w><c-h>
nnoremap <c-l>  <c-w><c-l>
" Use <leader>r to search for string occurances in files
"nnoremap <leader>r  :execute "vimgrep! /" . expand('<cword>') . "/j **/*.c **/*.h"<cr>:copen<cr>
nnoremap <leader>r  :set operatorfunc=<SID>VimgrepOperator<cr>g@
nnoremap <leader>rr :call <SID>VimgrepOperator('cword')<cr>
vnoremap <leader>r  :<c-u> call <SID>VimgrepOperator(visualmode())<cr>
" Set F11 to equalize split windows
nnoremap <f11>  <esc>:set noequalalways<cr>
                \:set equalalways<cr>
" Map <c-p>/<c-n> to <up>/<down> in commandline
cnoremap <c-p>  <up>
cnoremap <c-n>  <down>
cnoremap <c-h>  <left>
cnoremap <c-l>  <right>
" Map cscope commands
cnoreabbrev <expr> csa
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
cnoreabbrev <expr> csf
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
cnoreabbrev <expr> csk
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs kill' : 'csk')
cnoreabbrev <expr> csr
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs reset' : 'csr')
cnoreabbrev <expr> css
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs show' : 'css')
cnoreabbrev <expr> csh
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs help' : 'csh')
" Map :mks to save session file in ~/.vim/session folder
cnoreabbrev <expr> mks
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)?
    \ 'mks! ~/.vim/session/.vimsession' . repeat('<left>', 11)
    \ . '<c-r>=<SID>Eatchar(''\s'')<cr>'
    \ : 'mks')
cnoreabbrev <expr> sos
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)?
    \ 'so ~/.vim/session/'
    \ . '<c-r>=<SID>Eatchar(''\s'')<cr>'
    \ : 'sos')
" Map :vsb to vertical split buffer
cnoreabbrev <expr> vsb
    \ ((getcmdtype() == ':' && getcmdpos() <= 4)?
    \ 'vert sb'
    \ : 'vsb')

"----------- End of Key Mappings ------------------------------------------}}}
"----------- MS-Windows specific settings ---------------------------------{{{
" Alt-Space is System menu
if has("gui")
    nnoremap <m-space> :simalt ~<cr>
    inoremap <m-space> <c-o>:simalt ~<cr>
    cnoremap <m-space> <c-c>:simalt ~<cr>
endif
" Set ALT-J to switch to MS Gothic font
" Set ALT-N to switch to Terminus
" Set ALT-C to switch to NSimSun
" Set ALT-L to switch to Consolas
if has("gui")
"    nnoremap <m-j>  <esc>:se guifont=MS_Gothic:h10:cSHIFTJIS<cr>
"    nnoremap <m-n>  <esc>:se guifont=Terminus:h12<cr>
"    nnoremap <m-c>  <esc>:se guifont=NSimSun:h10:cGB2312<cr>
    nnoremap <m-l>  <esc>:se guifont=<c-r>=
                \ (match(&g:guifont, 'Consolas') >=# 0) ?
                \ 'NSimSun:h10:cGB2312'
                \ : 'Powerline\ Consolas:h9'<cr>
                \ <cr>
endif
"----------- End of MS-Windows specific settings --------------------------}}}
"--------------------------------------------------------------------------{{{
"----------- plugin settings -------------------------------------------------
"-----------------------------------------------------------------------------
"----------- Airline settings ---------------------------------------------{{{
" Use patched powerline fonts for best look
let g:airline_powerline_fonts=1
"----------- End of Airline settings --------------------------------------}}}
"----------- ctags & Taglist ----------------------------------------------{{{
" Set the default tags file path
"set tags=~/vc9tags;./tags
"set tags=./tags;../tags;../../tags;../../../tags;../../../../tags;~/tags;~/vmshproj/*/tags;E:\My\ Documents\Visual\ Studio\ 2008\Projects\tags
set tags=./tags,./TAGS,tags,TAGS,../tags,../../tags,../../../tags
" Set ctags program for windows
"----------- End of ctags & Taglist ---------------------------------------}}}
"----------- Tagbar -------------------------------------------------------{{{
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_width = 35
nnoremap <silent> <f10> <esc>:TagbarToggle<cr>
"----------- End of Tagbar ------------------------------------------------}}}
"----------- Cscope Mappings ----------------------------------------------{{{
" Following are copied from cscope_maps.vim by Jason Duell
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose
endif

" Set CTRL-F12 to generate tags
"nnoremap <c-f12>    :!ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .<cr>
nnoremap <c-f12>    :!cscope -bR<cr><cr>
" Set cscope key mappings (borrowed from cscope_maps.vim)
if has("cscope")
    " Map CTRL-\ <op> to cscope find commands, swap 'r' (reference) inplace for 'c'(call)
    nnoremap <c-\>s     :call <SID>CscopeToQuickfix('s')<cr>
    nnoremap <c-\>g     :call <SID>CscopeToQuickfix('g')<cr>
    nnoremap <c-\>r     :call <SID>CscopeToQuickfix('c')<cr>
    nnoremap <c-\>t     :call <SID>CscopeToQuickfix('t')<cr>
    nnoremap <c-\>e     :call <SID>CscopeToQuickfix('e')<cr>
    nnoremap <c-\>f     :call <SID>CscopeToQuickfix('f')<cr>
    nnoremap <c-\>i     :call <SID>CscopeToQuickfix('i')<cr>
    nnoremap <c-\>d     :call <SID>CscopeToQuickfix('d')<cr>

    " Same as above, but hold CTRL key for both '\' and <op>, swap 'r' (reference) inplace for 'c'(call)
    nnoremap <c-\><c-s> :call <SID>CscopeToQuickfix('s')<cr>
    nnoremap <c-\><c-g> :call <SID>CscopeToQuickfix('g')<cr>
    nnoremap <c-\><c-r> :call <SID>CscopeToQuickfix('c')<cr>
    nnoremap <c-\><c-t> :call <SID>CscopeToQuickfix('t')<cr>
    nnoremap <c-\><c-e> :call <SID>CscopeToQuickfix('e')<cr>
    nnoremap <c-\><c-f> :call <SID>CscopeToQuickfix('f')<cr>
    nnoremap <c-\><c-i> :call <SID>CscopeToQuickfix('i')<cr>
    nnoremap <c-\><c-d> :call <SID>CscopeToQuickfix('d')<cr>

    " Map CTRL-m <op> to cscope find commands, fill quickfix, swap 'r' (reference) inplace for 'c'(call)
    nnoremap <c-m>s     :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m>g     :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m>r     :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m>t     :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m>e     :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m>f     :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <c-m>i     :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <c-m>d     :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Same as above, but hold CTRL key for both 'm' and <op>, fill quickfix, swap 'r' (reference) inplace for 'c'(call)
    nnoremap <c-m><c-s> :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m><c-g> :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m><c-r> :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m><c-t> :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m><c-e> :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <c-m><c-f> :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <c-m><c-i> :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <c-m><c-d> :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
"----------- Endo of Cscope Mappings --------------------------------------}}}
"----------- Auto-Popup ---------------------------------------------------{{{
" Enable Auto-Popup at startup
let g:acp_enableAtStartup = 1
" Set case sensitive in auto-popup
let g:acp_ignorecaseOption = 1
" Use <tab> Key to switch to next auto-completion item
" Use <ctrl-tab> Key to switch to previous auto-completion item
" Use <ctrl-l> Key to insert <tab>
let g:acp_behaviorKeywordCommand = "\<c-n>"
inoremap <c-l> <tab>
inoremap <tab> <c-n>
inoremap <c-tab> <c-p>
" Set auto-popup from the 2nd letter on
let g:acp_behaviorKeywordLength = 3
" Set auto-popup completion range
let g:acp_completeOption = ".,w,b"
" Set 'preview' option for completion
let g:acp_completeoptPreview = 0
"----------- End of Auto-Popup --------------------------------------------}}}
" ---------- DoxygenToolkit -----------------------------------------------{{{
"if has("autocmd")
"   autocmd FileType    c,cpp,cs,h,java let g:DoxygenToolkit_commentType="C++"
"   autocmd FileType    c,cpp,cs,h,java let g:DoxygenToolkit_authorName="Zhao Wenhe"
"   autocmd FileType    c,cs,cpp,h,java let g:DoxygenToolkit_briefTag_pre="@brief   "
"   autocmd FileType    c,cs,cpp,h,java let g:DoxygenToolkit_paramTag_pre="@param [in]"
"   autocmd FileType    c,cs,cpp,h,hava let g:DoxygenToolkit_returnTag="@return"
"endif
"let g:DoxygenToolkit_commentType="C++"
"----------- End of DoxygenToolkit ----------------------------------------}}}
"----------- NERDTree -----------------------------------------------------{{{
" Set F12 to toggle NERDTree
nnoremap <f12> <esc>:NERDTreeToggle<cr>
inoremap <f12> <c-o>:NERDTreeToggle<cr>
"----------- End of NERDTree ----------------------------------------------}}}
"----------- EasyMotion settings ------------------------------------------{{{
" Set EasyMotion trigger key to <leader>
nmap <leader>   <plug>(easymotion-prefix)
nmap <m-w>      <plug>(easymotion-w)
nmap <m-b>      <plug>(easymotion-b)
nmap <m-j>      <plug>(easymotion-j)
nmap <m-k>      <plug>(easymotion-k)
nmap <m-s>      <plug>(easymotion-s)
"----------- End of EasyMotion settings -----------------------------------}}}
"----------- DoxygenToolkit -----------------------------------------------{{{
" Set Alt-D to generate function comments
nnoremap <m-d> <esc>:Dox<cr>
let g:Doxy_LoadMenus='no'
"----------- End of DoxygenToolkit ----------------------------------------}}}
"----------- Alternative File (a.vim) -------------------------------------{{{
" Use <c-tab> to switch between alternative files
nnoremap <c-tab> :A<cr>
"----------- End of Alternative File (a.vim) ------------------------------}}}
"----------- MiniBufExpl --------------------------------------------------{{{
" Use <leader>t to toggle MBE window
nnoremap <c-t>   :silent MBEToggle<cr>:silent MBEFocus<cr>
"----------- End of MiniBufExpl -------------------------------------------}}}
"----------- Functions ----------------------------------------------------{{{
"----------- MyDiff() -----------------------------------------------------{{{
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"--------------------------------------------------------------------------}}}
"----------- Eatchar() ----------------------------------------------------{{{
function! s:Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunction
"--------------------------------------------------------------------------}}}
"----------- ChangeFtsDirectory() -----------------------------------------{{{
function! s:ChangeFtsDirectory()
    let filepath = expand('%:p:h')
    let folderpath = matchstr(filepath, '\v\c\w:\\projects\\\w{1,}\\\w{1,}')
    if empty(folderpath)
        if !empty(glob(filepath))
            execute 'lcd ' . filepath
        endif
    else
        execute 'cd ' . folderpath
    endif
endfunction
"--------------------------------------------------------------------------}}}
"----------- VimgrepOperator() --------------------------------------------{{{
function! s:VimgrepOperator(type)
    let unnamed_reg = @@

    if a:type ==# 'char'
        normal! `[v`]y
    elseif a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'cword'
        normal! yiw
    else
        " Ignore 'line', 'block' or 'V'
        return
    endif

    silent execute "vimgrep! /\\V\\<" . @@ . "\\>/j **/*.c **/*.h"
    let @@ = unnamed_reg
    copen 5
endfunction
"--------------------------------------------------------------------------}}}
"----------- QuickfixPreview() --------------------------------------------{{{
function! s:QuickfixPreview()
    let qfwinnr = winnr()
    if &l:lazyredraw
        execute "redraw!"
    endif

    execute "normal! \<cr>"
    execute qfwinnr . "wincmd w"
endfunction
"--------------------------------------------------------------------------}}}
"----------- TagbarPreview() ----------------------------------------------{{{
function! s:TagbarPreview()
    let bktagbar_autoclose = &g:tagbar_autoclose
    &g:tagbar_autoclose = 0
    execute "normal! \<cr>"
    &g:tagbar_autoclose = bktagbar_autoclose
endfunction
"--------------------------------------------------------------------------}}}
"----------- CscopeToQuickfix() -------------------------------------------{{{
function! s:CscopeToQuickfix(type)
    let lcsqf = &l:cscopequickfix
    let tmpcsqf = ''
    let cmd = ''

    if a:type ==# 's' || a:type ==# 'g' || a:type ==# 'd' || a:type ==# 'c'
      \|| a:type ==# 't' || a:type ==# 'e'
      let tmpcsqf = a:type
      let cmd = 'lcscope find ' . a:type . ' ' . expand('<cword>')
    elseif a:type ==# 'f'
      let tmpcsqf = a:type
      let cmd = 'lcscope find ' . a:type . ' ' . expand('<cfile>')
    elseif a:type ==# 'i'
      let tmpcsqf = a:type
      let cmd = 'lcscope find ' . a:type . ' ^' . expand('<cfile>') . '$'
    endif

    if !empty(tmpcsqf) && !empty(cmd)
        let tmpcsqf .= '-'
        let &l:cscopequickfix = tmpcsqf
        execute cmd
        execute 'lopen 5'
    endif

    let &l:cscopequickfix = lcsqf
endfunction
"--------------------------------------------------------------------------}}}
"----------- End of Functions ---------------------------------------------}}}
"=============================================================================
"=========== Settings End ====================================================
"=============================================================================
