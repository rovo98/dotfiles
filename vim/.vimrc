" custom settings added by rovo98

"Vundle Section Start {{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" ADDYOUR PLUGIN
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
" js/css/html
" for javascript.
Plugin 'othree/yajs.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
" for css
Plugin 'hail2u/vim-css3-syntax'
Plugin 'gko/vim-coloresque'
Plugin 'groenewege/vim-less'
" common
Plugin 'Raimondi/delimitMate'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/MatchTagAlways'
" Plugins 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
Plugin 'Chiel92/vim-autoformat'

Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'

" Plugins for wechat_webdev
Plugin 'chemzqm/wxapp.vim'
Plugin 'neoclide/coc.nvim', {'do': 'yarn install'}
Plugin 'ternjs/tern_for_vim'
Plugin 'othree/xml.vim'

" Plugins for drawing diagram
Plugin 'aklt/plantuml-syntax'
Plugin 'scrooloose/vim-slumlord'
call vundle#end()
filetype plugin indent on
" }}}

" Plugins customize {{{

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
" eslint
let g:ale_fixers = {'javascript':['eslint']}
let g:ale_linters = {
\        'javascript':['eslint'],
\        'python':['pyflakes'],
\}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" mapping keys to moving between errors
nmap <silent> <C-e> <Plug>(ale_previous_wrap)
nmap <silent> <C-m> <Plug>(ale_next_wrap)
"
" " 修改高亮的背景色, 适应主题
" highlight SyntasticErrorSign guifg=white guibg=black
"
" " to see error location list
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_loc_list_height = 5
" function! ToggleErrors()
"     let old_last_winnr = winnr('$')
"     lclose
"     if old_last_winnr == winnr('$')
"         " Nothing was closed, open syntastic error location panel
"         Errors
"     endif
" endfunction
" nnoremap <Leader>e :call ToggleErrors()<cr>
" nnoremap <Leader>ne :lnext<cr>
" nnoremap <Leader>pe :lprevious<cr>
" }}}
" vim-autoformat {{{
" 集成eslint 来修复js代码
let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
let g:formatters_javascript = ['eslint']
noremap <F3> :Autoformat<CR>
"}}}
" for coc {{{
" if hidden not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <C-x><C-o> to complete 'word', 'emoji' and 'include' sources
imap <silent> <C-x><C-o> <Plug>(coc-complete-custom)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <cr> for confirm completion.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Show signature help while editing
autocmd CursorHoldI * silent! call CocAction('showSignatureHelp')
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocAction('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
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

" ycm {{{
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_semantic_triggers = {
 \   'javascript': ['.', 're!(?=[a-zA-Z]{3,4})'],
 \   'html': ['<', '"', '</', ' '],
 \   'scss,css': [ 're!^\s{2,4}', 're!:\s+' ],
 \ }
let g:ycm_semantic_triggers.c = ['->', '.', '(', '[', '&']
"Java Semantic Completion settings.
" to enable java support, manually disable Syntastic java Diagnostics.
let g:syntastic_java_checkers = []
" when enabling java support, manually disable Eclim java diagnostics.
let g:EclimFileTypeValidate = 0


" YouCompleteMe 功能  
" 补全功能在注释中同样有效  
let g:ycm_complete_in_comments=0
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示  
let g:ycm_confirm_extra_conf=0
" 开启 YCM 基于标签引擎  
let g:ycm_collect_identifiers_from_tags_files=1  
" 引入 C++ 标准库tags，这个没有也没关系，只要.ycm_extra_conf.py文件中指定了正确的标准库路径  
set tags+=/data/misc/software/misc./vim/stdcpp.tags  
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键  
inoremap <leader>; <C-x><C-o>  
" 补全内容不以分割子窗口形式出现，只显示补全列表  
set completeopt-=preview  
" 从第一个键入字符就开始罗列匹配项  
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项  
let g:ycm_cache_omnifunc=0  
" 语法关键字补全              
let g:ycm_seed_identifiers_with_syntax=1  
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;  
" let g:ycm_key_invoke_completion = '<M-;>'
let g:ycm_key_invoke_completion = '<c-z>'  
" 设置转到定义处的快捷键为ALT + G，这个功能非常赞  
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>  
" 设置按哪个键上屏
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
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
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

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
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"}}}
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
set t_Co=256
colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1
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
syntax enable
syntax on
" 设置行号和相对行号
set rnu
set nu
" 上下可视行数  
set scrolloff=6
" 显示括号匹配
set showmatch
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
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    set timeoutlen=1000 ttimeoutlen=0
endif
" }}}

" Lang & Encoding {{{
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
let $LANG = 'en_US.UTF-8'
"language messages zh_CN.UTF-8
" }}}

" Key mapping {{{
let mapleader=","
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>th :tabp<cr>
map <leader>tl :tabn<cr>

" 移动分割窗口
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap <C-j> <C-W>j

" 正常模式下 shift+j,k,h,l 调整分割窗口大小
nnoremap <S-j> :resize -5<cr>
nnoremap <S-k> :resize +5<cr>
nnoremap <S-h> :vertical resize -5<cr>
nnoremap <S-l> :vertical resize +5<cr>

nnoremap <leader>w :set wrap!<cr>
"}}}

" Others {{{
" for ag the_sliver_search
let g:ackprg = 'ag --vimgrep'
" 空格显示用圆点表示, (默认)行尾提示$, 空格用.提示
set listchars=space:.
set list
" }}}
