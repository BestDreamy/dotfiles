""" 基本配置
" 不与 Vi 兼容（采用 Vim 自己的操作命令）
set nocompatible
" 打开语法高亮。自动识别代码，使用多种颜色显示
syntax on

" 在底部显示，当前处于命令模式还是插入模式
set showmode

" 命令模式下，在底部显示，当前键入的指令
set showcmd

" 支持使用鼠标
set mouse=a

" 使用 utf-8 编码
set encoding=utf-8

" 启用256色
set t_Co=256

" 开启文件类型检查，并且载入与该类型对应的缩进规则
filetype indent on


""" 外观
" 显示行号
set number

" 显示光标所在的当前行的行号，其他行都为相对于该行的相对行号
set relativenumber

" 光标所在的当前行高亮
set cursorline

" 设置行宽，即一行显示多少个字符
set textwidth=80

" 是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示
set laststatus=2


""" 编辑
" Vim 需要记住多少次历史操作
set history=1000

" 如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块
set listchars=tab:»■,trail:■
set list

" 命令模式下，底部操作指令按下 Tab 键自动补全。
" 第一次按下 Tab，会显示所有匹配的操作指令的清单；第二次按下 Tab，会依次选择各个指令
set wildmenu
set wildmode=longest:list,full

" 设置缩进
set tabstop=4

"-----------------------------------------------------------------------------
" vundle
"-----------------------------------------------------------------------------
" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
" call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
" Plugin 'git://github.com/w0rp/ale.git'
" Plugin 'git://github.com/bling/vim-airline'
" Plugin 'git://github.com/SirVer/ultisnips'
" Plugin 'git://github.com/honza/vim-snippets'
" Plugin 'git://github.com/Shougo/neocomplcache.vim'
" Plugin 'git://github.com/junegunn/vim-easy-align'
" Plugin 'git://github.com/scrooloose/nerdcommenter'
" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本

"-----------------------------------------------------------------------------
" NERDTree
"-----------------------------------------------------------------------------
map <leader>ne :NERDTreeToggle<CR>
" 目录树窗口尺寸
let g:NERDTreeWinSize = 25
" 关闭nerd帮助
" let g:NERDTreeMinimalUI = 1
" 忽略以下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
" 显示隐藏文件
let NERDTreeShowHidden=1
" 修改默认箭头符号
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
augroup NERDTree
    au!
    autocmd vimenter * NERDTree     " vim启动时自动打开NERDTree
    " vim启动打开目录时自动打开NERDTree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    autocmd vimenter * NERDTreeFind 
    " 文件全部关闭时退出NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

wincmd w
autocmd VimEnter * wincmd w


"-----------------------------------------------------------------------------
" Add File Header
"-----------------------------------------------------------------------------
autocmd BufNewFile *.v,*.sv,*.cpp,*.c,*.h exec ":call AddHeader()"
autocmd BufWrite *.v,*.c call UpdateLastModifyTime()

function s:GetUserName()
    let user_name = "aric"
    return user_name
endfunction

function AddHeader()
	let line = getline(1)
  	let filename = expand("%")
	call append(0,  "// +FHDR----------------------------------------------------------------------------")
	call append(1,  "//                 Copyright (c) ".strftime("%Y ") )
	call append(2,  "//                 ALL RIGHTS aric's RISC-V")
	call append(3,  "// ---------------------------------------------------------------------------------")
	call append(4,  "// Filename      : ".filename)
	call append(5,  "// Author        : ".s:GetUserName())
	call append(6,  "// Created On    : ".strftime("%Y-%m-%d %H:%M"))
	call append(7,  "// Last Modified : ")
	call append(8,  "// ---------------------------------------------------------------------------------")
	call append(9,  "// Description   : ")
	call append(10, "//")
	call append(11, "//")
	call append(12, "// -FHDR----------------------------------------------------------------------------")
endfunction


"-----------------------------------------------------------------------------
" ModifyTime
"-----------------------------------------------------------------------------
function UpdateLastModifyTime()
	let line = getline(8)
	if line =~ '// Last Modified'
		call setline(8,"// Last Modified : " . strftime("%Y-%m-%d %H:%M"))
	endif
endfunction
