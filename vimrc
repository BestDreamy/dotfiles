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
