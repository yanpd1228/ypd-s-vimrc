if has('python3')
endif
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
" 常用设置
" 设置行号
set number
" 按F2 进入粘贴模式
" set pastetoggle=<F2>
" 高亮搜索
set hlsearch
" 设置折叠方式
set foldmethod=indent
" 一些方便的映射
let mapleader=','
let g:mapleader=','

" 使用 jj  进入 normal 模式
" inoremap jj <Esc>`^
" 使用 leader+w 直接保存
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>

" 切换 buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> [n :bnext<CR>
" use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"设置下划线
set cursorline
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null
" json 格式化
com! FormatJSONPy2Utf8 %!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=2)"


" 插件设置，这里使用了 vim-plug
call plug#begin('~/.vim/plugged')

" 安装插件只需要把 github 地址放到这里重启后执行 :PlugInstall 就好了
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asyncrun.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' "airline 的主题
call plug#end()
"主题设置
syntax enable
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
set t_Co=256
"colorscheme solarized

"代码编译设置
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" 插件相关配置
" 禁止 startify 自动切换目录
let g:startify_change_to_dir = 0

" nerdtree
nmap ,v :NERDTreeFind<cr>
nmap ,g :NERDTreeToggle<cr>
" 设置NerdTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
" 切换 buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> [n :bnext<CR>

let g:ycm_seed_identifiers_with_syntax = 1
"在注释中也开启补全
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"字符串中也开启补全
let g:ycm_complete_in_strings = 1
"自动开启语义补全
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>


let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码

"set foldclose=all          " 设置为自动关闭折叠
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠


" ale-setting {{{

let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 1 

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'c++': ['clang','gcc'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}
let g:ale_list_window_size = 10
" }}}
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
let g:AutoPairs['<']='>'
let g:AutoPairsMapCR = 1

let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进

" 设置状态栏
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme = 'desertink'  " 主题
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
       \ '0': '0 ',
       \ '1': '1 ',
       \ '2': '2 ',
       \ '3': '3 ',
       \ '4': '4 ',
       \ '5': '5 ',
       \ '6': '6 ',
       \ '7': '7 ',
       \ '8': '8 ',
       \ '9': '9 '
       \}
" 设置切换tab的快捷键 <\> + <i> 切换到第i个 tab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" 设置切换tab的快捷键 <\> + <-> 切换到前一个 tab
nmap <leader>- <Plug>AirlineSelectPrevTab
" 设置切换tab的快捷键 <\> + <+> 切换到后一个 tab
nmap <leader>+ <Plug>AirlineSelectNextTab
" 设置切换tab的快捷键 <\> + <q> 退出当前的 tab
nmap <leader>q :bp<cr>:bd #<cr>
" 修改了一些个人不喜欢的字符
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = "CL" " current line
let g:airline_symbols.whitespace = '|'
let g:airline_symbols.maxlinenr = 'Ml' "maxline
let g:airline_symbols.branch = 'BR'
let g:airline_symbols.readonly = "RO"
let g:airline_symbols.dirty = "DT"
let g:airline_symbols.crypt = "CR"
nmap <tab> :bn<cr> "设置tab键映射"
nmap <C-D> :bdelete<cr> "设置ctrl+D 关闭buffer"
