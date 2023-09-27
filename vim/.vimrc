" custom settings added by rovo98

"vim-plug Section Start {{{
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Racket support
Plug 'benknoble/vim-racket'
Plug 'jgdavey/tslime.vim'

" Make sure you use single quotes
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

" js/css/html
" for javascript.
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
" Plug 'iloginow/vim-stylus'
Plug 'cakebaker/scss-syntax.vim'
" for vue 
" Plugin 'posva/vim-vue'
" common
Plug 'Raimondi/delimitMate'
Plug 'Valloric/MatchTagAlways'
" Plug 'tpope/vim-fugitive'
" Plugin for editorconfig file.
Plug 'editorconfig/editorconfig-vim'

" Plugins 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'othree/xml.vim'
Plug 'leafgarland/typescript-vim'

" go language support
Plug 'fatih/vim-go', {'for': ['go']}

" for plantuml
Plug 'aklt/plantuml-syntax'
Plug 'scrooloose/vim-slumlord'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" for latex writing
Plug 'vim-latex/vim-latex'

" for zig lang support
Plug 'ziglang/zig.vim'

" Initialize plugin system
call plug#end()
" }}}

" Plugins customize {{{
" tslime {{{
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
vmap <leader>t <Plug>SendSelectionToTmux
nmap <leader>t <Plug>NormalModeSendToTmux
nmap <leader>T <Plug>SetTmuxVars
" }}}

" NERDTree {{{
" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Map a Specific key or shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" }}}

" tagbar {{{
nmap <F8> :TagbarToggle<CR> 
" Add support for markdown files in tagbar. We should copy the
" .markdown2ctags.py to the proper place to make it work.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" add support for go filetype.
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
" }}}

" emmet settings for wxapp.vim{{{
let g:user_emmet_settings = {
  \ 'wxss': {
  \   'extends': 'css',
  \ },
  \ 'wxml': {
  \   'extends': 'html',
  \   'aliases': {
  \     'div': 'view',
  \     'span': 'text',
  \   },
  \  'default_attributes': {
  \     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
  \     'navigator': [{'url': '', 'redirect': 'false'}],
  \     'scroll-view': [{'bindscroll': ''}],
  \     'swiper': [{'autoplay': 'false', 'current': '0'}],
  \     'icon': [{'type': 'success', 'size': '23'}],
  \     'progress': [{'precent': '0'}],
  \     'button': [{'size': 'default'}],
  \     'checkbox-group': [{'bindchange': ''}],
  \     'checkbox': [{'value': '', 'checked': ''}],
  \     'form': [{'bindsubmit': ''}],
  \     'input': [{'type': 'text'}],
  \     'label': [{'for': ''}],
  \     'picker': [{'bindchange': ''}],
  \     'radio-group': [{'bindchange': ''}],
  \     'radio': [{'checked': ''}],
  \     'switch': [{'checked': ''}],
  \     'slider': [{'value': ''}],
  \     'action-sheet': [{'bindchange': ''}],
  \     'modal': [{'title': ''}],
  \     'loading': [{'bindchange': ''}],
  \     'toast': [{'duration': '1500'}],
  \     'audio': [{'src': ''}],
  \     'video': [{'src': ''}],
  \     'image': [{'src': '', 'mode': 'scaleToFill'}],
  \   }
  \ },
  \}
"}}}

" setting javascript, css, html plugins
" synastic settings{{{
" let g:syntastic_error_symbol='>>'
" let g:syntastic_warning_symbol='>'
" let g:syntastic_enable_highlighting=1
" let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_html_checkers=['tidy', 'eslint']
"
" ale settings
let g:ale_fixers = {'javascript':['eslint']}
let g:ale_linters = {
\        'javascript':['eslint'],
\        'python':['pyflakes'],
\        'c': ['gcc', 'clang'],
\        'c++': ['gcc', 'clang'],
\        'go': ['gopls'],
\}
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options="-Wall -O2 -std=gnu99"
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" mapping keys to moving between errors
nmap <silent> <C-e> <Plug>(ale_previous_wrap)
nmap <silent> <C-m> <Plug>(ale_next_wrap)
"
" vim-autoformat {{{
" 集成eslint 来修复js代码
let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
let g:formatters_javascript = ['eslint']
noremap <F3> :Autoformat<CR>
"}}}
" for coc {{{
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" Shortcuts for denite interface
" Show symbols of current buffer
nnoremap <silent> <space>o  :<C-u>Denite coc-symbols<cr>
" Search symbols of current workspace
nnoremap <silent> <space>t  :<C-u>Denite coc-workspace<cr>
" Show diagnostics of current workspace
nnoremap <silent> <space>a  :<C-u>Denite coc-diagnostic<cr>
" Show available commands
nnoremap <silent> <space>c  :<C-u>Denite coc-command<cr>
" Show available services
nnoremap <silent> <space>s  :<C-u>Denite coc-service<cr>
" Show links of current buffer
nnoremap <silent> <space>l  :<C-u>Denite coc-link<cr>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" }}}

"for vim-css3-syntax {{{
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END
"}}}

" for matchtagalways {{{
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'wxml': 1,
    \}
let g:mta_set_default_matchtag_color = 1
" }}}

" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"}}}

" incsearch&incsearch-easymotion {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)
"}}}

" Settings for nerdcommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" }}}

"ultisnips settings {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"}}}

"vue-vim {{{
autocmd FileType vue syntax sync fromstart
"}}}
" vim-go {{{
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
"}}}
" editorconfig {{{
" to ensure work with fugitive and to avoid loading EditorConfig for any
" remote files or ssh
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
"}}}
" vim-latex {{{
" 使grep总是生成文件名
set grepprg=grep\ -nH\ $*
" vim默认把空的tex文件设为plaintex而不是tex，导致latex-suite不被加载
let g:tex_flavor='latex'
set iskeyword+=:
autocmd BufEnter *.tex set sw=2
" }}}
"}}}

" General {{{
set nocompatible
" 取消重做文件，备份文件
set noundofile
set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
set tabstop=4
" Vim 的默认寄存器和系统剪贴板共享
set clipboard=unnamedplus
" 自动检测文件外部修改
set autoread
" 鼠标可用
set mouse=a
" 显示当前光标位置
set ruler
" 突出显示当前行
set cursorline
" 开启实时搜索功能
set incsearch
" 显示当前命令
set showcmd
" 搜索时大小写不敏感
set ignorecase
" 搜索时出现大写字母时忽略ignorecase
set smartcase
" vim 自身命令行模式智能补全
set wildmenu
" 主题配置设置
colorscheme onedark
" colorscheme molokai
let g:airline_theme='onedark'
let g:onedark_termcolors=256
" }}}

" Format {{{
" 设置编辑时制表符占用的空格数
set tabstop=4
" 设置格式化时制表符占用的空格数
set shiftwidth=4
" 将制表符扩展为空格
set expandtab
" 让vim 将连续数量的空格视为一个制表符
set softtabstop=4
set foldmethod=manual
set nofoldenable
syntax enable
syntax on
" 设置行号和相对行号
set rnu
set nu
" 上下可视行数  
set scrolloff=6
" 显示括号匹配
set showmatch
" 针对特定文件的缩进
au BufNewFile,BufRead *.html,*.css,*.sass,*.js,*.vue,*.yml set tabstop=2
au BufNewFile,BufRead *.html,*.css,*.sass,*.js,*.vue,*.yml set softtabstop=2
au BufNewFile,BufRead *.html,*.css,*.sass,*.js,*.vue,*.yml set shiftwidth=2
au BufNewFile,BufRead *.html,*.css,*.sass,*.js,*.vue,*.yml set expandtab
au BufNewFile,BufRead *.html,*.css,*.sass,*.js,*.vue,*.yml set autoindent
au BufNewFile,BufRead *.html,*.css,*.sass,*.js,*.vue,*.yml set fileformat=unix
" }}}

" Startup {{{
" 启动时不显示援助提示
set shortmess=atI
" 开启文件类型侦测
filetype on
" 根据文件类型加载不同的插件
filetype indent plugin on

" vim 文件折叠方式为 marker
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END

" 记录光标位置

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
" " 自动加载修改后的vim配置
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
" 开启256色并模拟GUI中的光标模式
if !has('gui_runing')
    set t_Co=256
    if has('termguicolors')
        set termguicolors
    end
    " let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    " let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    set timeoutlen=1000 ttimeoutlen=0
endif
" for the cursor shape setting
if exists('$TMUX')
  let &t_SI = "\ePtmux;\e\e[5 q\e\\"
  let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif
" }}}

" Lang & Encoding {{{
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
let $LANG = 'en_US.UTF-8'
"language messages zh_CN.UTF-8
" }}}

" Key mapping {{{
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>th :tabp<cr>
map <leader>tl :tabn<cr>

" 移动分割窗口
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-j> <C-W>j

" 正常模式下 shift+j,k,h,l 调整分割窗口大小
let mapleader=","
noremap <leader>j :resize -5<cr>
noremap <leader>k :resize +5<cr>
noremap <leader>h :vertical resize -5<cr>
noremap <leader>l :vertical resize +5<cr>
"}}}

" Others {{{
set list
set lcs=space:.,tab:▸\ ,eol:¬

" vim colorscheme in fbterm
" if &term =="linux"
"     set t_Co=256
"     colo default
" endif
" add support for groovy in gradle filetype
au BufNewFile,BufRead *.gradle setf groovy
autocmd bufread,bufnewfile *.lisp,*.scm setlocal equalprg=scmindent

"" Something without plugins
" {{{
" " Search down into subfolders
set path+=**
" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - hit tab to : find by partial match
" - Use * to make it fuzzy
" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" TAG JUMPING
" Create the `tags` file (may need to instal ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g] for ambiguous tags
" - Use ^t to jump back up the tag stack
" THINKS TO CONSIDER:
" - This doesn't help if you wwant a virtual list of tags

" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|
" HIGHLIGHTS:
" - ^x^n for just this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^]for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list.

" FILE BROWSING:
" Tweaks for browsing
" let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
"}}}
" }}}
