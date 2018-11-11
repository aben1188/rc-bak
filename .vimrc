" Vim启动时，若加上--startuptime参数，可查看其启动加载过程中每一步所耗费的 
" 详细时间以及耗费的总时间：
"     vim --startuptime 'vimStartupTime.txt' 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 以下为Vim插件管理工具vim-plug的设置(要求放在vimrc的最前面)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"..................................................
" vim-plug简要帮助(常用命令)
"..................................................
" :PlugInstall [name ...] [#threads]  - Install plugins
" :PlugUpdate [name ...] [#threads]	  - Install or update plugins
" :PlugClean[!]	                      - Remove unused directories (bang version will clean without prompt)
" :PlugUpgrade	                      - Upgrade vim-plug itself
" :PlugStatus	                      - Check the status of plugins
" :PlugDiff	                          - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]	  - Generate script for restoring the current snapshot of the plugins
"
" See also vim-plug official website: https://github.com/junegunn/vim-plug
"..................................................
"let s:vimdatapath=''
"if !(has('win32') || has('win64'))  |" Windows OS
"    s:vimdatapath='E:/LypData/MyData/Data/VimData/'
"else  |" other OS
"    s:vimdatapath='~/.vim/'
"endif

" Place the following code in your .vimrc before plug#begin() call, 
" it can automatically download the plug.vim and put it in the 'autoload' directory
"if empty(glob(s:vimdatapath . 'autoload/plug.vim'))
if (has('win32') || has('win64')) && empty(glob('~/vimfiles/autoload/plug.vim'))
    " Windows系统中，需通过手动在PowerShell中执行下列命令来下载安装vim-plug：
    "     md ~\vimfiles\autoload
    "     $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    "     (New-Object Net.WebClient).DownloadFile(
    "       $uri,
    "       $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "         '~\vimfiles\autoload\plug.vim'
    "       )
    "     )
    echoerr "Sorry, please manually install vim-plug first in Windows.
                \ For details, see here: https://github.com/junegunn/vim-plug."
    finish
elseif (has('unix') || has('mac')) && empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if (has('win32') || has('win64'))  " Windows OS
    let s:plugged='~/vimfiles/plugged'
else  " other OS
    let s:plugged='$VIM/plugged'
endif

call plug#begin(s:plugged)
"............................................................
" Keep Plug commands between plug#begin/end.
"............................................................

" Make sure you use single quotes

" Vim中文帮助，参见：https://github.com/yianwillis/vimcdoc
Plug 'yianwillis/vimcdoc'

" 安装高亮方案(色彩主题)Dracula
" `as` will install the plugin in a directory called 'dracula' instead of just 'vim'
" See also: https://github.com/dracula/dracula-theme
Plug 'dracula/vim', { 'as': 'dracula' }

"Plug 'L9'
"" Git plugin not hosted on GitHub
"Plug 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plug 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plug 'rstacruz/sparkup', {'rtp': 'vim'}
"" Install L9 and avoid a Naming conflict if you've already installed a
"" different version somewhere else.
"Plug 'ascenator/L9', {'name': 'newL9'}

Plug 'scrooloose/nerdtree'

" 下面的插件需先安装powerline、airline专用字体，安装方法：
" https://github.com/powerline/fonts#installation
" 如果不安装专用字体则显示会不正常
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 插件easymotion默认的快捷键
" <LEADER><LEADER>w：跳转到当前光标后的某个单词
" <LEADER><LEADER>b：跳转到当前光标前的某个单词
" <LEADER><LEADER>s：双向跳转到所输入的单个字符(单个字母或单个汉字)
" <LEADER><LEADER>j：跳转到光标下面的某行
" <LEADER><LEADER>k：跳转到光标上面的某行
Plug 'easymotion/vim-easymotion'

" 安装缓冲区管理工具bufferhint，非常好用(后面快捷键映射部分有简要说明)
Plug 'bsdelf/bufferhint'

" 安装多光标操作(多光标编辑操作、多行编辑操作)插件(类似于Sublime Text)
"     安装后插件已默认映射了快捷键：普通模式及可视模式下按<C-n>，可进入
"     多光标操作模式；以及在多光标操作模式下按<C-n>、<C-p>、<C-x>、<ESC>
"     可进行相应操作，具体参见下面列出的默认映射(Default mapping)：
"         let g:multi_cursor_start_word_key      = '<C-n>  |"已映射为<LEADER><LEADER>m'
"         let g:multi_cursor_select_all_word_key = '<A-n>'
"         let g:multi_cursor_start_key           = 'g<C-n>'
"         let g:multi_cursor_select_all_key      = 'g<A-n>'
"         let g:multi_cursor_next_key            ='<C-n>'
"         let g:multi_cursor_prev_key            ='<C-p>'
"         let g:multi_cursor_skip_key            ='<C-x>'
"         let g:multi_cursor_quit_key            ='<Esc>'
"     然后再将上述默认映射快捷键按自己的意愿进行修改。
"     使用说明：
"     1）<C-n>，按一次选中当前光标所在的单词，再按一次选中下一个同样的单词，
"        无论是选中第一个单词时，还是后面选中时，均还可按h、l左右调整选区；
"     2）<C-p>，在已经按了<C-n>的情况下，按<C-p>回退一次多选；
"     3）<C-x>，跳过当前选区，即不选择当前选区，自动跳到下一个；
"     4）选完后，则可同时对选区进行批量编辑了，比如按下c，可同时修改选区；
"     5）<ESC>，退出多光标操作模式。
" See also: https://github.com/terryma/vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

" 比ShowMarks更好用的标记显示、管理和使用工具
" Key mappings by default:
"     m1  |MarkologyEnable| Switches Markology on.
"     m0  |MarkologyDisable| Switches Markology off.
"     m!  |MarkologyToggle| Toggles Markology on and off.
"     m,  |MarkologyPlaceMarkToggle| Toggles the mark at the current line.
"     m+  |MarkologyPlaceMark| Places the next available mark on the current line.
"     m-  |MarkologyClearMark| Clears the mark at the current line.
"     m_  |MarkologyClearAll| Clears all marks in the current buffer.
"     m]  |MarkologyNextLocalMarkPos| Jumps to the next local mark.
"     m[  |MarkologyPrevLocalMarkPos| Jumps to the previous local mark.
"     m}  |MarkologyNextLocalMarkByAlpha| Jumps to the next local mark in lexicographical order.
"     m{  |MarkologyPrevLocalMarkByAlpha| Jumps to the previous local mark in lexicographical order.
"     m?  |MarkologyLocalList| List marks in |location-list| for the current window.
"     m^  |MarkologyQuickFix| List marks in |quickfix| window.
"     m*  |MarkologyLineHighlightToggle| Toggle line highlighting of (lower-case) marks.
" These default mappings can be overridden by default in your '~/.vimrc', by, for
" example:
"     nmap <silent> ;0 <Plug>MarkologyEnable
"     nmap <silent> ;1 <Plug>MarkologyDisable
"     nmap <silent> ;! <Plug>MarkologyToggle
"     nmap <silent> ;, <Plug>MarkologyPlaceMarkToggle
"     nmap <silent> ;+ <Plug>MarkologyPlaceMark
"     nmap <silent> ;- <Plug>MarkologyClearMark
"     nmap <silent> ;_ <Plug>MarkologyClearAll
"     nmap <silent> ;] <Plug>MarkologyNextLocalMarkPos
"     nmap <silent> ;[ <Plug>MarkologyPrevLocalMarkPos
"     nmap <silent> ;} <Plug>MarkologyNextLocalMarkByAlpha
"     nmap <silent> ;{ <Plug>MarkologyPrevLocalMarkByAlpha
"     nmap <silent> ;? <Plug>MarkologyLocationList
"     nmap <silent> ;~ <Plug>MarkologyQuickFix
" See also: https://github.com/jeetsukumaran/vim-markology/blob/master/doc/markology.txt
Plug 'jeetsukumaran/vim-markology'

" Surround.vim is all about 'surroundings': parentheses, brackets,
" quotes, XML tags, and more. The plugin provides mappings to easily
" delete, change and add such surroundings in pairs.
" For example, \"Hello world!":
"     cs"': 'Hello world!'
"     cs'<q>: <q>Hello world!</q>
"     cst": \"Hello world!"  "t: tag
"     ds".: Hello world!
" Now with the cursor on \"Hello",
"     ysiw]: [Hello] world!  "iw is a text object
" Let's make that braces and add some space (use } instead of { for no space):
"     cs]{: { Hello } world!
" Now wrap the entire line in parentheses:
"     yssb or yss): ({ Hello } world!)
" Revert to the original text:
"     ds{ds): Hello world!
" Emphasize hello:
"     ysiw<em>: <em>Hello</em> world!
" Visual mode: Press a capital V (for linewise visual mode) followed by:
"     S<p class="important">:
"         <p class="important">
"           <em>Hello</em> world!
"         </p>
" The . command will work with ds, cs, and yss if you install repeat.vim.
" See also: https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
" By default,  the . command after a plugin map, only repeated the last 
" native command inside that map, rather than the map as a whole. 
" Repeat.vim remaps . in a way that plugins can tap into it.
" See also: https://github.com/tpope/vim-repeat
Plug 'tpope/vim-repeat'
" Abolish.vim: easily search for, substitute, and abbreviate multiple 
" variants of a word.
" See also: https://github.com/tpope/vim-abolish
Plug 'tpope/vim-abolish'

" 在vim里使用git命令
Plug 'tpope/vim-fugitive'
" vim-easygit：轻量级git wrapper插件，拥有fugitive的所有功能，同时解决其
" 难以扩展的问题，参见：https://github.com/chemzqm/vim-easygit/
"Plug 'neoclide/vim-easygit'

" git提交记录浏览器
" 注：该插件必须先安装vim-fugitive才有效
" Commands
"     :GV to open commit browser
"         You can pass git log options to the command, e.g. :GV -S foobar.
"     :GV! will only list commits that affected the current file
"     :GV? fills the location list with the revisions of the current file
"     NOTE :GV or :GV? can be used in visual mode to track the changes in
"          the selected lines.
" Mappings
"     o or <cr> on a commit to display the content of it
"     o or <cr> on commits to display the diff in the range
"     O opens a new tab instead
"     gb for :Gbrowse
"     ]] and [[ to move between commits
"     . to start command-line with :Git [CURSOR] SHA à la fugitive
"     q to close
" See also: https://github.com/junegunn/gv.vim
Plug 'junegunn/gv.vim'

" 在vim的gutter(即sign column)中显示git文件变动标记
" See also: https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" LeaderF插件需要Python支持
"Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" Jump to any location specified by two characters: s{char}{char}
" See also: https://github.com/justinmk/vim-sneak
Plug 'justinmk/vim-sneak'
" label-mode for a minimalist alternative to EasyMotion:
let g:sneak#label = 1

" 堪称完美的注释解决方案，一个快捷键搞定注释问题，喜欢配置的可以使用
" nerdcommenter：https://github.com/scrooloose/nerdcommenter
" A stupid comment plugin made for people can't remember so many mappings:)
" You only need to remember one mapping for comment: <LEADER>c
"     [count]<LEADER>cc: Toggle comment of count(default current line) lines.
"     <LEADER>cip: Toggle comment of a block. Yes, it's a motion mapping, 
"                  ip could be any motion object.
"     V***<LEADER>c: Select a block and toggle comment
" More productive:
"    1. You can use . to repeat your last comment command, no need vim-repeat. 
"    2. If you have emmet-vim, the plugin would use emmet comment function for 
"       comment toggle of tags in html/xml/xhtml files
Plug 'neoclide/mycomment.vim'
"Plug 'aben1188/mycomment.vim'

" 对齐插件，功能强大，参见：https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" vim-easyclip: Simplified clipboard functionality for Vim
" EasyClip is a plugin for Vim which contains a collection of clipboard related
" functionality with the goal of making using the clipboard in Vim simpler and
" more intuitive without losing any of its power. A good starting point for the
" motivation behind this Vim plugin can be found in Drew Neil's post
"     Registers - The Good, the Bad, and the Ugly Parts
"     (http://vimcasts.org/blog/2013/11/registers-the-good-the-bad-and-the-ugly-parts/,
"     Also can reference here: https://github.com/nelstrom/vim-cutlass)
" Default Key Mappings
"     d<motion> - Delete over the given motion and do not change clipboard
"     dd - Delete the line and do not change clipboard
"     D - Delete from cursor to the end of the line and do not change clipboard
"     dD - Delete the contents of line except the newline character (that is,
"          make it blank) and do not change clipboard
"     x - Delete the character under cursor and do not change clipboard
"     s - Delete the character under cursor then enter insert mode and do not change clipboard
"     S - Delete the line under cursor then enter insert mode and do not change clipboard
"     c<motion> - Enter insert mode over top the given area and do not change clipboard
"     cc - Enter insert mode over top the current line and do not change clipboard
"     C - Enter insert mode from cursor to the end of the line and do not change clipboard
"     p - Paste from specified register. Inserts after current line if text is multiline,
"         after current character if text is non-multiline. Leaves cursor at end of pasted text.
"     P - Same as p except inserts text before current line/character
"     <leader>p - Same as p except does not auto-format text. This is only relevant
"          if the auto-format option is enabled
"     <leader>P - Same as P except does not auto-format text. This is only relevant
"          if the auto-format option is enabled
"     gp - Same as p but preserves the current cursor position
"     gP - Same as P but preserves the current cursor position
"     g<leader>P - Same as <leader>P but preserves the current cursor position
"     g<leader>p - Same as <leader>p but preserves the current cursor position
"     m<motion> - Delete over the given motion and copy text to clipboard
"     mm - Delete the current line and copy text to clipboard
"     NOTE  M is NOT mapped by default. If you want it, include the following in your .vimrc:
"     nmap M <Plug>MoveMotionEndOfLinePlug
"     <CTRL-P> - Rotate the previous paste forward in yank buffer. Note that this binding
"          will only work if executed immediately after a paste
"     <CTRL-N> - Rotate the previous paste backward in yank buffer. Note that this binding
"          will only work if executed immediately after a paste
"     [y - Go backward in the yank buffer. This can be executed at any time to modify order
"          of yanks in the yank buffer (though I would recommend just using <CTRL-P> instead)
"     ]y - Go forward in the yank buffer. This can be executed at any time to modify order
"          of yanks in the yank buffer (though I would recommend just using <CTRL-N> instead)
"     Y - Copy text from cursor position to the end of line to the clipboard
"     NOTE  When the option g:EasyClipUseSubstituteDefaults is enabled, the following mappings are added:
"     s<motion> - Substitute over the given motion with specified register (or default register
"          if unspecified). Note that this only applies if the g:EasyClipUseSubstituteDefaults option is set.
"     ss - Substitute over the current line with specified register (or default register if unspecified).
"          Note that this only applies if the g:EasyClipUseSubstituteDefaults option is set.
"     gs - Same as s but preserves the current cursor position.
" Custom Yanks
" If you have custom yanks that occur in your vimrc or elsewhere and would like them to be included
" in the yank history, you should call the EasyClip#Yank(). For example, to add a binding to yank
" the current file name you could add the following to your .vimrc:
"     nnoremap <leader>yf :call EasyClip#Yank(expand('%'))<cr>
" Another way to do the above (which is necessary if you don't control the yank yourself), is to do the following:
"     nnoremap <leader>yf :EasyClipBeforeYank<cr>:let @*=expand('%')<cr>:EasyClipOnYanksChanged<cr>
" Also, worth noting is the Paste command which takes an index and pastes the yank at that index.
" For example, executing :Paste 0 is equivalent to p, :Paste 1 is equivalent to "1p, etc.
" For use within scripting, there is also the corresponding method EasyClip#PasteIndex which
" like the command takes an index as parameter. For the P equivalent, there is also
" a PasteBefore command and EasyClip#PasteIndexBefore method.
" Another method worth noting is EasyClipGetYankAtIndex which returns the text
" for the yank at a given index.
" See also: https://github.com/svermeulen/vim-easyclip
"Plug 'svermeulen/vim-easyclip'

" 多寄存器统一可视化管理工具
" When you paste the copied message and you need change it for another message
" you copied before, it will be very easy to change. You just need to do CTRL+P
" or CTRL + N to change the message.
" Display the contents of the yankring:
"     :YRShow   【注：映射为<LEADER>yr】
" 将yankring的历史文件夹移到~/.vim
"     let g:yankring_history_dir = $HOME.'/.vim/'
" 修改历史文件名
"     let g:yankring_history_file = '.yankring_history'
" 选择上一个复制的文本
"     let g:yankring_replace_n_pkey = '<LEADER>ym'
" 选择下一个复制的文本
"     let g:yankring_replace_n_pkey = '<LEADER>yn'
" Get help:
"     :h yankring.txt
"     :h yankring-tutorial
" See also: https://github.com/vim-scripts/YankRing.vim
"Plug 'vim-scripts/YankRing.vim'

" 调用系统的全文搜索程序ag进行全文搜索
" COMMANDS
"     :Ags [{file-type}] [{options}] {pattern} [{directory}]
"         Runs a recursive search in {directory} for
"         {pattern}. If {pattern} is not specified it
"         will be set to the word under cursor. The
"         {directory} will default to the current directory.
"         {options} and {file-type} are passed directly to
"         the ag executable. In addition a few other options,
"         as set in |ags_agargs|, will be specified for display purposes.
"         For example
"         :Ags --js Reducer
"     :AgsAdd [{file-type}] [{options}] {pattern} [{directory}]
"         Like |:Ags| but the matches are appended to the
"         current search results.
"     :AgsLast
"         Runs the last search. This could be used after entering
"         edit mode to return to view mode.
"     :AgsQuit
"         Closes the search results window whether in edit or
"         view mode.
"     :AgsEditSearchResults
"         Enters edit mode if the search results is open in
"         view mode.
"     :AgsShowLastCommand
"         Displays the command for the last search.
"MAPPINGS
"    Once inside the search results window:~
"        p    - navigate file paths forward
"        P    - navigate files paths backwards
"        r    - navigate results forward
"        R    - navigate results backwards
"        a    - display the file path for current results
"        c    - copy to clipboard the file path for current results
"        E    - enter edit mode
"        oa   - open file above the results window
"        ob   - open file below the results window
"        ol   - open file to the left of the results window
"        or   - open file to the right of the results window
"        os   - open file in the results window
"        ou   - open file in a previously opened window
"        xu   - open file in a previously opened window and close the search results
"        <CR> - open file in a previously opened window
"        q    - close the search results window
"        u    - displays these key mappings
" See also: https://github.com/gabesoft/vim-ags/blob/master/doc/ags.txt
if !(has('win32') || has('win64')) && executable('ag')
    Plug 'gabesoft/vim-ags'
endif

" 自动扩展选择插件
" vim-expand-region is a Vim plugin that allows you to visually select increasingly
" larger regions of text using the same key combination.
" Press + to expand the visual selection and _ to shrink it.
" mapping: Customize the key mapping if you don't like the default.
"     map K <Plug>(expand_region_expand)
"     map J <Plug>(expand_region_shrink)
" See also: https://github.com/terryma/vim-expand-region
Plug 'terryma/vim-expand-region'

" incsearch.vim incrementally highlights ALL pattern matches unlike default 'incsearch'.
" See also: https://github.com/haya14busa/incsearch.vim
Plug 'haya14busa/incsearch.vim'

" Adds Icons to Your Plugins
" Supports plugins such as NERDTree, vim-airline, CtrlP, powerline, denite, unite,
" lightline.vim, vim-startify, vimfiler, vim-workspace and flagship.
" NOTE NOTE  Always load the vim-devicons as the very last one NOTE NOTE
" See also: https://github.com/ryanoasis/vim-devicons
Plug 'ryanoasis/vim-devicons'

"............................................................
" All of your Plugins must be added before the following line
"............................................................
call plug#end()"

"..................................................
" vim-plug简要帮助(常用命令)
"..................................................
" :PlugInstall [name ...] [#threads]  - Install plugins
" :PlugUpdate [name ...] [#threads]	  - Install or update plugins

" :PlugUpgrade	                      - Upgrade vim-plug itself
" :PlugStatus	                      - Check the status of plugins
" :PlugDiff	                          - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]	  - Generate script for restoring the current snapshot of the plugins
"
" see also vim-plug official website: https://github.com/junegunn/vim-plug
"..................................................

" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 以上为Vim插件管理工具vim-plug的设置(要求放在vimrc的最前面)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


if (has('win32') || has('win64'))  "Windows OS
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " 以下为Windows中Vim刚安装后_vimrc未作任何修改之前的所有初始设置
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set diffexpr=MyDiff()
    function MyDiff()
      let opt='-a --binary '
      if &diffopt=~ 'icase' | let opt=opt . '-i ' | endif
      if &diffopt=~ 'iwhite' | let opt=opt . '-b ' | endif
      let arg1=v:fname_in
      if arg1=~ ' ' | let arg1='"' . arg1 . '"' | endif
      let arg2=v:fname_new
      if arg2=~ ' ' | let arg2='"' . arg2 . '"' | endif
      let arg3=v:fname_out
      if arg3=~ ' ' | let arg3='"' . arg3 . '"' | endif
      let eq=''
      if $VIMRUNTIME=~ ' '
        if &sh=~ '\<cmd'
          let cmd='""' . $VIMRUNTIME . '\diff"'
          let eq='"'
        else
          let cmd=substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd=$VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " 以上为Windows中Vim刚安装后_vimrc未作任何修改之前的所有初始设置
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
else  " other OS
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " 以下为CentOS默认安装的vim7.4的vimrc文件(/etc/vimrc)未作任何修改之前的
    " 所有初始设置
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
       set fileencodings=ucs-bom,utf-8,latin1
    endif

    set nocompatible	" Use Vim defaults (much better!)
    set backspace=indent,eol,start		" allow backspacing over everything in insert mode
    "set ai			" always set autoindenting on
    "set backup		" keep a backup file
    set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                " than 50 lines of registers
    set history=50		" keep 50 lines of command line history
    set ruler		" show the cursor position all the time

    " Only do this part when compiled with support for autocommands
    if has("autocmd")
      augroup redhat
      autocmd!
      " In text files, always limit the width of text to 78 characters
      " autocmd BufRead *.txt set tw=78
      " When editing a file, always jump to the last cursor position
      autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
      " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
      autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
      " start with spec file template
      autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
      augroup END
    endif

    if has("cscope") && filereadable("/usr/bin/cscope")
       set csprg=/usr/bin/cscope
       set csto=0
       set cst
       set nocsverb
       " add any database in current directory
       if filereadable("cscope.out")
          cs add $PWD/cscope.out
       " else add database pointed to by environment
       elseif $CSCOPE_DB != ""
          cs add $CSCOPE_DB
       endif
       set csverb
    endif

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if &t_Co > 2 || has("gui_running")
        syntax on
        set hlsearch
    endif

    filetype plugin on

    if &term=="xterm"
        set t_Co=8
        set t_Sb=[4%dm
        set t_Sf=[3%dm
    endif

    " Don't wake up system with blinking cursor:
    " http://www.linuxpowertop.org/known.php
    let &guicursor = &guicursor . ',a:blinkon0'
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " 以上为CentOS默认安装的vim7.4的vimrc文件(/etc/vimrc)
    " 未作任何修改之前的所有初始设置
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 将下列内容加入到云服务器vimrc文件的末尾
" （CentOS默认安装的vim的vimrc文件路径：/etc/vimrc）
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE 为了在跨系统平台使用本vimrc文件时尽可能少地修改，下面的自定义设置
"      可能与系统自带的vimrc中的设置存在部分重复

" 注意：在vsvim中，语句后面“|"”的注释写法会导致出错；而在ideavim中，若去除语句后面的“|”，
"       而直接写成“"”，也会导致出错。因此，最好是不要在语句后面写注释。

" 保存vimrc文件后立即生效，而无需关闭后再打开vim才生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC  |" 经常出问题，有时还不起作用

" Use Vim defaults (much better!)
set nocompatible

if !isdirectory(expand("~/.vim/"))
    call mkdir($HOME . "/.vim")
endif
"if !isdirectory(expand("~/.config/nvim/"))
    "call mkdir($HOME . '/.config/nvim', 'p')
"endif

" 判断操作系统
" if has('win32') || has('win64')  |" Windows
"     ...
" elseif has('unix')               |" Unix/Linux
"     ...
" elseif has('mac')                |" MacOS
"     ...
" endif
if has('win32') || has('win64')
    " 设定vim的运行时查找插件等文件时的目录，可以定义多个目录，所以使用+=运算符
    " 注意：runtimepath也可简写为rtp
    set runtimepath+=$HOME/.vim

    " 选择文本渲染器并设置其选项，选项取决于渲染器(目前只有directx这一个
    " 可选的渲染器)。Vim使用DirectX(DirectWrite)绘制文本，这比缺省的GDI
    " 能画出更好看的字形。
    " 注：要求encoding选项设置为utf-8，并且只有MS-Windows Vista或更新的
    " 版本才能工作。
    set renderoptions=type:directx,renmode:5,taamode:1
else
    " If installed fzf using git, enable it inside Vim by adding the
    " directory to &runtimepath
    " See also: https://github.com/junegunn/fzf
    " 注意：rtp即runtimepath的简写
    set rtp+=~/.fzf

    " 指定在Vim中执行外部命令(!command或:!command)时所用的shell
    " 注意：shell名称与其参数之间的空格必须加上反斜杠\进行转义，参数-i表示以交互模
    " 式使用zsh（-i为zsh的参数）
    " 注：查询当前所使用的shell，可在shell中输入shell的预定义变量$0查看，也可执行
    "     ps -p $$查看；查询shell所在的路径可使用cat /etc/shells查看
    "set shell=/bin/zsh\ -i  |" 貌似不能放在vimrc中，否则出现奇怪的问题

    "" -- tmux integration ----------------------------------------------------------
    "" make arrow keys, home/end/pgup/pgdown, and function keys work when inside tmux
    "if exists('$TMUX') && (system("tmux show-options -wg xterm-keys | cut -d' ' -f2") =~ '^on')
    "    " tmux will send xterm-style keys when its xterm-keys option is on
    "    " add 'setw -g xterm-keys on' to your ~/.tmux.conf
    "    execute "set <xUp>=\e[1;*A"
    "    execute "set <xDown>=\e[1;*B"
    "    execute "set <xRight>=\e[1;*C"
    "    execute "set <xLeft>=\e[1;*D"
    "    execute "set <xHome>=\e[1;*H"
    "    execute "set <xEnd>=\e[1;*F"
    "    execute "set <Insert>=\e[2;*~"
    "    execute "set <Delete>=\e[3;*~"
    "    execute "set <PageUp>=\e[5;*~"
    "    execute "set <PageDown>=\e[6;*~"
    "    execute "set <xF1>=\e[1;*P"
    "    execute "set <xF2>=\e[1;*Q"
    "    execute "set <xF3>=\e[1;*R"
    "    execute "set <xF4>=\e[1;*S"
    "    execute "set <F5>=\e[15;*~"
    "    execute "set <F6>=\e[17;*~"
    "    execute "set <F7>=\e[18;*~"
    "    execute "set <F8>=\e[19;*~"
    "    execute "set <F9>=\e[20;*~"
    "    execute "set <F10>=\e[21;*~"
    "    execute "set <F11>=\e[23;*~"
    "    execute "set <F12>=\e[24;*~"
    "endif
endif

set runtimepath+=$VIMRUNTIME/plugin

" ru[ntime][!] {file}：从’runtimepath’指定的目录里查找{file}。从匹配的文件
"     里读取Ex命令。如果没有匹配的文件，不报错。如果使用了[!]，所有找到的
"     任何文件都被执行。否则，只执行第一个找到的文件。
" matchit.vim：这是Vim自带的插件，支持任何语言的%跳转。正常的%跳转只支持
"     {}风格的语言。该插件使"%"命令可在两个对应的HTML标记(开始标签与结束标签)、
"     Vim脚本的if/else/endif等匹配点之间跳转。这非常有用，但它不向后兼容，
"     所以默认的情况下它不会被激活(加载)，而需要手动加载它。
runtime macros/matchit.vim

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" 设置光标不闪烁
let &guicursor = &guicursor . ',a:blinkon0'

" 设置中文帮助
" 注：必须先安装中文帮助，否则无效；安装方式参考vimcdoc的github仓库：
"     https://github.com/yianwillis/vimcdoc
"    （Windows系统也可直接下载中文帮助安装包安装在如C:\Program Files\
"    Vim\vim80目录中）
set helplang=cn

" 搜索时一输入字符即开始自动搜索，而不是回车后才开始
set incsearch    " search as you type

" Sets how many lines of history VIM has to remember
" 命令的历史和最近的搜索模式的历史会被记住，本选项决定每个历史分别记住多少项
set history=1000

" 文件在Vim外被改动时自动重新读入；但文件在外部被删除则不重新读入
set autoread

" 光标上下移动时，屏幕上保留的最少屏幕行数
set scrolloff=1

" 增强模式命令行补全，按下wildchar(默认<Tab>)启动补全
set wildmenu

" Height of the command bar
"set cmdheight=2
" 命令行窗口高度(屏幕行数)
set cmdwinheight=20

" A buffer becomes hidden when it is abandoned
set hidden

" 使指定的左右移动光标的键在行首或行尾可以移到前一行或者后一行。
" 如果设置这些下面这些字符，则相应的键具有此功能:
"     字符  键       模式
"     b     <BS>     普通和可视
"     s     <Space>  普通和可视
"     h     'h'      普通和可视 (不建议)
"     l     'l'      普通和可视 (不建议)
"     <     <Left>   普通和可视
"     >     <Right>  普通和可视
"     ~     '~'      普通
"     [     <Left>   插入和替换
"     ]     <Right>  插入和替换
" 例如：:set ww=<,>,[,]，只允许光标键进行回绕。
" 注意：
"     1）如果设置了h、l，则和删除、改变操作符一起使用时，<EOL>也被看作一个字符。
"        这使得光标跨过行尾时，'3h'和'3dh'效果不同。这也适用于'x'和'X'，因为它
"        们分别和'dl'以及'dh'相同。如果这么用，你可能想用映射':map <BS> X'来使
"        退格键删除光标之前的字符。
"     2）如果设置了’l’，位于行尾时如果在操作符之后使用它，不会移动到下一行。这
"        样'dl'、'cl'、'yl' 等都能正常工作。
" 该选项Vim的默认值为”b,s“
set whichwrap=<,>,[,],h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=1

" No annoying sound on errors
set noerrorbells
set novisualbell
if !has('gui_running')
    set t_vb=
endif
set timeoutlen=800

" don't add two spaces after ., ?, !
set nojoinspaces

" 定义使用<C-A>和<C-X>(Windows下已分别改为<C-I>和<C-D>)命令加减数值时使用的
" 基底：alpha，如果包含，单个字母会被递增和递减，这可用于使用字母索引的列表
" a)、b)等等；octal，如果包含，零开始的数值认为是八进制，如在"007"上用C-A
" 得到"010"；hex，如果包含，"0x"或"0X"开头的数值认为是十六进制，如在"0x100"
" 上用C-X得到"0x0ff"。以1-9开始的数值总被认为是十进制的。octal与hex默认包含。
set nrformats+=alpha
set nrformats-=octal
 
" Default Colors for CursorLine
"highlight CursorLineNr guifg=red

" 这一行跟某未知脚本有冲突，放到
" colorshceme文件(desert.vim)中才解决
"highlight LineNr guifg=Brown

" 高亮显示光标所在行
set cursorline
" 高亮显示光标所在列【简写：设置 cuc；取消 nocuc】
"set cursorcolumn

" Change Color when entering Insert Mode
" au[tocmd] [group] {event} {pat} [nested] {cmd}：把{cmd}加到Vim在匹配{pat}
" 模式的文件执行{event}事件时自动执行的命令列表中。Vim总把{cmd}加到已有的
" 自动命令之后，这样保证自动命令的执行顺序与其定义的顺序相同。
autocmd InsertEnter * highlight LineNr guifg=Red
autocmd InsertEnter * set cursorcolumn
"autocmd InsertEnter * highlight statusline guifg=Red

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight LineNr guifg=#909194
autocmd InsertLeave * set nocursorcolumn
"autocmd InsertLeave * highlight statusline guifg=NONE

" 下列移动命令移动光标时，不回到行首第一个非空白字符,
" 而是尽量保持在同一列上(如果可能的话)：
" C-B、C-F、C-D、C-U、G、H、M、L、gg、d、<<、>>、带计数的%、
" 缓冲区改变命令(CTRL-^、:bnext、:bNext等)、:25、:+、:-等
set nostartofline

" 配置多语言环境，解决中文乱码问题
if has("multi_byte")
    " Vim内部使用的编码 
    set encoding=utf-8
    " Windows下的gVim其键盘输入和屏幕显示均不依赖termencoding
    set termencoding=utf-8
    " 自动排版时的格式选项
    " m：表示可以在任何值高于255的多字节字符上分行。这对亚洲文本尤其有用，因为
    "    每个字符都是单独的单位
    " M：在连接行时，不要在多字节字符之前或之后插入空格。优先于B标志位
    " B：在连接行时，不要在两个多字节字符之间插入空格。有M标志位时无效
    set formatoptions+=mM
    " 读文件时Vim自动侦测文件编码方式的编码列表项，
    " 下面列表项中的prc(等同于chinese)是Windows下的cp936、Unix下的euc-cn的别名
    " （EUC：Extended Unix Code；EUC-CN是GB2312的别名）；
    " taiwan是big5的别名；japan、korea分别是日本、韩国常用的ANSI字符编码别名；
    " 之所以不写cp936或euc-cn，而写prc（或Chinese），是因为跨平台性更好
    set fileencodings=ucs-bom,utf-8,prc,gb18030,taiwan,japan,korea,latin1
    " 处理CJK东亚二义性宽度字符类 (East Asian Width Class Ambiguous)
    " 例如，欧元符号、注册记号、版权记号、希腊字母、西里尔字母等等
    if v:lang=~? '^/(zh/)/|/(ja/)/|/(ko/)'
        set ambiwidth=double
    endif
    if has("win32") || has("win64")
        " 解决Windows版的菜单乱码问题
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        " 解决Windows版console输出乱码问题
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" 改配色，默认的白色太过刺眼
" colorscheme文件位于vim安装目录下的colors文件夹中，比如：
" C:\Program Files (x86)\Vim\vim80\colors\dracula.vim
"colorscheme desert 
"colorscheme morning
"colorscheme evening
colorscheme dracula  |" 通过vim-plug安装，或手动将dracula.vim复制到colors目录中

" 使用色彩方案(即高亮方案)的Todo高亮组来高亮指定的关键词，如NOTE、WARNING等
autocmd ColorScheme * call matchadd('Todo', '\W\zs\(Note:\|Notice:\|Warning:\|
        \Danger:\|NOTE\|NOTICE\|WARNING\|DANGER\|注意：\|注：\)')

" Find out to which highlight-group a particular keyword/symbol belongs
" :com[mand][!] [{attr}...] {cmd} {rep}
"     定义一个用户命令。命令的名字是 {cmd}，而替换的文本是{rep}。该命令的属性
"     (参考下面)是 {attr}。如果该命令已存在，报错，除非已经指定了一个 !，这种
"     情况下命令被重定义。
"     Note: 使用":command!"来覆盖现存的用户命令是个坏主意。这很可能使用户不明
"           白自己定义的命令为什么不起作用。
command! Wcolor echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
            \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") .
            \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .
            \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")

" 根据官方文档的说明，下面的filetype设置必须放在syntax on语句之前，
" 才能使得syntax on语句打开的语法高亮效果生效
" 命令                         检测    plugin  indent
" :filetype on                 打开    未改变  未改变
" :filetype off                关闭    未改变  未改变
" :filetype plugin on          打开    打开    未改变
" :filetype plugin off         未改变  关闭    未改变
" :filetype indent on          打开    未改变  打开
" :filetype indent off         未改变  未改变  关闭
" :filetype plugin indent on   打开    打开    打开
" :filetype plugin indent off  未改变  关闭    关闭
"filetype on
"filetype plugin on
" 下面语句的含义是：为特定的文件类型加载相应的插件和缩进文件
filetype plugin indent on
" 打开语法高亮功能(dracula颜色方案需要打开)
" syntax on会覆盖已有的颜色，而syntax enable会保持当前已有的色彩设置，
" 只设置没有设置过的组；这样不管在使用此命令的前后，都可设置自己喜欢的颜色。
syntax on
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Specify the behavior when switching between buffers
" try和endtry：改变try和endtry之间命令的错误处理，包括所有
" 执行的内容、source里的命令、函数调用、自动命令的激活等。
" cat[ch] /{pattern}/：匹配{pattern}的例外抛出时，如果它没有被前一个
" catch捕获，则执行本语句之后的命令，直到遇到和本catch处于同一try块的
" 下一个catch、finally或者endtry为止。否则，这些命令被跳过。
" 若没有提供{pattern}，所有的错误都会被捕获。
try
    " 控制缓冲区切换的行为；
    " useopen，跳到第一个打开的包含指定缓冲区的窗口(如果有的话)；
    " usetab，类似于useopen，但也考虑其它标签页里的窗口；
    " split，在载入用于在quickfix命令里显示错误的缓冲区之前分割当前窗口；
    " newtab，类似于split，但打开新标签页，若和split同时存在，本值优先。
    set switchbuf=useopen,usetab,newtab
    " 默认值为1，即多于一个标签页才显示标签栏
    "set showtabline=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
" viminfo中的%参数：保存和恢复缓冲区列表；Vim启动时若有文件名参数，
" 缓冲区列表不予恢复，若没有文件名参数，缓冲区列表从viminfo文件里恢复；
" 没有文件名的缓冲区和帮助文件的缓冲区不会写入viminfo文件；若后跟数值，
" 该数值指定保存的缓冲区的最大个数，若没跟数值，则保存所有的缓冲区。
" se[t] {option}^={value}：把{value}乘到数值选项里，或者附加到字符串选
" 项之前。若选项是逗号分隔的列表，除非原值为空，否则会自动加上一个逗号。
set viminfo^=%
" !表示保存和恢复大写字母开头，并且不包含小写字母的全局变量。
" 这样，保存 'KEEPTHIS' 和 'K_L_M'，但不保存 'KeepThis' 和
" _K_L_M"。不能正确读回嵌套的列表和字典值，它们变成空值。
"set viminfo^=!

" 添加行号
set number
" 使用相对行号
set relativenumber

if has('gui_running')
    " 设置窗口启动位置：x轴 y轴【左上角为：x=0 y=0】
    "winpos 930 675
    " 设置窗口大小：行和列
    "let windowlines=25
    "let windowcolumns=86
    "set lines=25
    "set comlumns=86
    "set lines=&windowlines columns=&windowcolumns
    "set lines=25 columns=86

    " Toggle Menu and Toolbar 切换有无菜单栏、工具栏和滚动条
    set guioptions-=m  |" m，菜单栏
    set guioptions-=T  |" T，工具栏
    set guioptions-=r  |" r，右边滚动条
    set guioptions-=L  |" L，垂直分割窗口时左边滚动条
    " =~#：=~，匹配模式运算符，#大小写敏感，即使已设置了ignorecase
    " <Bar>，即Ex命令分隔符|；\为续行符(长行接续符)
    map <F4> :if &guioptions=~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <Bar>
            \set guioptions-=r <Bar>
            \set guioptions-=L <Bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
            \set guioptions+=r <Bar>
            \set guioptions+=L <Bar>
        \endif<CR>

    " 一键切换窗口最大化、还原窗口大小
    map <F11> :call ToggleWindowSize()<CR>

    " VimEnter事件(做完所有启动任务，包括载入.vimrc文件、执行"-c cmd"参数、
    " 创建所有窗口并在其中载入所有缓冲区)之后，最大化窗口。
    " simalt命令告诉Vim(winaltkeys不要设置为yes)虚拟一个Windows风格的Alt按键行为，
    " 这样可以用它来映射Alt组合键(或者任何其它键)来产生标准的Windows操作，以便于
    " 在Windows中即使禁用Alt-{key}访问菜单的标准方法(winaltkeys设置为no)，
    " 也能通过simalt来模拟访问菜单；其中，~在simalt命令中代表空格<Space>。
    autocmd VimEnter * simalt ~x
    let s:window_max_status=1

    " 可视模式下选择文本时即使不进行复制、删除等操作，
    " 也自动将选择文本保存到"*寄存器(即系统剪贴板寄存器，
    " windows系统中，与"+寄存器等同)，因此可少一个步骤
    "set guioptions+=a
    " 指定Vim窗口顶部每个标签页标签的内容 
    set guitablabel=%M\ %t
endif

" %默认匹配()、[]、{}，增加匹配<>和中文圆括号（）(即全角圆括号)
set matchpairs+=<:>,（:）

" Automatically write a file when leaving a modified buffer
"set autowrite
"set autowriteall
" 普通模式下当前缓冲区文本修改、退出插入模式、离开缓冲区、失去焦点时，自动保存文件
"autocmd TextChanged,InsertLeave * update
autocmd InsertLeave * update
autocmd BufLeave,FocusLost * wall

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 自动保存状态(自动保存、读取、执行session会话文件和view视图文件)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 会话：会话保存所有窗口的视图，外加全局设置。你可以保存会话，并在以后恢复之，
" 使得窗口的布局看起来一样。可以创建会话在不同的项目之间快速切换，切换时自动调
" 入上次在那个项目上工作的文件。

" 视图：会话记录储存整个Vim窗口外观。当只需要为某个窗口储存特性时，得用视图。
" 视图的用处在于你要以某种特定的方式编辑一个文件。例如，你以 ’number’ 选项显
" 示了行号，并定义了若干折叠。正如会话记录那样，你可以记住这一视图并在以后还
" 原回来。事实上，当你储存会话时，每个窗口的视图都储存了。

" 注意：会话记录储存了不少东西，但不储存标记位置，寄存器内容以及命令行历史记录
" 你需要利用Vim信息文件viminfo储存这些信息。

" 指定会话文件的保存路径和文件名(如果不提供文件名，会保存为Session.vim)
let s:sessionfile='~/.vim/session.vim'

"" sesstionoptions：改变mksession命令的效果。这是逗号分隔的单词列表，
"" 每个单词允许保存和恢复某种设置：curdir，当前目录；sesdir，将session
"" 会话文件所在的目录切换成当前目录
""set sessionoptions-=resize
""set sessionoptions+=sesdir
"set sessionoptions+=winpos,globals
"" mks[ession][!] [file]：写入一个Vim脚本，该脚本能够恢复当前的编辑会话；
"" 如果包含[!]，已有的文件会被覆盖。若不提供[file]，默认保存为"session.vim"。
"" 注意：若提供[file]，不能加.vim扩展名后缀，否则出错(vim会自动加)
"autocmd VimLeave * mksession!
"autocmd VimEnter * :call s:ReadSession()
" do not store global and local values in a session
set sessionoptions-=options
"set sessionoptions-=curdir
"set sessionoptions+=sesdir
" do not store empty windows(avoid nerdtree problem)
set sessionoptions-=blank
" slash：文件名里的反斜杠被替换成正斜杠
" unix：使用Unix换行格式(单个<NL>)，即使在Windows或DOS上也是如此
" slash和unix可用于Windows系统中，如果要和Unix共享会话文件的话。Unix版本的
" Vim不能执行dos格式的脚本，但是Windows版本的Vim可以执行unix版本的脚本。
set sessionoptions+=slash,unix

" auto change session in heavy GUI
if has('gui_running')
    autocmd VimEnter * nested :call s:loadSession()
    autocmd VimLeave * :call s:updateSession()
endif

" save viminfo
" 如果你退出Vim以后又再次启动，通常你会丢失许多信息。viminfo文件可以用来记住
" 这些信息，从而允许你继续上次退出的编辑。(用户手册 21.3 一节有所介绍)
" viminfo文件用来保存:
"     - 命令行历史。
"     - 搜索字符串历史。
"     - 输入行历史。
"     - 非空的寄存器内容。
"     - 多个文件的位置标记。
"     - 文件标记，指向文件的位置。
"     - 最近搜索/替换的模式 (适用于 ’n’ 和 ’&’)。
"     - 缓冲区列表。
"     - 全局变量。
" 注意：如果 +viminfo 特性在编译时关闭，不支持 viminfo 文件。
" 与此同时，你可以使用会话文件。差别是，viminfo 文件并不依赖于你工作的内容。通
" 常，只有一个 viminfo 文件。而会话文件用来保存某个编辑会话的状态。你可以保存多
" 个会话文件，每个针对一个你工作的项目。viminfo 和会话文件一起可以用来有效的进入
" Vim 并直接从你希望的设置开始工作。
"if !isdirectory(expand("~/.vim/viminfo"))
   "call mkdir($HOME . '/.vim/viminfo', 'p')
"endif
set viminfo+=n~/.vim/viminfo

" save view records
" slash:文件名里的反斜杠被替换成正斜杠
" unix：使用Unix换行格式(单个<NL>)，即使在Windows或DOS上也是如此
" slash和unix可用于Windows系统中，如果要和Unix共享会话文件的话。Unix版本的
" Vim不能执行dos格式的脚本，但是Windows版本的Vim可以执行unix版本的脚本。
set viewoptions+=slash,unix
"exe 'set viewdir='. escape($VimStateSavedFiles, ' ') . '/view'
if !isdirectory(expand('~/.vim/viewfiles'))
    call mkdir($HOME . '/.vim/viewfiles', 'p')
endif
set viewdir=~/.vim/viewfiles

autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
"set nobackup
"set nowb
"set noswapfile
"
" Swap files are necessary when crash recovery
if !isdirectory(expand('~/.vim/swapfiles'))
    call mkdir($HOME . '/.vim/swapfiles', 'p')
endif
set dir=~/.vim/swapfiles//

" Persistent undo 持久化undo：文件关闭后再打开仍可进行撤销操作(即恢复上次操作)
set undofile
" maximum number of changes that can be undone
set undolevels=3000  " 默认值为1000，该值越大越消耗内存
" maximum number lines to save for undo on a buffer reload
"set undoreload=10000 " 此为默认设置，所以注销

if !isdirectory(expand('~/.vim/undofiles'))
    call mkdir($HOME . '/.vim/undofiles', 'p')
endif
set undodir=~/.vim/undofiles//

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
" 插入模式中插入<Tab>时使用合适数量的空格，要插入实际的制表符时
" 用CTRL-V<Tab>（在windows下是CTRL-Q<Tab>）
set expandtab
" Be smart when using tabs ;)
" 行首的<Tab>根据shiftwidth插入空白，tabstop或softtabstop用在别的地方，
" <BS>删除行首shiftwidth那么多的空白；该选项若关闭，<Tab>总是根据tabstop
" 或softtabstop决定插入空白的数目，shiftwidth只用于文本左移或右移。
" 插入空白的具体方式 (制表还是空格) 取决于expandtab选项。
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
" Auto indent
" 开启新行时 (插入模式下输入 <CR>，或者使用 o 或 O 命令)，从当前行复
" 制缩进距离。如果你在新行除了 <BS> 或 CTRL-D 以外不输入任何东西，然后输
" 入 <Esc>、CTRL-O 或 <CR>，缩进又被删除。移动光标到其它行也有同样的效
" 果，除非 ’cpoptions’ 里包含 ’I’ 标志位。
" 如果打开自动缩进，排版 (用 gq 命令或者插入模式下到达了 ’textwidth’)
" 使用第一行的缩进距离。
" 打开 ’smartindent’ 或 ’cindent’ 时，缩进的修改方式有所不同。
" 置位 ’paste’ 选项时，’autoindent’ 选项被复位。复位 ’paste’ 时，恢复此
" 选项。
set autoindent
" Smart indent
" 开启新行时使用智能自动缩进。适用于 C 这样的程序，但或许也能用于其它语
" 言。’cindent’ 类似，它多数情况下更好，但更严格，见 C-indenting 。如果
" 打开 ’cindent’ 或设置了 ’indentexpr’，置位 ’smartindent’ 没有效果。
" ’indentexpr’ 是更高级的替代方案。
" 通常，使用 ’smartindent’ 时也应该打开 ’autoindent’。
" 在这些情况下自动插入缩进:
"     - ’{’ 结束的行后。
"     - ’cinwords’ 中的某个关键字开始的行后。
"     - ’}’ 开始的行前 (只有使用 'O' 命令才会)。
" 在新行第一个输入的字符如果是 ’}’，该行使用匹配的 ’{’ 相同的缩进。
" 在新行第一个输入的字符如果是 ’#’，该行的缩进被删除，’#’ 被放到第一列。
" 下一行上，恢复原来缩进。如果你不想这么做，使用下面的映射:
" ':inoremap # X^H#'，其中的 ^H 用 CTRL-V CTRL-H 输入。
" 使用 '>>' 命令时，’#’ 开始的行不右移。
" 注意: ’paste’ 置位时复位本选项，复位时恢复本选项
set smartindent 
" 自动缩进新行时，复制已有的行的缩进结构。通常，用连续的制表，必要时后面
" 再跟若干空格，重新构造新缩进 (除非打开 ’expandtab’ ，这时只用空格)。
" 打开此选项使得新行准确地复制已有行中用来缩进的所有字符。’expandtab’ 对
" 这些字符没有影响，制表还是制表。如果新的缩进比已有行的缩进要多，多余部
" 分的空白使用平常的填充方式。
set copyindent
" 自动缩进和智能缩进功能有时会导致排版错乱，而使用粘贴模式可临时取消这两项缩进
" 设置，Vim提供了一个粘贴模式的开关选项pastetoggle
" 注：paste mode(粘贴模式)作了如下设置：
"     textwidth设置为0
"     wrapmargin设置为0
"     set noai
"     set nosi
"     softtabstop设置为0
"     revins重置
"     ruler重置
"     showmatch重置
"     formatoptions使用空值
"     set nolisp
"     set noindentexpr
"     set nocindent
set pastetoggle=<F8>
" Wrap lines
"set wrap  " 此为默认设置，所以注销

""""""""""""""""""""""""""""""
" 输入法设置
""""""""""""""""""""""""""""""
" 普通模式下自动禁用中文，但可接受中文标点
set noimdisable
" 设置输入法的激活键
set imactivatekey=C-space

" 打开标尺，用于显示光标当前所在位置的行号和列号，逗号分隔；
" 如果还有空间，在最右端显示文本在文件中的相对位置
" 每个窗口都有自己的标尺，如果窗口有状态栏，标尺在状态栏显示；
" 否则，它显示在屏幕的最后一行上
set ruler

" complete表示补全的类型和需要扫描的位置，默认值为：.、wr、b、u、t、i，
" 分别表示扫描:
"     1. 当前缓冲区
"     2. 其它窗口的缓冲区
"     3. 其它载入的缓冲区
"     4. 卸载的缓冲区
"     5. 标签
"     6. 当前文件和包含的头文件
set complete-=i

set tabpagemax=50

" display选项用于改变文件显示的方式。这是逗号分隔的标志位的列表；其中若包含了
" lastline，则表示显示窗口末行尽量多的内容；如果不包含，不能在窗口完全放入的
" 末行会以 '@' 行代替。在屏幕最后一行的最后几列会放上 '@@@'，以指示该行的其余
" 部分不再显示。
set display+=lastline

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j  " Delete comment character when joining commented lines
endif

" 如果设置'nowrap'，光标左右两侧保留的最少屏幕列数
set sidescrolloff=5
" 水平滚动时滚动的最少列数
set sidescroll=1

" 特殊显示空白字符(使得不可见的空白字符可见)
set list
" 设置当输入:set list命令时显示的内容
" ==：为字符串相等运算符（也用于数值比较），#表示大小写敏感（?表示大小写不敏感）
if &listchars ==# 'eol:$'
    "set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    "set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
    " <Tab>制表符用“| ”显示，尾随空格(即后面没有可显示字符的空格)
    " 以“.”显示
    "set listchars=eol:¬,tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:+,space:␣
    set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:+
endif

" 以毫秒计算的等待键码或映射的键序列完成的时间，即设置按键之间的延迟时长
" (尤其是Alt和其他按键的组合键)，用于解决有些环境下从插入模式Insert Mode
" 或命令行模式Command Line Mode切换到普通模式Normal Mode时会卡顿的问题
set ttimeout
set ttimeoutlen=100

" 在进入非普通模式的其他模式(如插入模式、可视模式、选择模式等模式)时，
" 在最后一行显示当前处于什么模式的提示信息(命令行模式除外)，该选项默认关闭
set showmode

" 为所有模式(n普通模式、v可视模式、i插入模式、c命令行模式、h编辑帮助文件时及前
" 面所有模式、a所有前面的模式)打开鼠标支持
" 注：如果鼠标没有打开，GUI版本中仍然可以使用鼠标进行无模式选择，但不能通过鼠标
" 来移动光标
"set mouse+=a  |" 启用鼠标会导致终端软件的复制功能失效
" 在帮助文件中使用鼠标，比如：<C-LeftMouse>或g<LeftMouse>，可与C-]一样跳转到光标
" 所在的关键字的定义
set mouse+=h

" 指定什么场合开始选择时启动选择模式而不是可视模式。
" 可能的值:
"     mouse 使用鼠标时
"     key 使用Shift+特殊键时(注：特殊键通过下面的keymodel选项进行设置)
"     cmd 使用v、V或CTRL-V时
set selectmode=key

" 启用触发选择模式的特殊键(这里的特殊键指：光标键、<End>、<Home>、
" <PageUp>和<PageDown>)，可以使用下面的值启用特殊键:
"     startsel 使用Shift+特殊键可以开始选择(选择模式或可视模式，
"         取决于selectmode选项中有没有"key")。
"     stopsel 使用非Shift+特殊键停止选择。
set keymodel=startsel,stopsel

" 如果过了updatetime所设定的毫秒数以后还没有任何输入，把交换文件写入磁盘(参见
" Vim文档中的crash-recovery)。也用于CursorHold自动命令事件。
" Vim默认值为4000毫秒(即4秒)
" 注：该值会影响vim-markology插件更新标记的速度，所以必须设置小一些
set updatetime=500

" 如果打开，窗口标题会被设为 ’titlestring’ 的值 (如果非空的话)，否则窗口标题将设为:
"     filename [+=-] (path) - VIM
set title
" 使用快速终端连接。重画时可以发送给屏幕多个字符，而不使用插入/删除行命令。
" 有多个窗口和终端不支持滚动区域时，会提高重画的平滑度。同时打开需要回绕行
" 的屏幕行的行尾的额外的字符写入。这有助于在 xterm 和其它终端上使用鼠标来进
" 行复制/粘贴
set ttyfast
" put terminal in 'termcap' mode
" t_表示终端选项，t_ti表示让终端进入termcap模式，t_te表示退出termcap模式
" 注：termcap为terminal capabilities的缩写。tcsh、bash、vi以及其他基于光标的应用程序使用
"     termcap数据库在屏幕周围移动光标和做其他的屏幕导航工作。termcap已经过时，大部分的现
"     代应用程序和程序库使用terminfo数据库代替termcap。但在很多文档里，这两者被统称为
"     termcap。
"if !has('gui_running')
"    set t_ti= t_te= |" 这两个选项会导致即使退出了Vim，但Vim退出前的画面依然保留在SSH终端上
"endif

" Enable clipboard if possible
" 注：1、该选项仅在GUI版本或者包含+xterm_clipboard编译特性时才有效
"     2、X-windows(即X11)版本Vim的clipboard默认设置为：clipboard=autoselect,exclude:cons\|linux，
"        其他版本的默认设置为空
"        其中：
"            1）autoselect：表示无论什么时候启动可视模式或者可视区域扩展，Vim都试图成为窗口
"               系统全局选择区的拥有者，或者把选择的文本放置到选择区寄存器"*使用的剪贴板上。
"               这和guioptions选项的a标志位功能类似。如果激活GUI，使用guioptions的a标志位；
"               如果没有激活GUI，使用本autoselect标志位。也适用于无模式的选择。
"            2）exclude:{pattern}：定义用来匹配终端名(由term选项设置)的模式(即{pattern})。
"               匹配该模式的终端则不连接到X服务器(即X11服务器，见后注)。这可用于以下这种情形:
"                   - 在控制台上运行 Vim，
"                   - $DISPLAY的设置使得应用程序在另一个显示上打开，
"                   - 不希望在控制台上连接到X服务器，但希望在终端模拟器上如此。
"               如永远不想连接到X服务器，使用exclude:.*，这和Vim的启动参数-X参数的效果相同。
"               注意：如果没有到X服务器的连接，则窗口标题不会复原，而剪贴板也无法访问。
"            3）unnamed：表示Vim使用剪贴板寄存器"*来执行所有的抽出、删除、修改和放置操作，
"               而不是通常使用的无名寄存器。除非显式指定了寄存器，这时不管clipboard选项是不
"               是包含unnamed都使用指定的寄存器。剪贴板寄存器总是可以显式地用"*记法来访问。
"            4）unnamedplus：unnamed标志位的变种，对所有通常使用无名寄存器来抽出、删除、修改
"               和放置操作，以剪贴板"+寄存器(quoteplus)代替"*寄存器。如同时包含unnamed标志位，
"               抽出动作(但不包括删除、修改和放置)会同时把文本放入"*寄存器。该选项仅当+X11编
"               译特性存在时才可用。
"               后注：X Server是Linux系统里图形界面服务器的简称。Windows系统的图形界面是系统本
"                    身不可分割的一部分，各种窗口操作界面显示都是由系统核心直接管理的，而Linux
"                    的图形界面并不是系统的必要组成部分，因为Linux一般多在无界面的条件下运行。
"                    当需要Linux提供界面时，系统就会建立一个或者数个X Server，通过X协议跟窗口
"                    管理器(综合图形桌面环境)交互，由独立于系统的应用程序来产生窗口、状态栏、
"                    按钮之类的图形交互界面。比较常见的Linux图形界面环境有KDE、GNOME等，为它们
"                    提供系统支持的就是X Server，而并非Linux核心。
"                    总结一下Linux图形界面环境的层次关系：
"                        Linux核心-->X Server<--[通过X协议交换]-->窗口管理器-->X应用程序
if has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Make cursor always on center of screen by default
" Calculate proper scrolloff
"autocmd VimEnter,WinEnter,VimResized,InsertLeave * :let &scrolloff = float2nr(floor(winheight(0)/2)+1)
"autocmd InsertEnter * :let &scrolloff = float2nr(floor(winheight(0)/2))
" Use <Enter> to keep center in insert mode, need proper scrolloff
"inoremap <CR> <CR><C-o>zz

" Use Unix as the standard file type
set fileformats=unix,mac,dos

" 必须设置下面这两项，否则statuseline或airline将不会正常显示
" 状态行用来分割窗口。选项laststatus用来设置最后一个窗口在什么时候
" 可以有状态栏:
"     laststatus = 0 永远不会有状态行
"     laststatus = 1 窗口数多于一个的时候
"     laststatus = 2 总是显示状态行
set laststatus=2
" t_表示终端选项，t_Co表示终端颜色数目
if !has('gui_running')
  set t_Co=256
endif

" 设定用于填充状态行和垂直分割线的字符。它是逗号分隔的项目列表:
"     项目    缺省  用于
"     stl:c   ’ ’   或 ’^’ 当前窗口的状态行
"     stlnc:c ’ ’   或 ’=’ 非当前窗口的状态行
"     vert:c  ’|’   垂直分割线 :vsplit
"     fold:c  ’-’   填充 ’foldtext’
"     diff:c  ’-’   ’diff’ 选项里的被删除行
"     任何不提供的项目使用其缺省值。"stl" 和 'stlnc' 在有高亮的地方使用空
"     格，否则使用 ’^’ 或 ’=’。
"set fillchars+=stl:\ ,stlnc:\

" Format the status line
"set statusline=\%{HasPaste()}%F%m%r%h\ %w\ \CWD:\ %r%{getcwd()}%h\ \L%l\/\C%c
" 状态栏设置：%<，行过长，则开头截短；CFD，当前文件目录，%F，显示完整路径；
" %m，修改标志位；%r，只读标志位；%h，帮助标志位；%w，预览窗口标志位；
" FMT，文件格式，%{&fileformat}，%{}表示计算表达式，&表示取得选项变量的值；
" TYPE，文件类型，%Y，文件类型；%b，光标所在字符的10进制码点值，.9，最大显示9位；
" %B，光标所在字符的16进制码点值；CWD，当前工作目录；%=，左对齐与右对齐的分界点；
" %c，列号；%V，虚拟列号，表示为负数；%p，当前行在文件位置的百分比；
" %P，窗口在文件位置的百分比；%%，显示%号本身；%L，文件缓冲区里的总行数。
"set statusline=%<[CFP=%F]%m%r%h%w\ [FMT=%{&fileformat}]\ [TYPE=%Y]\ [%.9b\ 0x%.9B]\ [CWD=%{getcwd()}]\ %=[%l,%c%V\ %p%%\ %P\ %LLs]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配置airline（代替statusline、powerline的纯vim实现，无需Python支持）
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置vim-airline的主题为luna
let g:airline_theme="luna" 
"let g:airline_theme="dracula" 

" 安装airline专用字体后，必须设置此项 
let g:airline_powerline_fonts=1   

" 打开tabline功能，方便查看Buffer和切换Buffer，这个功能比较不错，
" 在1个Tab下可用多个buffer，省去安装minibufexpl插件了
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1

" 启用airline中集成的CtrlP
let g:airline#extensions#ctrlp#enabled=1

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#whitespace#symbol='!'

" 设置状态栏符号显示，下面编码用双引号
let g:Powerline_symbols="fancy"
"let g:Powerline_symbols="compatible"
let g:airline_symbols = {}

" unicode symbols
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '
"let g:airline_symbols.linenr = '¶'
" airline symbols
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_left_sep="\U2b80" 
"let g:airline_left_alt_sep="\U2b81"
"let g:airline_right_sep="\U2b82"
"let g:airline_right_alt_sep="\U2b83"
"let g:airline_symbols.branch="\U2b60"
"let g:airline_symbols.readonly="\U2b64"
"let g:airline_symbols.linenr="\U2b61"

" 额外单独设置顶部tabline标签栏的符号显示（如果需要将tabline设置为与statusline
" 不一样，可在这里单独为其设置，否则tabline的符号显示将与statusline一致）
"let g:airline#extensions#tabline#left_sep="\u2b80"
"let g:airline#extensions#tabline#left_alt_sep="\u2b81"

let g:airline_section_a=airline#section#create(['mode'])
let g:airline_section_b=airline#section#create(['hunks'])
let g:airline_section_c=airline#section#create(['[CWD：%{getcwd()}] ','[FILE：%F]'])
let g:airline_section_x=airline#section#create(['branch','ffenc'])
let g:airline_section_y=airline#section#create(['','[TYPE：','filetype','] ','[TIME：','%{strftime("%H:%M")}',']'])
"let g:airline_section_b='%<%m%r%h%w TYPE=%Y %.9b/0x%.9B CWD=%{getcwd()}'
"let g:airline_section_y='%l,%c%V %p%% %P %LLs'

"let g:airline#extensions#tabline#buffer_idx_mode=1

"" 按<Alt>+数字键，选择Tab标签
"nmap <M-1> <Plug>AirlineSelectTab1
"nmap <M-2> <Plug>AirlineSelectTab2
"nmap <M-3> <Plug>AirlineSelectTab3
"nmap <M-4> <Plug>AirlineSelectTab4
"nmap <M-5> <Plug>AirlineSelectTab5
"nmap <M-6> <Plug>AirlineSelectTab6
"nmap <M-7> <Plug>AirlineSelectTab7
"nmap <M-8> <Plug>AirlineSelectTab8
"nmap <M-9> <Plug>AirlineSelectTab9
"nmap <M-[> <Plug>AirlineSelectPrevTab
"nmap <M-]> <Plug>AirlineSelectNextTab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配置airline结束
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""
" 快捷键映射
"""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <LEADER>w saves the current file
"let mapleader = '\<SPACE>'  " 这种写法貌似在ideavim中会导致出错
let mapleader = ' '

" facilitate screen move
" 滚动整屏
"nnoremap <S-CR> :let b:curPos=getpos(".")<CR> <C-F> :call setpos(".", b:curPos)<CR> :unlet b:curPos<CR>
"nnoremap <S-CR> <C-F>zz
nnoremap <S-CR> <C-D><C-D>
"nnoremap <S-BS> :let b:curPos=getpos(".")<CR> <C-B> :call setpos(".", b:curPos)<CR> :unlet b:curPos<CR>
"nnoremap <S-BS> <C-B>zz
nnoremap <S-BS> <C-U><C-U>
" 滚动半屏
nnoremap <C-CR> <C-D>
nnoremap <C-BS> <C-U>
nnoremap <C-J>  <C-D>
nnoremap <C-K>  <C-U>
"nnoremap <SPACE><SPACE> <C-D>
"nnoremap <S-SPACE><SPACE> <C-U>
" 滚动一行
nnoremap <C-S-CR> <C-E>gj
nnoremap <C-S-BS> <C-Y>gk
"nnoremap <DOWN>  <C-E>
"nnoremap <UP>    <C-Y>

" 移动光标，不滚屏（<CR>普通模式下为向下移动光标，但<BS>为逐字符移动光标）
"nnoremap <BS> k
" normal模式下，将Backspace映射为向左删除
nnoremap <BS> X  |" Linux中貌似无效

" redo重做命令
nnoremap U <C-R>

" Treat long lines as break lines（按显示行逐行移动，而非按文本行）， 
" 并且设定为文本逐行滚动，而非光标逐行移动（光标相对屏幕的位置
" 固定不动，按F3可切换这两种方式）
noremap j <C-E>gj
noremap k <C-Y>gk

" go to older jump position(contrast with Tab or C-I)
noremap <S-TAB> <C-O>

" 命令模式下，移动到当前行行首、行尾、行中
nnoremap <C-H> ^
nnoremap <C-L> $
nnoremap  0    ^
nnoremap  -    :call cursor(line("."), col("$")/2)<CR>
nnoremap  =    $

" n、v、s、o模式下注释当前行
" 注意：在vim中，Ctrl-/(正斜杠)是无效的，因此以小键盘的/（kDivide）代替,
" 详见：http://vim.1045645.n5.nabble.com/How-to-map-Ctrl-td1192843.html
"noremap  <C-/>  <ESC>^i"<ESC>j
noremap  <C-kDivide>  <ESC>^i"<ESC>j  |" Linux中貌似无效
inoremap <C-kDivide>  <ESC>^i"<ESC>j  |" Linux中貌似无效

" 插入模式、命令行模式下移动、删除
"inoremap <C-H> <LEFT>
"inoremap <C-J> <DOWN>
"inoremap <C-K> <UP>
"inoremap <C-L> <RIGHT>
"inoremap <C-D> <DELETE>
"cnoremap <C-H> <LEFT>
"cnoremap <C-J> <DOWN>
"cnoremap <C-K> <UP>
"cnoremap <C-L> <RIGHT>
"cnoremap <C-D> <DELETE>

" 由于Windows下的<C-A>已被映射为全选功能，因此需重映射
" 注：默认<C-A>为增加光标所在字符的数值或字母，<C-X>反之
noremap <C-I> <C-A>  |" i，Increase
"noremap <C-D> <C-X>  |" D，Decrease
noremap <C-S-I> <C-X>  |" I，Decrease

" 插入模式下，回车为ESC；Shift+回车为回车
"inoremap <S-CR> <CR>
"inoremap <CR> <ESC>

" i、v、c模式下，jj返回正常模式
inoremap jj    <ESC>

" 插入模式下，复制上、下行对应列字符
"inoremap <C-BS> <C-Y>  |" Linux上无效
"inoremap <C-CR> <C-E>  |" Linux上无效
inoremap <C--> <C-Y>
inoremap <C-=> <C-E>

" 切换标签页，与Windows中标签页切换的常规操作相同
noremap <C-TAB>   gt
noremap <C-S-TAB> gT

" N、X、S、O模式下在命令行窗口列出所有Vim能访问的环境变量(包括操作系统定义
" 的环境变量与Vim定义的环境变量)，并可接着按<Tab>键补全查看某个环境变量的值
"map <LEADER>ev :call Env()<CR>
noremap <LEADER>ev <ESC>:echo $<C-D>

" 可视模式下缩进/反缩进可视区域(选择区域)
vnoremap < <gv
vnoremap > >gv

" 将Y映射为从光标当前位置复制到行尾，
" 以与D、C等大写字母的行为统一起来；
" 并且将复制内容回显到命令行中。
" 其中，echom[sg] {expr1}：回显表达式的结果，将其作为一个
" 真正的消息，并把该消息保存在message-history里；和echo类似，
" 但不可显示的字符只回显而不会被解释；@0，在命令行模式和
" Ex模式中，@表示寄存器，不同于普通模式中以"表示寄存器
noremap  Y  y$ :echom "Copied Text: " . @0<CR>3h
nnoremap yy yy :echom "Copied Text: " . @0<CR>3h  
vnoremap y  y  :echom "Copied Text: " . @0<CR>h
" 将V映射为从光标当前位置选择到行尾，
" 以与D、C、Y等大写字母的行为统一起来；
" 将vv映射为原来V的选中行(即行选)功能，
" 这样也与dd、cc、yy等行操作行为统一起来了
" (注：vv的原生定义为“使得可视模式面向字符”，意义不大)
nnoremap V  v$
nnoremap vv V
" 进入可视模式块选操作(列选操作)子模式
nnoremap <LEADER>v <C-V>
" 可视模式v/V子模式下，仍可切换到块选子模式
vnoremap <LEADER>v <C-V>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
" 上下移动行(整行移动)
" mz，设置标记z；`z，精确移动到标记z所在的行与列；
" :m，移动整行(:[range]m[ove] {address}，把[range]指定的行移动到{address}
" 给出的行之下)；+/-，行号加1/减1；:m+，移动当前行到下一行的下面
" (相当于与下一行交换位置)，:m-，移动当前行到上一行的下面(相当于
" 没有移动)，m-2，移动当前行到上两行的下面(相当于与上一行交换位置) 
"nmap <M-j> mz:m+<CR>`z  |" 貌似Linux终端中无效
"nmap <M-k> mz:m-2<CR>`z  |" 貌似Linux终端中无效
nmap <LEADER>j mz:m+<CR>`z
nmap <LEADER>k mz:m-2<CR>`z

" '<，光标移动到上次可视区域首行行首，'>，光标移动到上次可视区域末行行首；
" 若上次可视区域非跨多行(2行或以上)，而是单行或行内部分字符，'<和'>效果等同；
" `<，光标移动到上次可视区域的首字符，`>，光标移动到上次可视区域的末字符；
" 相较于'<和'>，`<和`>移动更为精确；o，可视模式下表示移动光标到可视区域的
" 另一侧(光标在可视区域内的光标最初所在的位置与最后所在的位置之间移动)
"vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z  |" 貌似Linux终端中无效
"vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z  |" 貌似Linux终端中无效
vmap <LEADER>j :m'>+<CR>`<my`>mzgv`yo`z
vmap <LEADER>k :m'<-2<CR>`>my`<mzgv`yo`z
"if has("mac") || has("macunix")
"    nmap <D-j> <M-j>
"    nmap <D-k> <M-k>
"    vmap <D-j> <M-j>
"    vmap <D-k> <M-k>
"endif

" 打开vimrc配置文件
map <F6> :edit $MYVIMRC<CR>
"" 重载配置文件【注意：执行“:source $MYVIMRC<CR>”命令出错，原因为
"" 与winpos和lines、columns等GUI窗口设置相冲突了】
"map <F9> :source $MYVIMRC<CR>  |" 已启用保存vimrc文件时自动重载

"" 按<Tab>缩进，按<S-Tab>反缩进
"noremap <Tab>   >>  |" <Tab>与Vim原生定义(即默认定义)的跳转功能冲突
"noremap <S-Tab> <<

"" 插入模式下快捷输入$（php中的变量前面必须有$，输入很频繁）
"inoremap ss $
inoremap <A-S> $  |" Linux中貌似无效
"inoremap `     ->
"inoremap ~     =>

" 普通模式下，Ctrl-A全选映射为ggVG（Ctrl-A本为IDE快捷键，但在IdeaVim中无法
" 实现覆盖全选内容（即全选后无法删除全选内容后粘贴，但可用<LEADER><LEADER>c
" 代替） 
" 【注意：只能用于普通模式！】
nnoremap <C-A>    ggVG

"" 在行内任意位置直接跳到行尾并补充分号（输入分号;后，马上换行）
"inoremap <C-S-CR> <ESC>A;<CR>
"inoremap <C-CR>   <ESC>A;<CR>
"inoremap <S-CR>   <ESC>o
" 快速输入双分号，在当前行尾部输入分号
"inoremap ;;  <ESC><HOME>:action EditorLineEndWithSelection<CR>
"            \:action ReformatCode<CR><ESC>A  |" 仅适用于ideavim
inoremap ;;   <ESC>A;

" Disable highlight
map <LEADER>h :noh<CR>

" 普通模式下插入换行符
map <LEADER><CR> i<CR><ESC>

" 保存文件并退出
map <LEADER>wq :wq<CR>
" 保存文件,不退出(原先映射为:update<CR>，但ideavim和vsvim不支持，改为:w<CR>)
map <LEADER>u :w<CR>
" 文件没有修改则直接退出
map <LEADER>q :q<CR>
"" 文件没有修改则全部退出
map <LEADER><LEADER>q :qa<CR>

" 普通模式下插入一个空行
nmap <LEADER>o o<ESC>
nmap <LEADER>O O<ESC>

"" 撤销上一次命令行set操作
"map <LEADER>u :call UndoSetCommand()<CR>
" 重复上一次命令行操作
map <LEADER>r :@:<CR>

" 普通模式下插入单个字符
nmap <LEADER>i i <ESC>r
nmap <LEADER>a a <ESC>r

" Switch CWD to the directory of the open buffer
map <LEADER>cd :cd %:p:h<cr>:pwd<cr>

" toggle case ignore（切换忽略大小写选项）
" 注：set选项后的叹号!表示切换选项值，问号?表示显示选项值
nmap <LEADER>C :set ignorecase! ignorecase?<CR>

" 缓冲区切换
map <LEADER>bp :bprevious<CR>
map <LEADER>bn :bnext<CR>

" Useful mappings for managing tabs
" 标签操作(标签页操作)、标签管理(标签页管理)
map <LEADER>tw :tabnew<CR>
map <LEADER>ts :tab split<CR>
map <LEADER>to :tabonly<CR>
map <LEADER>tc :tabclose<CR>
map <LEADER>tf :tabfirst<CR>
map <LEADER>tl :tablast<CR>
map <LEADER>tm :tabmove
map <LEADER>tp :tabprevious<CR>
map <LEADER>tn :tabnext<CR>
" Let 'tt' toggle between this and the last accessed tab
let g:lasttab=1
nmap <LEADER>tt :execute "tabnext ".g:lasttab<CR>
au TabLeave * let g:lasttab=tabpagenr()
" 列出所有标签页
map <LEADER>ta :tabs<CR>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <LEADER>te :tabedit <c-r>=expand("%:p:h")<cr>/

" 分屏操作(多窗口操作)
" 由于VimScript中的注释以一个双引号开始，有时容易与
" 双引号字符串中的双引号混淆(有些命令后不能跟注释，因为
" 字符串优先于注释)，因此，可在命令行后面的注释前加上
" 命令分隔符|(用于分隔放在单行上的多条Ex命令语句)，以免出错
noremap <LEADER>wc <C-W>c  |" 关闭当前窗口
noremap <LEADER>wn <C-W>n  |" 打开(即创建)一个新窗口
noremap <LEADER>wb <C-W>b  |" 将光标(即焦点)移到底部窗口
noremap <LEADER>wt <C-W>t  |" 将光标(即焦点)移到顶部窗口
noremap <LEADER>ws <C-W>s  |" 水平分割窗口
noremap <LEADER>wv <C-W>v  |" 垂直分割窗口
noremap <LEADER>wh <C-W>h  |" 将光标(即焦点)移到左边窗口
noremap <LEADER>wj <C-W>j  |" 将光标(即焦点)移到下边窗口
noremap <LEADER>wk <C-W>k  |" 将光标(即焦点)移到上边窗口
noremap <LEADER>wl <C-W>l  |" 将光标(即焦点)移到右边窗口
noremap <LEADER>ww <C-W>w  |" 将光标(即焦点)移到下一个窗口
"noremap <F5>       <C-W>w  |" 将光标(即焦点)移到下一个窗口
noremap <LEADER>wH <C-W>H  |" 将当前窗口移到左边 
noremap <LEADER>wJ <C-W>J  |" 将当前窗口移到上边
noremap <LEADER>wK <C-W>K  |" 将当前窗口移到下边
noremap <LEADER>wL <C-W>L  |" 将当前窗口移到右边
noremap <LEADER>w= <C-W>=  |" 使所有分窗口一样高
noremap <LEADER>w+ <C-W>+  |" 增加当前窗口的高度
noremap <LEADER>w- <C-W>-  |" 减少当前窗口的高度
noremap <LEADER>w> <C-W>>  |" 增加当前窗口的宽度
noremap <LEADER>w< <C-W><  |" 减少当前窗口的宽度
noremap <LEADER>wT <C-W>T  |" 将所有分窗口转换为标签

" 删除当前文件中的全部内容，并进入编辑状态
nnoremap <LEADER><LEADER>c ggVGc

" x可视模式、s选择模式下，删除选中区域(选中文本、选中内容)然后插入新行(进入插入模式)
" 注：v开头的映射命令(vmap、vnoremap、vunmap、vmapclear)同时适用于可视模式与选择模式 
"     (而x开头的映射命令仅适用于可视模式、s开头的映射命令仅适用于选择模式)
vnoremap o        do
vnoremap O        dO
" x可视模式、s选择模式下，删除选中区域(选中文本、选中内容)再粘贴
vnoremap p        d"0p
vnoremap P        d"0P
" n、x、s、o模式下粘贴"0复制专用寄存器中的内容
" 注：map、noremap、unmap、mapclear命令同时适用于n普通模式、x可视模式、s选择模
"     式、o操作符待定模式(操作符等待模式)【v表示可视与选择模式】
" n、x、s、o模式下粘贴"0复制专用寄存器中的内容
noremap <LEADER>p "0p
noremap <LEADER>P "0P
" 取消o模式下的上述映射
ounmap  <LEADER>p
ounmap  <LEADER>P
" n、x、s、o模式下粘贴"a命名寄存器中的内容
" 注：小写字母寄存器会覆盖原有内容；大写字母寄存器只追加不覆盖
noremap <LEADER><LEADER>a "ap
noremap <LEADER><LEADER>A "aP
" 取消o模式下的上述映射
ounmap  <LEADER><LEADER>a
ounmap  <LEADER><LEADER>A
" easy system clipboard copy/paste
" "*表示系统剪贴板寄存器
noremap <LEADER><LEADER>y "*y
noremap <LEADER><LEADER>Y "*Y
noremap <LEADER><LEADER>p "*p
noremap <LEADER><LEADER>P "*P
" 取消o模式(Opeator-Pending Mode，操作符待定模式、操作符等待模式)下的上述映射
ounmap  <LEADER><LEADER>y
ounmap  <LEADER><LEADER>Y
ounmap  <LEADER><LEADER>p
ounmap  <LEADER><LEADER>P

" 标记跳转操作快捷键映射
nnoremap <LEADER>.  `.
nnoremap <LEADER>d  `.
nnoremap <LEADER>m  `m

" 可视模式、选择模式下，surround选中区域
" vnoremap s        mzdo<ESC>pyss)
" onoremap s        

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" 可视模式下搜索选中的内容(选中内容搜索)
" y，复制可视区域(选择区域、选择文本)；/，进入搜索命令行模式；
" <C-R>0，粘贴"0复制专用寄存器中刚刚复制的内容；<CR>，回车执行搜索
" 注意：必须使用vnoremap，而不能使用vmap，否则无法达到目的
" 另外，本方法在遇到斜杠/这样的特殊字符时，无法达到目的，
" 即使使用<C-R><C-R>也不行
vnoremap f y/<C-R>0<CR>
"---------------------------------------------------------------------
"NOTE 以下部分的键盘映射需要脚本或插件支持，不适用于ideavim和vsvim
"---------------------------------------------------------------------
"noremap * :call VisualSelectionArthurChiao('SearchForward', '')<CR>
"noremap # :call VisualSelectionArthurChiao('SearchBackward', '')<CR>
" <C-R>，命令行模式下插入寄存器中的内容；<C-R>/，插入搜索模式寄存器的内容
"vnoremap * :<C-U>call VisualSelectionAmix('', '')<CR>/<C-R>=@/<CR><CR>
"vnoremap # :<C-U>call VisualSelectionAmix('', '')<CR>?<C-R>=@/<CR><CR>
"vnoremap * :<C-U>call VisualSelectionAmix('', '')<CR>/<C-R>/<CR>
"vnoremap # :<C-U>call VisualSelectionAmix('', '')<CR>?<C-R>/<CR>
vnoremap <LEADER>f :call VisualSelectionAmix('', '')<CR>/<C-R>/<CR>
"vnoremap <LEADER>b :call VisualSelectionAmix('', '')<CR>?<C-R>/<CR>

" Use absolute linenum in Insert mode; relative linenum in Normal mode
autocmd FocusLost,InsertEnter * :call UseAbsNum()
autocmd FocusGained,InsertLeave * :call UseRelNum()

" 绝对行号、相对行号、无行号切换
" com[mand][!] [{attr}...] {cmd} {rep}：定义一个用户命令。命令的名字是
" {cmd}，而替换的文本是{rep}。该命令的属性(参考手册)是{attr}。如果该
" 命令已存在，报错，除非指定!，这种情况下命令被重定义。
command! Tln call s:ToggleLineNumber()
nnoremap <F2> :Tln<CR>

" 切换滚动模式：文本逐行滚动(光标不动)、光标逐行移动
command! Tsm call ToggleScrollMode()
nnoremap <F3> :call ToggleScrollMode()<CR>

" 在临时将当前窗口放大到一个新标签以及关闭该新标签返回原窗口之间切换
if has('gui_running')
    map <LEADER>zm :call ZoomWindowTemporarily()<CR>
endif

"" 映射Vundle命令（Vundle源于Bundle，为避免与其他映射冲突，使用b开头）
"map <LEADER>bl :PluginList<CR>
"map <LEADER>bi :PluginInstall<CR>
"map <LEADER>bu :PluginUpdate<CR>
"map <LEADER>bs :PluginSearch
"map <LEADER>bc :PluginClean<CR>

" 映射缓冲区管理插件bufferhint(查看、切换缓冲区)的快捷键
" bufferhint使用说明：
"     按\键可调出“缓冲区列表”窗口。再按一下，可以关闭(按q也可关闭)；
"     缓冲区列表最左侧的一个或两个字母(hint key)与缓冲区关联，
"     按下字母，就能切换到对应的缓冲区(类似于Vimperator/Vimium/VimFx)；
"
"     按|键可切回上一个缓冲区。当频繁地在某两个文件之间来回切换时，这很有用；
"     当光标在缓冲区列表里时，按q可关闭窗口(或按\键)，k和j可以上下移动；
"     另外，箭头键、<c-f>、<c-b>、<home>、<end>、gg、G也可移动光标；
"     查找只需像平常一样按下/，输入关键字后回车，按n到下一个，按N到上一个，
"     当找到需要的缓冲区之后，回车就能打开；若想关闭光标下的缓冲区，按dd；
"     若想关闭视区内任一缓冲区，输入d及其对应的hint key，例如da，再回车；
"     当缓冲区列表首次打开时，按路径排序(左侧字母为黄色)；按下空格键，
"     可把排序方式切换到Latest Recently Used(左侧字母变成绿色)。
noremap \ :call bufferhint#Popup()<CR>
" “|”必须转义，否则将被识别成语句分隔符，而导致出现“Unknown function: 
" bufferhint#LoadPrevious”的错误，这是因为vimrc启动过程中bufferhint.vim
" 文件还未加载，所以找不到该函数而出错。
noremap \| :call bufferhint#LoadPrevious()<CR>

" 打开NERDTree
map <LEADER>n :NERDTree<CR>

" easymotion变量及快捷键映射
map <LEADER><LEADER>h <Plug>(easymotion-linebackward)
map <LEADER><LEADER>l <Plug>(easymotion-lineforward)
map <LEADER><LEADER>. <Plug>(easymotion-repeat)
" 下列快捷键为easymotion的默认映射，无需重复设置
" <LEADER><LEADER>w：跳转到当前光标后的某个单词
" <LEADER><LEADER>b：跳转到当前光标前的某个单词
" <LEADER><LEADER>s：双向跳转到所输入的单个字母
" <LEADER><LEADER>j：跳转到光标下面的某行
" <LEADER><LEADER>k：跳转到光标上面的某行
let g:EasyMotion_smartcase=1
" keep cursor colum when JK motion
let g:EasyMotion_startofline=0

" Sneak快捷键映射设置，详细说明可执行命令：:help sneak查看；
" 也可以参见：https://github.com/justinmk/vim-sneak
" 2-character Sneak (default)
nmap <LEADER>s <Plug>Sneak_s
nmap <LEADER>S <Plug>Sneak_S
" visual-mode
xmap <LEADER>s <Plug>Sneak_s
xmap <LEADER>S <Plug>Sneak_S
" operator-pending-mode
omap <LEADER>s <Plug>Sneak_s
omap <LEADER>S <Plug>Sneak_S

" repeat motion
"map ? <Plug>Sneak_;
"map ? <Plug>Sneak_,

" Replace f and/or t with one-character Sneak
" NOTE These mappings do not invoke label-mode, even if it enabled.
" 1-character enhanced 'f'
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
" visual-mode
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
" operator-pending-mode
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" 1-character enhanced 't'
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
" visual-mode
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
" operator-pending-mode
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

"" label-mode
"nmap ? <Plug>SneakLabel_s
"nmap ? <Plug>SneakLabel_S

" YankRing key map
"map <LEADER><LEADER>y :YRShow<CR>

" 多光标操作插件vim-multiple-cursors的快捷键重新映射(Key Map)
let g:multi_cursor_start_word_key = '<LEADER><LEADER>m'

" 自动扩展选择插件vim-expand-region自定义快捷键
" Press + to expand the visual selection and _ to shrink it by default.
" 注：下面的快捷键设置在Linux中无效，不知道是不是远程终端登录软件的问题
noremap <C-w>   <Plug>(expand_region_expand)
noremap <C-S-w> <Plug>(expand_region_shrink)

"***************************************************************
""""""""""""""""""""""""""""""
" Helper functions
""""""""""""""""""""""""""""""
" 撤销刚刚执行的set设置命令
" fu[nction][!] {name}([arguments]) [range] [abort] [dict]：
" 定义{name}命名的新函数。名字必须由字母、数字和 ’_’ 字符组成，
" 而且必须以大写字母或者"s:"开头。
" 若有同名函数且没有使用[!]，给出错误信息；若给出[!]，已有的函数
" 被悄然替代，但该函数正在执行期间除外。此时，这是一个错误。
" 如果给出[range]参数，则该函数自己能理解并处理行范围。该范围通过
" a:firstline和a:lastline定义。如果没有[range]，:{range}call
" 会在该范围的每一行分别执行该函数，每次光标都定位在处理行的行首。
" 见|function-range-example|。
function! UndoSetCommand()
    if (@:=~? '^set\s') || (@:=~? '^se\s')
        exe @:.'!'
    endif
endfunction
""""""""""""""""""""""""""""""

" 获取Vim能访问的所有环境变量(包括操作系统定义的环境变量与Vim定义
" 的环境变量)
function! Env()
    redir => s
    sil! exe "norm!:ec$\<c-a>'\<c-b>\<right>\<right>\<del>'\<cr>"
    redir END
    return split(s)
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
""""""""""""""""""""""""""""""

function! CmdLine(str)
    " menu，创建菜单；emenu，执行菜单(相当于单击菜单)；unmenu，删除菜单
    execute "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" 可视模式下按选择文本(选中的内容)执行查找搜索
function! VisualSelectionAmix(direction, extra_filter) range
    " 预存无名寄存器的内容
    let l:saved_reg=@"
    " :exe[cute] {expr1}，计算{expr1}，返回的字符串作为Ex命令执行（类似于JS的
    " eval()函数）
    " :norm[al][!] {commands}，在命令行模式上执行普通模式命令，!为不使用映射
    " vgvy，进入可视模式，重选上一次的选择区域(选区)，并复制该选区
    execute "normal! vgvy"

    " escape({string}, {chars})，将{string}中的{chars}字符用反斜杠转义
    " 注意：VimScript中双引号字符串与单引号字符串的区别：
    " 双引号字符串用于特殊的“转义序列”（如\n用于换行符、\u263A用于Unicode笑脸标志、
    " \<ESC>用于转义字符；而单引号字符串则将包括在其中的所有内容视为文字字符，比如
    " \n仅被视作\和n两个字面文字字符，而不视为换行符，但也要例外————两个连续的单引号，
    " 它们被单纯地当作单引号，换言之，单引号字符串里面作为字面文字字符的单引号
    " 必须在其前面加多一个单引号，以对其进行转义，否则会被视作单引号字符串的界定符。
    let l:pattern=escape(@", ' \/.*$^~[]')
    " substitute({expr}, {pat}, {sub}, {flags})：{expr}，要被替换操作的原文本；
    " {pat}，匹配模式(比如正则表达式)；{sub}，用以替换符合匹配模式的文本的文本
    " (子串)；{flags}，标志位，缺省为空""，则仅用{sub}替换第一个匹配，若设为g，
    " 则替换所有{pat}匹配。该函数返回经匹配替换后的新文本。
    " 下面这一句是将上次v模式选中的、经过escape()函数对特殊字符转义处理后的
    " 文本的行尾的换行符删除(若行末有换行符，则以空字符""替换，实际就是删除)
    let l:pattern=substitute(l:pattern, "\n$", "", "")

    if a:direction=='gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction=='replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction

function! VisualSelectionArthurChiao(direction, extra_filter) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern=escape(@", ' \/.*$^~[]')
    let l:pattern=substitute(l:pattern, "\n$", "", "")

    if a:direction=='SearchBackward'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction=='gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction=='replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction=='SearchForward'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction
""""""""""""""""""""""""""""""
function! UseAbsNum()
    if exists('g:noshowlinenumber') || exists('#goyo')
        set nonumber norelativenumber
    else
        set number norelativenumber
    endif
endfunction

function! UseRelNum()
    if exists('g:noshowlinenumber') || exists('#goyo')
        set nonumber norelativenumber
    else
        set number relativenumber
    endif
endfunction

" 切换绝对行号、相对行号、无行号
function! s:ToggleLineNumber()
    " cpo，vi兼容性选项；这里的&表示获得选项变量的值
    let l:save_cpo=&cpo
    " se[t] {option}&vim：复位选项为Vim的缺省值
    set cpo&vim

    " number status
    " 1 -> nonumber
    " 4 -> relative number
    " 2 -> number
    "
    if !exists('b:number_status')
        "You may has multi-windows, so it should only working on local buffer
        if &l:relativenumber==1
            let b:number_status=4
        elseif &l:number==1
            let b:number_status=2
        else
            let b:number_status=1
        endif
    endif
    "
    if b:number_status==1
        "set local number to make sure relative number like this (vim 7.4)
        "
        "   2
        "   1
        " 16  <- show current line number
        "   1
        "   2
        "
        setlocal number
        setlocal relativenumber
        let b:number_status=4
    elseif b:number_status==4
        setlocal norelativenumber
        setlocal number
        let b:number_status=2
    elseif b:number_status==2
        setlocal norelativenumber
        setlocal nonumber
        let b:number_status=1
    endif

    let &cpo=l:save_cpo
endfunction
""""""""""""""""""""""""""""""

" 切换滚动模式：文本逐行滚动(光标不动)、光标逐行移动
let s:scroll_mode=1
function! ToggleScrollMode()
    if exists("s:scroll_mode")
        "unmap k
        "unmap j
        noremap j gj
        noremap k gk
        unlet s:scroll_mode
	    echom "scroll mode off"
    else
        "nnoremap j <C-e>gj
        "nnoremap k <C-y>gk
        noremap j <C-E>gj
        noremap k <C-Y>gk
        let s:scroll_mode=1
	    echom "scroll mode on"
    endif
endfunction
""""""""""""""""""""""""""""""

" 一键切换窗口最大化、还原窗口大小
function! ToggleWindowSize()
    if has("gui_running")
        if exists("s:window_max_status")
            " 最大化窗口
            simalt ~x
            "set lines=999
            "set columns=999
            unlet s:window_max_status
        else
            " 还原窗口
            simalt ~r
            "set lines=25
            "set columns=86
            "winpos 930 675
            let s:window_max_status=1
        endif
    endif
endfunction
call ToggleWindowSize()
""""""""""""""""""""""""""""""

" 如果存在session会话文件且可读，则执行该会话文件
function! s:ReadSession()
	let l:session_file="~/.vim/session.vim"
	if filereadable(l:session_file)
		execute "source " . l:session_file
	endif
endfunction
""""""""""""""""""""""""""""""

fun! s:updateSession()
    exe 'mksession! ' . s:sessionfile
    echo 'updating session'
endfun

fun! s:loadSession()
    if argc() == 0
        if (filereadable(s:sessionfile))
            exe 'so' s:sessionfile
        else
            echo 'No session loaded.'
        endif
    endif
endfun
""""""""""""""""""""""""""""""

" 临时将当前窗口新开一个标签，在分屏多窗口的情况下，
" 相当于放大了该窗口；再次调用会关闭该新标签并
" 回到原窗口(仅限于未再新开标签的情况，否则导致混乱)，
" 相当于缩小了该窗口；其中，winsaveview()与winresetview()
" 函数用来将新开标签的窗口信息(光标位置等)应用回原窗口
function! ZoomWindowTemporarily()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if exists("s:is_zoom_window") && tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$')==1
        let l:cur_winview=winsaveview()
        let l:cur_bufname=bufname('')
        tabclose

        " restore the view
        if l:cur_bufname==bufname('')
            call winrestview(cur_winview)
        endif

        unlet s:is_zoom_window
    else
        tab split
        let s:is_zoom_window=1
    endif
endfunction


"*****************************************************************************
" 有用的功能脚本
"*****************************************************************************
"=========================================================================
" Description: Insert pair character automaticly
"              自动插入成对出现的字符(自动输入配对字符)
" Author: Qiming Zhao <chemzqm@gmail.com>
" Licence: Vim licence
" Version: 0.1
" Last Modified: Sep 13, 2016
"=========================================================================
if !exists('did_simple_pairs_loaded')
    let did_simple_pairs_loaded = 1
    let s:pairs = {'(': ')', '（': '）', '[': ']', '{': '}', '<': '>', '"': '"', "'": "'", '`' : '`'}
    
    function! s:getNextChar()
        let pos = getcurpos()
        let lnum = pos[1]
        let cnum = pos[2]
        let line = getline('.')
        if cnum == len(line) + 1 | return -1 | endif
        return line[cnum - 1]
    endfunction
    
    function! s:getPrevChar()
        let pos = getcurpos()
        let lnum = pos[1]
        let cnum = pos[2]
        echo cnum
        if cnum < 2 | return -1 | endif
        return getline('.')[cnum - 2]
    endfunction
    
    function! s:InsertPair(c)
        let matchingPair = s:pairs[a:c]
        let nextChar = s:getNextChar()
        let prevChar = s:getPrevChar()
        let isQuote = index(['"', "'", '`'], a:c) != -1
        if isQuote && prevChar == a:c && nextChar == -1
            return a:c
        endif
        if nextChar == -1
            let insertPair = 1
        else
            if isQuote && nextChar == a:c
                return "\<Right>"
            else
                if isQuote
                    let insertPair = (nextChar != matchingPair)
                else
                    let insertPair = 1
                endif
            endif
        endif
        if insertPair
            let result = a:c . matchingPair . "\<Left>"
        else
            let result = a:c
        endif
        return result
    endfunction
    
    function! s:ClosePair(c)
        let nextChar = s:getNextChar()
        if nextChar ==# a:c
            return "\<Right>"
        else
            return a:c
        endif
    endfunction
    
    for key in keys(s:pairs)
        execute 'inoremap <silent> '.key.' <C-R>=<SID>InsertPair("'.escape(key, '"').'")<CR>'
    endfor
    
    for key in [']', ')', '}']
        execute 'inoremap <silent> '.key.' <C-R>=<SID>ClosePair("'.key.'")<CR>'
    endfor
endif
"=========================================================================
