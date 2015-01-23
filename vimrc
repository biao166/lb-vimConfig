" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" -----------------------------------------------------------------------------
"  < Bundle >
" -----------------------------------------------------------------------------
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/Vundle.vim'

" 代码搜索
Bundle 'ack.vim'
let g:ackprg = 'ag --nogroup --nocolor --column'

" 对文件以及buffer进行模糊查询，快速打开文件 (ctrl + p )
Bundle 'ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2

Bundle 'scrooloose/nerdtree' 
" {
	nmap <F2> :NERDTreeToggle<CR>
	let NERDTreeShowBookmarks=1
	let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
	let NERDTreeChDirMode=0
	let NERDTreeQuitOnOpen=1
	let NERDTreeMouseMode=2
	let NERDTreeShowHidden=1
	let NERDTreeKeepTreeInNewTab=1
	let g:nerdtree_tabs_open_on_gui_startup=0

	" 自动显示边栏
	" autocmd StdinReadPre * let s:std_in=1
	" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }

" making NERDTree feel like a true panel
Bundle 'jistr/vim-nerdtree-tabs'
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" best Git wrapper of all time
Bundle 'tpope/vim-fugitive'

" 代码注释
Bundle 'scrooloose/nerdcommenter'

Bundle 'Shougo/neocomplcache.vim' 
" {
	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	" Enable heavy features.
	" Use camel case completion.
	"let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	"let g:neocomplcache_enable_underbar_completion = 1

	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  return neocomplcache#smart_close_popup() . "\<CR>"
	  " For no inserting <CR> key.
	  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplcache_enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplcache_enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplcache_force_omni_patterns')
	  let g:neocomplcache_force_omni_patterns = {}
	endif
	let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }

Bundle 'honza/vim-snippets'

" 缩进
Bundle 'nathanaelkane/vim-indent-guides'

Bundle 'pangloss/vim-javascript'

" 状态栏
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_cache_enabled = 1

" 代码高亮 （选中要高亮的词，使用 \m 来使其高亮，\n 去除）
Bundle 'mark.vim'

Bundle 'sudo.vim'
Bundle 'emmet.vim'

" theme bundle
Bundle 'busybee'
Bundle 'DAddYE/soda.vim'
Bundle 'altercation/vim-colors-solarized'

call vundle#end()            " required
filetype plugin indent on    " required



" -----------------------------------------------------------------------------
"  < 基本设置 >
" -----------------------------------------------------------------------------
" 显示行号
set number

" 设置命令行
set cmdheight=1

" 突出显示当前行                                     
set cursorline

" 设置自动换行             
set wrap

" 去掉欢迎界面                                       
set shortmess=atI
                     
" 忽略大小写查找
set ic

" 设定文件浏览器目录为当前目录
set bsdir=buffer

" 设置编码
set enc=utf-8

" 设置文件编码
set fenc=utf-8

" 设置文件编码检测类型及支持格式
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" 设置 gVim 窗口初始位置及大小
if g:isGUI
    " au GUIEnter * simalt ~x                         "窗口启动时自动最大化
    winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
endif

" 设置代码配色方案
if g:isGUI
	"Gvim配色方案
    syntax enable
	set background=dark
	colorscheme solarized 
else
	"终端配色方案
    syntax enable
	set background=dark
	colorscheme solarized
	
	" for colorscheme solarized
	let g:solarized_termcolors=256	
endif

" tab宽度
set tabstop=4
set cindent shiftwidth=2
set autoindent shiftwidth=2

" set 折叠
set foldmethod=indent

" 打开文件默认不折叠
set foldlevelstart=99

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif


" 把 CTRL-S 映射为 保存,因为这个操作做得太习惯了
imap <C-S> <C-C>:w<CR>

" 启用状态栏信息
set laststatus=2

" 启用256色
set t_Co=256

" 忽略文件
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" 操作 tabs
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" set my leader
let mapleader=","
let g:mapleader=","

" switch window
:map <leader>w <C-W>w

"use in edit
imap <C-A> <C-C><c-p>

" use in none edit
:map <leader>t <c-p>
:map <leader>b :CtrlPBuffer<CR>

" move lines up or down (command - D)
nmap <D-j> mz:m+<cr>`z
nmap <D-k> mz:m-2<cr>`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Tab move lines left or right (c-Ctrl,s-Shift)
nmap    <c-tab>     v>
nmap    <s-tab>     v<
vmap    <c-tab>     >gv
vmap    <s-tab>     <gv

" Enable omni completion. （关键字补全）
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" process past
set pastetoggle=<F3>
nnoremap <F3> :set invpaste paste?<CR>
imap <F3> <C-O>:set invpaste paste?<CR>

" tab navigation like zsh
:nmap <D-1> :tabprevious<CR>
:map <D-1> :tabprevious<CR>
imap <D-1> <Esc>:tabprevious<CR>i

:nmap <D-2> :tabnext<CR>
:map <D-2> :tabnext<CR>
imap <D-2> <Esc>:tabnext<CR>i

" window 特殊设置
if g:iswindows
	set encoding=utf-8
	set termencoding=utf-8
	set fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,chinese,cp936

	" vim的菜单乱码解决 for windows
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim

	" vim提示信息乱码的解决 for windows
	language messages zh_CN.utf-8
	
	"设置字体:字号（字体名称空格用下划线代替）
	set guifont=Source\ Code\ Pro\:h10
endif