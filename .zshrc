# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="$HOME/.oh-my-zsh"
#  Note: see also: https://ohmyz.sh/
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
#export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
# 下面导出的环境变量表示在使用fzf选择条目的同时可预览文件内容
# （还可加上选项：--select-1，只有一个条目则自动选中并退出fzf；--exit-0，条目为空则自动退出fzf）
export FZF_DEFAULT_OPTS="--preview='(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --cycle --multi"

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# Safeguard rm
# Put unsetopt RM_STAR_SILENT in your .zshrc, which will make it
# ask you before executing rm with a star rm folder/*.
unsetopt RM_STAR_SILENT
# Put setopt RM_STAR_WAIT in your .zshrc, which will make it wait
# 10 seconds until executing rm with a star rm folder/*.
#setopt RM_STAR_WAIT
# NOTE See also:
#     https://github.com/sindresorhus/guides/blob/master/how-not-to-rm-yourself.md

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="avit"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    dircycle
    dirhistory
    dirpersist
    vi-mode
    autojump
    #ack
    zsh-autosuggestions
    zsh-syntax-highlighting
    icdiff
    httpie
    mycli
    # 很遗憾，incr还是有些问题，只能弃用之，还是多敲一次Tab键吧
    #incr
    # 注：auto-fu是一个很酷的命令及参数自动实时展示插件，但会导致vi-mode、ctrl-r
    # 等失效，还是使用incr插件部分代替其功能(实际上auto-fu就是基于incr开发的)，
    # 以及多按一些Tab键以使用zsh的自动展示与自动补全功能吧
    #auto-fu
    history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# 默认情况下不允许直接使用rm命令
# （注：当确实需要使用rm命令来删除文件时，可先通过执行echo rm <*或文件名>
# 来看下可能将删除哪些文件，这在使用*通配符删除文件时尤其有用）
alias rm='echormhint'
# 使用trash-cli来代替rm命令，参见：https://github.com/andreafrancia/trash-cli
# trash files and directories
alias tp="trash-put"
# empty the trashcan(s)
alias te="trash-empty"
# list trashed files
alias tl="trash-list"
# restore a trashed file
alias ts="trash-restore"  # tr已被另一程序使用
# remove individual files from the trashcan
alias tm="trash-rm"
# 注意：trash-cli还可以配合使用trash自动清理工具autotrash，
# 安装autotrash：
#     yum install autotrash
# 然后执行：
#     crontab -e
# 增加下面这一行到crontab文件中：
#     @hourly /usr/bin/autotrash --max-free 10240 --min-free 5120 -d 360
#     注：
#         1）当可用空间小于10240MB(即10GB)时，开始删除超过360天的文件；
#            当可用空间小于5120MB(即5GB)时，也删除小于360天的文件
#         2）-T PATH --trash-path PATH : Use the given path as the location of
#            the Trash directory, instead of the default: ~/.local/share/Trash.
# 参见：https://github.com/bneijt/autotrash

# 为了使得后面定义的其他命令的别名在sudo时也能生效，必须设置sudo为“alias sudo='sudo '”，
# 具体可参考这里：https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

alias vi='vim'
alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias vb="vim ~/.bashrc"
#alias vv='vim /etc/vimrc'
alias vv='vim ~/.vimrc'
alias vvb='vim /bak/rc-bak/.vimrc'

if [[ $USER == "root" ]] then
    alias tpzswp="tp ~/.vim/swapfiles/%$USER%.zshrc.swp"
    alias tpvswp="tp ~/.vim/swapfiles/%$USER%.vimrc.swp"
else
    alias tpzswp="tp ~/.vim/swapfiles/%home%$USER%.zshrc.swp"
    alias tpvswp="tp ~/.vim/swapfiles/%home%$USER%.vimrc.swp"
fi

alias cls='clear'
alias ll='ls --color -ail'
alias la='ls --color -ai'
# 【特别注意：g开头的别名，不要与下面同样是g开头的git别名相冲突了！】
# -C1：同时只显示匹配行的前后各1行
# -n：输出行号
alias gg="grep -nC1 --color=auto"
# -i：不区分大小(即大小写不敏感)
alias ggi="grep -niC1 --color=auto"
# 递归查找文件内容(区分大小写)
# -r：递归查找当前文件夹及其子文件夹
alias ggrn="grep -rnC1 --color=auto"
# 递归查找文件内容(不区分大小写)
alias ggrni="grep -rniC1 --color=auto"
# 递归查找文件内容(不区分大小写，且只在指定文件类型中查找)
# 比如：grep -rn --include='*.c' --include='*.h' re  或写作：
#       grep -rn --include='*.[ch]' re
alias ggrnn="grep -rnC1 --color=auto --include"
alias ggrnin="grep -rniC1 --color=auto --include"


# 查看所有的网络相关信息，如连接、端口、路由表等
alias nsa="netstat -an"
# 仅查看有在监听(listen)的网络相关信息，如连接、端口、路由表等
alias nsl="netstat -ln"
# 查看所有tcp连接的网络相关信息，如连接、端口、路由表等
alias nsat="netstat -atn"
# 查看所有udp连接的网络相关信息，如连接、端口、路由表等
alias nsau="netstat -aun"
# 查看所有tcp、udp连接的网络相关信息，如连接、端口、路由表等
alias nsatu="netstat -atun"
# 查看指定的网络相关信息(区分大小写)，如连接、端口、路由表等
alias nsg="netstat -anpt|grep -nC1 --color=auto"
# 查看指定的网络相关信息(不区分大小写)，如连接、端口、路由表等
alias nsgi="netstat -anpt|grep -niC1 --color=auto"
# 使用find查找文件时，对于没有查询权限的目录会不断出现Permission denied，导致不容易看到正确的查询结果，
# 而Permission denied属于错误，将错误(0为标准输入，1为标准输出，2为标准错误)重定向到黑洞文件/dev/null即可
# 从根目录开始递归查找指定的文件名(区分大小写)
# 注：$@代表全部参数
alias fn="find / -name $@ 2>/dev/null"
# 从根目录开始递归查找指定的文件名(不区分大小写)
alias fin="find / -iname $@ 2>/dev/null"
# 从根目录开始(但排除指定目录)递归查找指定的文件名(不区分大小写)
alias finn="find / -iname $@ 2>/dev/null ! -path '/proc/*' ! -path '/sys/*'"
# 从根目录开始查找指定inode号的文件
alias fim="find / -inum $@ 2>/dev/null"
# 快速查找文件(默认为全局查找，即默认为相当于从根目录开始递归查找)（区分大小写）
alias l="locate"
# 先更新搜索数据库，再快速查找文件(默认为全局查找，即默认为相当于从根目录开始递归查找)（区分大小写）
alias ul="updatedb && locate"
# 快速查找文件(默认为全局查找，即默认为相当于从根目录开始递归查找)（不区分大小写）
alias li="locate -i"
# 先更新搜索数据库，再快速查找文件(默认为全局查找，即默认为相当于从根目录开始递归查找)（不区分大小写）
alias uli="updatedb && locate -i"
# 树状形式显示所有进程信息(p代表ps，t代表tree)
alias pt='ps axjf'
# 树状形式查看指定的进程状态(区分大小写)
# 注：grep -v grep——排除掉grep本身的进程信息
alias ptg="pt|grep -v grep|grep -nC1 --color=auto"
# 树状形式查看指定的进程状态(不区分大小写)
alias ptgi="pt|grep -v grep|grep -niC1 --color=auto"
# 查看指定的进程状态(区分大小写)
alias pg="ps aux|grep -v grep|grep -nC1 --color=auto"
# 查看指定的进程状态(不区分大小写)
alias pgi="ps aux|grep -v grep|grep -niC1 --color=auto"
# 查看当前系统用户列表：vul = view user list
alias vul="cat /etc/passwd|grep -v nologin|grep -v halt|grep -v shutdown"
alias vula="cat /etc/passwd|grep -v nologin|grep -v halt|grep -v shutdown|awk -F\":\" '{ print $1\"|\"$3\"|\"$4 }'|more"

alias k9="kill -9"

# git命令别名【特别注意：g开头的git别名不要与上面同样是g开头的其他别名相冲突了！】
alias ga="git add"
alias gai="git add .ideavimrc"
alias gb="git branch"
alias gc="git commit"
alias gcl="git clone"
alias gco="git checkout"
alias gd="git diff"
alias gf="git fetch"
alias gi="git init"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gm="git merge"
alias gps="git push"
alias gpsom="git push origin master"
alias gplom="git pull origin master"
alias gpl="git pull"
alias grs="git reset"
alias grb="git rebase"
alias grv="git revert"
alias grm="git remote"
#origin一般习惯指向上位仓库(即上游仓库，比如github中的仓库)（可在各个git仓库的配置文件.git/config中修改）
alias grmao="git remote add origin"
#condingnet指的是码市conding.net
alias grmac="git remote add codingnet"
alias gs="git status"
alias gsb="git submodule"
alias gsh="git show"
alias gt="git tag"

# 第一句使得不将以空格开始的命令行记录到历史当中（这在需要明文输入密码时也挺有用，
# 这样就不会在历史记录中看到输入的密码了）; 
# 后面两句使得cd/ls这些简单的命令就不记录到历史中了，这样用history查看时就更为清晰明了了
setopt HIST_IGNORE_SPACE
alias cd=" cd"
#alias l=" l"
#alias li=" li"
#alias ll=" ll"
#alias la=" la"
#alias pg=" pg"

# 启用命令行别名的自动补全
setopt completealiases

# 启用以方向键控制的自动补全(按两次Tab键可启动菜单)
# 注：所谓menu select，是指可以用光标键或者Ctrl-p/Ctrl-n来挑选选项
# fzf提供的类似功能更为好用（另：命令补全已经启用）
#zstyle ':completion:*' menu select

# 启用自动补全容错(如输入cd /etc/x11, 按TAB后zsh会自动纠正为/etc/X11)：
# 注：貌似oh-my-zsh已经提供该功能
#zstyle ':completion::approximate:' max-errors 1 numeric

# 消除历史记录中的重复条目
# 注：若历史记录中已有重复条目，可手动执行下列命令进行清除：
#     sort -t ";" -k 2 -u ~/.zsh_history | sort -o ~/.zsh_history
setopt HIST_IGNORE_DUPS

## 历史命令增量翻找（即根据前面已经输入的字符进行增量匹配查找）
#【注：该功能可用history-substring-search插件代替】
## See also: http://ju.outofmemory.cn/entry/58895
#autoload history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey  '^[[A'  history-beginning-search-backward-end
#bindkey  '^[[B'  history-beginning-search-forward-end

# 在zsh中简单快速设置彩色提示符（prompt -l：查看可用的提示符主题；
# prompt walters：启用walters提示符主题；prompt -p：查看各提示符主题的实际显示效果）
autoload -U promptinit && promptinit


# 配置目录栈DIRSTACK相关变量来加速cd访问常用目录(可用dirs -v列出目录栈；
# cd -<NUM>跳转到以前访问过的目录；还可在连字符后面使用自动补全)
if [[ ! -d ~/.cache/zsh ]]; then
  mkdir -p ~/.cache/zsh
fi
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
DIRSTACKSIZE=50
# 打开auto_pushd选项，这样通过cd切换目录时，zsh会自动将前一个目录加到目录栈里，
# 这样就不会因为忘记pushd而遗憾了
setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
## This reverts the +/- operators.
setopt pushdminus

# DEL键不能删除当前字符，加上下面这句就可以了。其中，“^[[3~”表示DEL键的键码(key code)
# 注：可执行cat -v命令来查看按键的键码(key code)
bindkey "^[[3~" delete-char

# 使用Alt+Left让用户撤销最近的cd操作，使用Alt+Up让用户进入上层目录。
# 这两个快捷键同时也会显示目录中的内容。
cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}
cdParentKey() {
  pushd .. > /dev/null
  zle      reset-prompt
  echo
  ls
  echo
}
zle -N                 cdParentKey
zle -N                 cdUndoKey
# 注：可执行cat -v命令来查看按键的键码(key code)
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey

# 刷新自动补全：一般来说，compinit不会自动在$PATH里面查找新的可执行文件。
# 例如当你安装了一个新的软件包，/usr/bin里的新文件不会立即自动添加到自动
# 补全当中，添加下列语句可自动添加进自动补全中：
zstyle ':completion:*' rehash true

# 在zsh下，如果你执行dpkg -l firefox*，很可能zsh不会列出名字以firefox开头的包，
# 而是告诉你zsh: no matches found: firefox*。这是因为zsh缺省情况下始终自己解释
# firefox*中的通配符*，而不会传递给dpkg来解释
setopt no_nomatch 

## 用RPROMPT环境变量用来设置显示在右边的提示符：显示当前git仓库名、分支名和提交状态
#_git_repo_name() {
#  gittopdir=$(git rev-parse --git-dir 2> /dev/null)
#  if [[ "foo$gittopdir" == "foo.git" ]]; then
#    echo `basename $(pwd)`
#  elif [[ "foo$gittopdir" != "foo" ]]; then
#    echo `dirname $gittopdir | xargs basename`
#  fi
#}
#_git_branch_name() {
#  git branch 2>/dev/null | awk '/^\*/ { print $2 }'
#}
#_git_is_dirty() {
#  git diff --quiet 2> /dev/null || echo '*'
#}
#setopt prompt_subst 
#RPROMPT='$(_git_repo_name) $(_git_branch_name) $(_git_is_dirty)'

# ttyctl命令：zsh中的ttyctl命令可用来锁定/解锁(freeze/unfreeze)终端。许多程序会修改
# 终端的状态并且在异常退出时不还原初始状态，下面的配置可以避免手动重置终端：
ttyctl -f


# 自定义函数
#
# 创建一个目录并进入该目录里：mcd [目录名]；
# 默认mkdir一次只能创建一层目录，如果在当前目录下创建一个div/css这样的多层目录就需要逐层创建：
# 先mkdir div，然后cd div，然后再mkdir css；加上-p参数，可一次性创建：mkdir -p div/css
# -p参数：表示创建一条完整的路径(当路径中的某个目录已经存在时，跳过该目录继续创建下一级目录)；
mcd() { mkdir -p "$1"; cd "$1";}

# 类似上一个函数，进入一个目录并列出它的内容：cdls [目录名]
cdls() { cd "$1"; ls;}
cdll() { cd "$1"; ll;}

# 简单的给文件创建一个备份：backup [文件]，将会在同一个目录下创建 [文件].bak
backup() { cp "$1"{,.bak};}

# 如果不喜欢通过手工比较文件的md5校验值，这个函数会计算它并进行比较：md5check [文件] [校验值]
md5check() { md5sum "$1" | grep "$2";}

# 找到某个文件后用vim打开该文件(如果有多个同名文件，则只能打开第一个文件)
vfin() {vim $(find / -iname "$1")}

# 将找到的所有文件用vim以标签页的形式全部打开(一个文件一个标签，可用:tabn、:tabp切换)
vmfin() {find / -iname "$1" -exec vim -p {} +}

# 使用fzf列出当前目录下的文件(即只查找当前目录及其子目录中的文件)，然后选择一个用vim打开
vff() {vim $(fzf)}

# 使用locate命令全局查找文件(即从根目录开始查找)，然后用fzf进行选择后用Vim打开选择的文件
vf() {
  local file

  # 更新locate索引数据库
  sudo updatedb

  # locate -Ai -0 $@：
  #     -A：匹配列出的所有模式
  #     -i：忽略大小写
  #     -0：使用ASCII NUL字符作为定界分隔符分隔输出的条目
  #     $@：获取执行本函数时所传入的所有参数；
  # grep -z -vE '~$'：不选择以~结尾的临时文件，亦即选择除了以~结尾的所有文件。其中：
  #     -z：将输入视为一组行，每行以零字节(ASCII NUL字符)而不是换行符结束，
  #         与-Z或--null选项类似，此选项可与sort -z等命令一起使用以处理任意文件名；
  #     -v：反选；
  #     -E：使用grep的扩展正则表达式语法
  #     '~$'：匹配模式，匹配以~结尾的行（这里的行代表一个文件名路径）
  # fzf --read0 -0 -1：
  #     --read0：以ASCII NUL字符作为定界分隔符读取输入
  #     -0：当没有匹配时立即退出
  #     -1：当只有一个匹配时直接选中
  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
  #file="$(locate -Ai -0 $@ | fzf --read0 -0 -1)"

  vim "${file}"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  sudo updatedb

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
    if [[ -d $file ]]
    then
        cd -- $file
    else
        cd -- ${file:h}
    fi
  fi
}

echormhint() {
    echo Don\'t use \'rm\'. Try to use trash related commands.; false

}

# 运行这个函数从GitHub的the-art-of-command-line(命令行的艺术)文档中随机获取一条技巧
# （解析 Markdown 文件并抽取项目）
# 参见：https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md
function taocl() {
  curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README-zh.md|
    pandoc -f markdown -t html |
    iconv -f 'utf-8' -t 'unicode' |
    xmlstarlet fo --html --dropdtd |
    xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
    xmlstarlet unesc | fmt -80
}

# myrm(){
#    # 判断目录是不是已经存在，如果不存在则创建，存在则输出“dir exist”
#    #recycle_bin_dir='~/.RecycleBin'
#    #echo "The recycle bin dir name is $recycle_bin_dir"
#    if [[ ! -d ~/.RecycleBin ]]; then
#      #mkdir $recycle_bin_dir
#      mkdir ~/.RecycleBin
#    #else
#    #  echo dir exist
#    fi
#
#    for target in $@
#    do
#        if [[ "$target" =~ ^-[rf]+$ ]]; then
#            #echo '$target1: ' $target
#            continue
#        fi
#        #echo '$target2: ' $target
#        mv -i $target ~/.RecycleBin
#    done
#}
#
# Please manually add the following line(s) to ~/.zshrc:
[[ -s /home/aabbcc/.autojump/etc/profile.d/autojump.sh ]] && source /home/aabbcc/.autojump/etc/profile.d/autojump.sh
# 开启zsh的命令自动补全功能
# 注：下面的语句为安装autojump时自动添加的，事实上oh-my-zsh已经自动开启
autoload -U compinit && compinit -u


## auto-fu.zsh stuff.
# source ~/.oh-my-zsh/custom/plugins/auto-fu/auto-fu.zsh
# See also: https://github.com/hchbaw/auto-fu.zsh.git
#{ . ~/.zsh/auto-fu; auto-fu-install; }
#zstyle ':auto-fu:highlight' input bold
#zstyle ':auto-fu:highlight' completion fg=black,bold
#zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
#zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
#zstyle ':auto-fu:var' track-keymap-skip opp
#zle-line-init () {auto-fu-init;}; zle -N zle-line-init
#zle -N zle-keymap-select auto-fu-zle-keymap-select


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.fzf/shell/zsh-interactive-cd.plugin.zsh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
