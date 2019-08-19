#*****************************************************************************************************
#******************************************zplug start************************************************
# zplug主命令：用于列出准备加载的zsh插件或准备加入到SPATH环境变量中的命令，只仅限于列出，
#              后面还必须：
#              1）通过zplug install子命令来安装尚未安装的zsh插件或命令；
#              2）通过zplug load子命令来加载已安装的zsh插件或加入已安装的命令到SPATH。
# zplug主命令的参数选项：
#     --help			Display the help message
#     --rollback		Rollback a failed package
#     --self-manage		Self management of zplug
#     --version			Display the version of zplug
#     --log				Show the report of zplug errors
#
# zplug主命令的子命令：
#     zplug check：检查是否安装了所有软件包(包括zsh插件和命令)，是返回true，否则返回false；
#                  若检查是否安装了某个软件包，只需在zplug check后面加上软件包名(来自github
#                  的软件包名为：github-name/repo-name，如intelfx/pure)，参数选项：--verbose
#     zplug clean：删除不再受管理的存储库，参数选项：--force、--select
#     zplug clear：删除缓存文件（无参数选项）
#     zplug info：显示信息，比如显示给定软件包的源URL和tag值（无参数选项）
#     zplug install：并行安装尚未安装的软件包（无参数选项)
#     zplug list：列出已安装的软件包(更具体地说，查看关联数组$zplugs)，参数选项：--select、
#				  --installed、--loaded
#     zplug load：启动已安装的插件并添加已安装的命令到SPATH环境变量中，参数选项：--verbose
#     zplug status：检查远程存储库是否是最新的，参数选项：--select
#     zplug update：并行更新已安装的软件包，参数选项：--select、--force
#
# zplug命令的tag标签一览表：参见：https://github.com/zplug/zplug#3-tags-for-zplug

	# 必须先安装zplug，参见：https://github.com/zplug/zplug
	# 假如zplug尚未安装
if [[ ! -d ~/.zplug/ ]]; then
	printf "Install zplug? [y/N]: "
	# read命令的-q参数：Read only one character from the terminal and set name to ‘y’ if this
	# character was ‘y’ or ‘Y’ and to ‘n’ otherwise. With this flag set the return status is
	# zero only if the character was ‘y’ or ‘Y’. This option may be used with a timeout (see -t);
	# if the read times out, or encounters end of file, status 2 is returned. Input is read from
	# the terminal unless one of -u or -p is present. This option may also be used within zle widgets.
	# read命令的用法可参见：http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-read
    if read -q; then
		echo "\nInstalling zplug...\n"
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi
fi

	# 假如zplug已经安装【注意：不能与上面的if语句结合使用else语句，因为第一次还未安装zplug的情况下，
	# 将执行不到else语句中的内容】
if [[ -d ~/.zplug/ ]]; then
		# 启动zplug并初始化
	source ~/.zplug/init.zsh

		# 让zplug管理zplug自身
		# 要像管理其他zsh软件包一样管理zplug本身，可在.zshrc中加入以下代码，然后只需在命令行中运行：
		#     zplug update
		# 注意：应尽量使用双引号
	zplug "zplug/zplug", hook-build:"zplug --self-manage"

		# 加载启动oh-my-zsh的库文件
		# 注意：不同于antigen，zplug会自动安装oh-my-zsh，无需手动安装（zplug自动安装的oh-my-zsh路径：
		# ~/.zplug/repos/robbyrussel/oh-my-zsh；手动安装的oh-my-zsh路径：~/.oh-my-zsh）
		# oh-my-zsh参见：https://github.com/robbyrussell/oh-my-zsh
		# use标签：对于插件(不显式指定as标签则默认为插件)，指定要启动(source)的文件名的模式(pattern)；
		#          对于命令(必须显式指定as标签为command：as:command)，指定要添加到$PATH的路径。
		#          当使用了from:gh-r(即github release)时，zplug会尝试从操作系统和体系结构(即CPU的32位、
		#          64位等架构)中猜测要使用哪个版本的文件。若zplug猜测的版本不正确，可通过手动指定，如：
		#              use:"*darwin*{amd,386}*"
	zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

	#-----------------------------------------------------------------------------------------
	# 以下为非oh-my-zsh自带的插件，zplug在缺省from标签时会自动从github下载、安装以及自动加载
	#-----------------------------------------------------------------------------------------
	# 以下四个插件均来自：https://github.com/zsh-users

		# 代码提示功能
		# defer标签：设置插件加载的优先级，默认值为0，取值范围为0~3，如果值为2或以上，zplug将在
		#            执行compinit命令和启动其他插件之后再启动该插件
	zplug "zsh-users/zsh-autosuggestions", defer:2

		# 自动补全功能
	zplug "zsh-users/zsh-completions", defer:2

		# 语法高亮功能
	zplug "zsh-users/zsh-syntax-highlighting", defer:2

		# 增量补全功能【注意：zsh-history-substring-search必须在zsh-syntax-highlighting之后启用】
		# 使用上下箭头键对历史命令增量翻找补全(即根据前面已经输入的字符对历史命令进行匹配查找及补全)
		# zsh-history-substring-search必须在zsh-syntax-highlighting之后启用
		# zsh-history-substring-search为oh-my-zsh自带的插件(插件名为：history-substring-search)，
		# 因此这里无需重复安装，下面直接启用即可
		# 注意：从github安装的版本无效(原因不明)，使用下面的oh-my-zsh插件版本
    #zplug "zsh-users/zsh-history-substring-search", defer:3

		# fzf插件：模糊查找(即模糊搜索)文件（fzf为fuzzy finder的缩写）
		# 注：虽然新版oh-my-zsh已经自带该插件，可在~/.oh-my-zsh/plugins目录下找到，但还是
		# 必须额外先安装才能使用，因为该插件只是启用了fzf模糊自动完成和键绑定功能(This plugin
		# enables junegunn's fzf fuzzy auto-completion and key bindings.)
		# oh-my-zsh fzf插件参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/fzf
		# fzf官方仓库参见：https://github.com/junegunn/fzf
	zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf  # 安装fzf插件
	zplug "junegunn/fzf", use:"shell/*.zsh", on:"junegunn/fzf-bin"  # 运行fzf插件安装目录下shell目录中的zsh脚本

		# zsh-interactive-cd插件基于fzf，必须先安装fzf（虽然新版oh-my-zsh已经自带该插件，
		# 可在~/.oh-my-zsh/plugins目录下找到，但还是必须额外先安装才能使用）
		# 参见：https://github.com/changyuheng/zsh-interactive-cd
		# on标签：只有在由on标签指定的软件包已经安装的情况下，才加载本软件包
		# (?)注意：on标签感觉可用if标签代替；if标签：指定安装和使用软件包的条件，如：if:"[ -d ~/.zsh ]"。
		#       因此，可认为on标签为if标签的特例——专用于判断某个软件包是否已经安装的if标签。
	zplug "changyuheng/zsh-interactive-cd", defer:3, use:zsh-interactive-cd.plugin.zsh  #, on:"junegunn/fzf-bin"
	#-----------------------------------------------------------------------------------------

	#-----------------------------------------------------------------------------------------
	# 以下为oh-my-zsh自带的插件(robbyrussell's oh-my-zsh plugins)，直接加载即可(必须显式指定
	# from标签：from:oh-my-zsh；不显式指定，则默认为：from:github)，无需安装
	#-----------------------------------------------------------------------------------------
		# history-substring-search为zsh-history-substring-search的oh-my-zsh插件名称(相当于别名)
    zplug "plugins/history-substring-search", from:oh-my-zsh, defer:3  # 从github安装的无效

		# git插件功能：当处于git受控目录时，zsh会明确提示(如显示分支信息“master”)；
		# 另外，git插件还对很多git命令进行了别名简化，如g=’git’、gd=’git diff’、
		# gco=’git checkout’、gst=’git status’等，熟练使用可大大提高git操作效率
		# 参见：https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
	zplug "plugins/git", from:oh-my-zsh

		# vi-mode插件功能：zsh终端中默认使用的键盘映射为emacs-mode，习惯vim键盘绑定的可通过
		# vi-mode插件来开启
		# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode
	zplug "plugins/vi-mode", from:oh-my-zsh

	#zplug "plugins/pip", from:oh-my-zsh

	#zplug "plugins/command-not-found", from:oh-my-zsh

		# dircycle插件功能：可使用Ctrl+Shift+left/right在目录之间来回移动
		# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/dircycle
	zplug "plugins/dircycle", from:oh-my-zsh

		# dirhistory插件功能：可用ALT-LEFT移动到用户过去更改的目录，ALT-RIGHT撤消ALT-LEFT，
		# ALT-UP移动到上层目录(相当于“cd ..”)，ALT-DOWN移动到按字母顺序找到的第一个目录
		# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/dirhistory
	zplug "plugins/dirhistory", from:oh-my-zsh

		# dirpersist插件功能：此插件保留$HOME/.zdirs文件中前20个唯一目录(即不重复)的运行记录。
		# 当转到新目录时，该新目录会被添加到$HOME/.zdirs文件的开头。
		# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/dirpersist
	zplug "plugins/dirpersist", from:oh-my-zsh

		# z插件：历史目录跳转插件；该插件无需安装，直接启用即可。z插件相当于autojump及其
		# 升级版j插件(https://github.com/rupa/j)的升级版
		# 参见：https://github.com/rupa/z
	zplug "plugins/z", from:oh-my-zsh
	
	zplug "plugins/command-not-found", from:oh-my-zsh
	zplug "plugins/colored-man-pages", from:oh-my-zsh
	#-----------------------------------------------------------------------------------------

		# 加载主题
	#zplug "dracula/zsh", as:theme  # 会导致退出shell，原因不明
		# 切记在“~/.zplug/repos/robbyrussell/oh-my-zsh/themes/avit.zsh-theme”文件中作如下修改：
		#     PROMPT='
		#     $(_user_host) %{$fg_bold[red]%}%*%{$reset_color%} %d $(git_prompt_info)
		#     %{$fg[$CARETCOLOR]%}%#%{$resetcolor%} '
	zplug "themes/avit", as:theme, from:oh-my-zsh

		# zplug check：检查是否安装了所有软件包(包括zsh插件和命令)，是返回true，否则返回false；
		#              若检查是否安装了某个软件包，只需在zplug check后面加上软件包名(来自github
		#              的软件包名为：account-name/repo-name，如b4b4r07/enhancd)，参数：--verbose
		# zplug install：并行安装尚未安装的软件包（无参数)
	if ! zplug check --verbose; then
		printf "Install plugins? [y/N]: "
		if read -q; then
			echo; zplug install
		fi
	fi

		# zplug load子命令：将上面通过zplug主命令(不是zplug子命令)列出的且已安装的zsh插件启动及
		# 已安装的命令添加到$PATH环境变量中
	echo "Loading plugins..."
	zplug load --verbose
	#zplug load
fi
#******************************************zplug end**************************************************
#*****************************************************************************************************


#*****************************************************************************************************
#***********************************常量、变量及参数设置 开始*****************************************
	# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
#export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
	# 下面导出的环境变量表示在使用fzf选择条目的同时可预览文件内容
	# （还可加上选项：--select-1，只有一个条目则自动选中并退出fzf；--exit-0，条目为空则自动退出fzf）
export FZF_DEFAULT_OPTS="--preview='(highlight -O ansi -l {} 2> /dev/null || cat {} \
    || tree -C {}) 2> /dev/null | head -200' --cycle --multi"

#export DOTNET_ROOT=$HOME/dotnet
#export PATH=$PATH:$HOME/dotnet

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

if [[ ! -d ~/.zplug/ ]]; then
		# Set name of the theme to load --- if set to "random", it will
		# load a random theme each time oh-my-zsh is loaded, in which case,
		# to know which specific one was loaded, run: echo $RANDOM_THEME
		# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
	#ZSH_THEME="robbyrussell"
	ZSH_THEME="avit"
fi

	# Set list of themes to pick from when loading at random
	# Setting this variable when ZSH_THEME=random will cause zsh to load
	# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
	# If set to an empty array, this variable will have no effect.
#ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

	# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

	# Uncomment the following line to use hyphen-insensitive completion.
	# Case-sensitive completion must be off. _ and - will be interchangeable.
#HYPHEN_INSENSITIVE="true"

	# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"

	# Uncomment the following line to automatically update without prompting.
#DISABLE_UPDATE_PROMPT="true"

	# Uncomment the following line to change how often to auto-update (in days).
#export UPDATE_ZSH_DAYS=13

	# Uncomment the following line if pasting URLs and other text is messed up.
#DISABLE_MAGIC_FUNCTIONS=true

	# Uncomment the following line to disable colors in ls.
#DISABLE_LS_COLORS="true"

	# Uncomment the following line to disable auto-setting terminal title.
#DISABLE_AUTO_TITLE="true"

	# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

	# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

	# Uncomment the following line if you want to disable marking untracked files
	# under VCS as dirty. This makes repository status check for large repositories
	# much, much faster.
#DISABLE_UNTRACKED_FILES_DIRTY="true"

	# Uncomment the following line if you want to change the command execution time
	# stamp shown in the history command output.
	# You can set one of the optional three formats:
	# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
	# or set a custom format using the strftime function format specifications,
	# see 'man strftime' for details.
#HIST_STAMPS="mm/dd/yyyy"

	# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=/path/to/new-custom-folder

	# User configuration
#export MANPATH="/usr/local/man:$MANPATH"

	# You may need to manually set your language environment
#export LANG=en_US.UTF-8

	# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi

	# Compilation flags
#export ARCHFLAGS="-arch x86_64"

	# ssh
#export SSH_KEY_PATH="~/.ssh/rsa_id"

	# 启用命令行别名的自动补全
setopt completealiases

	# 启用以方向键控制的自动补全(按两次Tab键可启动菜单)
	# 注：所谓menu select，是指可以用光标键或者Ctrl-p/Ctrl-n来挑选选项
	# fzf提供的类似功能更为好用（另：命令补全已经启用）
	# zstyle：zstyle命令为shell内建命令，为zsh补全系统(compsys，completion system)处理明显的样式
	# 控制，但它的功能远不止这些。例如，vcs_info模块依赖于zstyle在提示符中显示git状态。
	# 可以通过man zshmodules命令查看zstyle部分的几个解释性段落。
#zstyle ':completion:*' menu select

	# 启用自动补全容错(如输入cd /etc/x11, 按TAB后zsh会自动纠正为/etc/X11)：
	# 注：貌似oh-my-zsh已经提供该功能
#zstyle ':completion::approximate:' max-errors 1 numeric

	# 自动消除历史记录中的重复条目
	# 注：若历史记录中已有重复条目，可手动执行下列命令进行清除：
	#     sort -t ";" -k 2 -u ~/.zsh_history | sort -o ~/.zsh_history
setopt HIST_IGNORE_DUPS

	## 历史命令增量翻找（即根据前面已经输入的字符进行增量匹配查找）
	#【注：该功能可用history-substring-search插件代替】
	## See also: http://ju.outofmemory.cn/entry/58895
#autoload history-search-end
    # zle: zsh command line editor
    # zle模块包含三个相关的内置命令：
    #     bindkey命令操作键映射和键绑定；
    #     vared命令对shell参数的值调用zle；
    #     zle命令操作编辑小部件，并允许命令行从shell函数中访问zle命令。
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
	# Remove duplicate entries
setopt pushdignoredups
	# This reverts the +/- operators.
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

	# 刷新自动补全：一般来说，compinit(zsh completion initialize，自动补全初始化)不会
	# 自动在$PATH里面查找新的可执行文件。例如当你安装了一个新的软件包，/usr/bin里的新
	# 文件不会立即自动添加到自动补全当中，添加下列语句可自动添加进自动补全中：
zstyle ':completion:*' rehash true

	# 在zsh下，如果你执行dpkg -l firefox*，很可能zsh不会列出名字以firefox开头的包，
	# 而是告诉你zsh: no matches found: firefox*。这是因为zsh缺省情况下始终自己解释
	# firefox*中的通配符*，而不会传递给dpkg来解释
setopt no_nomatch 

	# 用RPROMPT环境变量用来设置显示在右边的提示符：显示当前git仓库名、分支名和提交状态
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
#***********************************常量、变量及参数设置 结束*****************************************
#*****************************************************************************************************


#*****************************************************************************************************
#*************************************加载oh-my-zsh插件 开始******************************************
	#【【注意：自20190806起在部分机器上尝试使用zplug作为zsh插件管理器】】
if [[ ! -d ~/.zplug/ ]]; then
		# Path to your oh-my-zsh installation.
		# Note: see also: https://ohmyz.sh/ or https://github.com/robbyrussell/oh-my-zsh
	export ZSH="$HOME/.oh-my-zsh"

		# Which plugins would you like to load?
		# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
		# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
		# Example format: plugins=(rails git textmate ruby lighthouse)
		# Add wisely, as too many plugins slow down shell startup.
	plugins=(
			# git插件功能：当处于git受控目录时，zsh会明确提示(如显示分支信息“master”)；
			# 另外，git插件还对很多git命令进行了别名简化，如g=’git’、gd=’git diff’、
			# gco=’git checkout’、gst=’git status’等，熟练使用可大大提高git操作效率
			# 参见：https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
	    git
	
			# dircycle插件功能：可使用Ctrl+Shift+left/right在目录之间来回移动
			# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/dircycle
	    dircycle
	
			# dirhistory插件功能：可用ALT-LEFT移动到用户过去更改的目录，ALT-RIGHT撤消ALT-LEFT，
			# ALT-UP移动到上层目录(相当于“cd ..”)，ALT-DOWN移动到按字母顺序找到的第一个目录
			# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/dirhistory
	    dirhistory
	
			# dirpersist插件功能：此插件保留$HOME/.zdirs文件中前20个唯一目录(即不重复)的运行记录。
			# 当转到新目录时，该新目录会被添加到$HOME/.zdirs文件的开头。 要使用该插件，必须将
			# dirpersist添加到.zshrc文件中的plugins数组中。
			# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/dirpersist
	    dirpersist
	
			# vi-mode插件功能：zsh终端中默认使用的键盘映射为emacs-mode，习惯vim键盘绑定的可通过
			# vi-mode插件来开启
			# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode
	    vi-mode
	
			# autojump插件：历史目录跳转插件；该插件可用z插件代替，z插件无需安装，直接启用即可；
			# 另外，历史目录跳转功能一定程度上也可使用基于fzf自定义的命令(函数)cf来代替
			# 参见：https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/autojump
	    #autojump
	    
			# z插件：历史目录跳转插件；该插件无需安装，直接启用即可。z插件相当于autojump及其
			# 升级版j插件(https://github.com/rupa/j)的升级版
			# 参见：https://github.com/rupa/z
	    z
	    
			# 以下四个插件均来自：https://github.com/zsh-users
	    zsh-autosuggestions
	    zsh-completions
	    zsh-syntax-highlighting
			# zsh-history-substring-search必须在zsh-syntax-highlighting之后启用
	    #zsh-history-substring-search  # history-substring-search为其别名
	    history-substring-search  #已经自带，不需要安装
	
			# fzf插件：模糊查找(即模糊搜索)文件（fzf为fuzzy finder的缩写）
			# 注：虽然新版oh-my-zsh已经自带该插件，可在~/.oh-my-zsh/plugins目录下找到，但还是
			# 必须额外先安装才能使用
			# 参见：https://github.com/junegunn/fzf
	    fzf
	
			# zsh-interactive-cd插件实际上不是oh-my-zsh的插件，因此不需要在这里启用（后文另有启用命令）
			# 参见：https://github.com/changyuheng/zsh-interactive-cd
	    #zsh-interactive-cd  # 该插件基于fzf，必须先安装fzf
	    
			# 参见：https://link.zhihu.com/?target=https%3A//github.com/jeffkaufman/icdiff
	    #icdiff
	    
			# 参见：https://link.zhihu.com/?target=https%3A//github.com/jakubroztocil/httpie/
	    httpie
	
			# 参见：https://link.zhihu.com/?target=https%3A//github.com/dbcli/mycli
	    #mycli
	    
			# 很遗憾，incr还是有些问题，只能弃用之，还是多敲一次Tab键吧
			# 参见：https://github.com/makeitjoe/incr.zsh
	    #incr
	    
			# 注：auto-fu是一个很酷的命令及参数自动实时展示插件，但会导致vi-mode、ctrl-r
			# 等失效，还是使用incr插件部分代替其功能(实际上auto-fu就是基于incr开发的)，
			# 以及多按一些Tab键以使用zsh的自动展示与自动补全功能吧
			# 参见：https://github.com/hchbaw/auto-fu.zsh.git
	    #auto-fu
	)
	
	source $ZSH/oh-my-zsh.sh
	
	if [[ -f ~/.fzf.zsh ]]; then
		source ~/.fzf.zsh
	else
	    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
	    source ~/.fzf.zsh
	fi
	
	if [[ -d ~/.fzf/ && -d ~/.fzf/shell/ ]]; then
		if [[ -f ~/.fzf/shell/zsh-interactive-cd.plugin.zsh ]]; then
			source ~/.fzf/shell/zsh-interactive-cd.plugin.zsh
		else
			wget https://raw.githubusercontent.com/changyuheng/zsh-interactive-cd/master/zsh-interactive-cd.plugin.zsh
			mv zsh-interactive-cd.plugin.zsh ~/.fzf/shell/
			source ~/.fzf/shell/zsh-interactive-cd.plugin.zsh
		fi
	fi
fi
#*************************************加载oh-my-zsh插件 结束******************************************
#*****************************************************************************************************


#*****************************************************************************************************
#*****************************************安装软件 开始***********************************************
    # 创建downloads目录
if [[ ! -d ~/downloads ]]; then
    mkdir ~/downloads
    echo "\nDirectory downloads created successfully.\n"
fi

#-----------------------------------------------------------------------------------------
# 安装sudo命令
#-----------------------------------------------------------------------------------------
if [[ ! -e /usr/bin/sudo ]]; then
    yum install -y sudo
    echo "\nCommand sudo installed.\n"
fi

#-----------------------------------------------------------------------------------------
# 安装回收站工具trash-cli
#-----------------------------------------------------------------------------------------
	# 安装trash-cli：
	#    （注：以下两种安装方式都是全局安装，亦即安装后系统中的所有用户都可以使用trash-cli；
	#          但各用户家目录下的Trash回收站文件夹将在第一次执行trash-put命令后才会创建）
	#     方法一：easy_install trash-cli
	#     方法二：git clone https://github.com/andreafrancia/trash-cli.git && cd trash-cli && sudo python setup.py install
	# 参见：https://github.com/andreafrancia/trash-cli
if [[ ! -e /usr/bin/trash ]]; then
	printf "\nInstall trash-cli? [y/N]: "
    if read -q; then
		echo "\nInstalling trash-cli...\n"
        cd ~/downloads
        git clone https://github.com/andreafrancia/trash-cli.git
        cd trash-cli
        sudo python setup.py install
        echo "\nTrash-cli installed.\n"
    fi
fi

#-----------------------------------------------------------------------------------------
# 安装宝塔面板
#-----------------------------------------------------------------------------------------
    # 宝塔面板官网：https://www.bt.cn
    # 宝塔面板Linux命令大全：https://www.bt.cn/btcode.html
    # 宝塔面板Github仓库：https://github.com/aaPanel/BaoTa
    # 宝塔面板论坛：https://www.bt.cn/bbs
if [[ ! -e /usr/bin/bt ]]; then
	printf "\nInstall BaoTa Panel? [y/N]: "
    if read -q; then
		echo "\nInstalling BaoTa Panel...\n"
		yum install -y wget
		cd ~/downloads
		wget -O install.sh http://download.bt.cn/install/install_6.0.sh
		sh install.sh
        echo "\nBaoTa Panel installed.\n"
    fi
fi

#-----------------------------------------------------------------------------------------
# 安装并初始化nodejs版本管理工具nvm
#-----------------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"

if [[ ! -d "$NVM_DIR" ]]; then
	printf "\nInstall nvm? [y/N]: "
    if read -q; then
		echo "\nInstalling nvm...\n"
		git clone https://github.com/creationix/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
        echo "\nNvm installed.\n"
    fi
fi

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    echo "\nInitialzing nvm..."
    echo "Loading nvm.sh..."
    source "$NVM_DIR/nvm.sh"  # This loads nvm

    if [[ -s "$NVM_DIR/bash_completion" ]]; then
        echo "Loading nvm bash_completion..."
        source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    fi
    
    echo "Nvm initialized."
fi
#-----------------------------------------------------------------------------------------
#*****************************************安装软件 结束***********************************************
#*****************************************************************************************************


#*****************************************************************************************************
#*****************************************定义别名 开始***********************************************
	# Set personal aliases, overriding those provided by oh-my-zsh libs,
	# plugins, and themes. Aliases can be placed here, though oh-my-zsh
	# users are encouraged to define aliases within the ZSH_CUSTOM folder.
	# For a full list of active aliases, run `alias`.
	#
	# Example aliases
#alias zshconfig="mate ~/.zshrc"
#alias ohmyzsh="mate ~/.oh-my-zsh"

# 【【注意：这里定义的别名仅在交互式shell环境中有效，在非交互式shell环境中(比如shell脚本中)则无效】】

	# 默认情况下不允许直接使用rm命令
	# （注：当确实需要使用rm命令来删除文件时，可先通过执行echo rm <*或文件名>
	# 来看下可能将删除哪些文件，这在使用*通配符删除文件时尤其有用）
alias rm='echo_rm_hint'

	# 为了使得后面定义的其他命令的别名在sudo时也能生效，必须设置sudo为“alias sudo='sudo '”，
	# 具体可参考这里：https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

alias mkcd='mcd'

alias mv="setopt noglob; mv_command_hint"

	# 使用trash-cli来代替rm命令
	# 安装trash-cli：
	#    （注：以下两种安装方式都是全局安装，亦即安装后系统中的所有用户都可以使用trash-cli；
	#          但各用户家目录下的Trash回收站文件夹将在第一次执行trash-put命令后才会创建）
	#     方法一：easy_install trash-cli
	#     方法二：git clone https://github.com/andreafrancia/trash-cli.git && cd trash-cli && sudo python setup.py install
	# 参见：https://github.com/andreafrancia/trash-cli
	# trash files and directories
#alias tp="trash-put"
alias tp="setopt noglob; trash-put_command_hint"
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
	#     注：当可用空间小于10240MB(即10GB)时，开始删除超过360天的文件；
	#         当可用空间小于5120MB(即5GB)时，也删除小于360天的文件
	# 参见：https://github.com/bneijt/autotrash （注：该仓库README.md文档中给出的详细介绍链接无法打开，
	#       autotrash的更多详情，另可参见：http://manpages.ubuntu.com/manpages/bionic/man1/autotrash.1.html）

	# 注意：有些文件(比如crontab、visudo等)的编辑默认调用vi进行编辑，会导致出错，因此有必要
	#       将/usr/bin/vi软链接为/usr/bin/vim【注：可通过where和whereis命令查看vi和vim的路径】，
	#       这样在编辑crontab、visudo等文件时，不再调用vi进行编辑，而是调用vim进行编辑：
	#           ln -s /usr/bin/vim /usr/bin/vi
alias vi='vim'
alias vz="vim ~/.zshrc"
alias vzb="vim /bak/rc-bak/.zshrc"
alias sz="source ~/.zshrc"
alias vb="vim ~/.bashrc"
alias vv='vim ~/.vimrc'
alias vvb='vim /bak/rc-bak/.vimrc'

if [[ $USER == "root" ]]; then
    alias tpzswp="tp ~/.vim/swapfiles/%$USER%.zshrc.swp"
    alias tpvswp="tp ~/.vim/swapfiles/%$USER%.vimrc.swp"
else
    alias tpzswp="tp ~/.vim/swapfiles/%home%$USER%.zshrc.swp"
    alias tpvswp="tp ~/.vim/swapfiles/%home%$USER%.vimrc.swp"
fi

alias cls='clear'
alias ll='ls --color -ail'
alias la='ls --color -ai'

	# -a：所有，-n：不显示别名形式，显示数字形式，-p：显示进程信息，
	# -l：仅显示正在监听的端口，-t：仅显示tcp连接，-u：仅显示udp连接
	# 查看所有的网络相关信息，如连接、端口、路由表等
alias nsa="netstat -anp"
	# 仅查看正在监听(listen)的网络相关信息，如连接、端口、路由表等
alias nsl="netstat -lnp"
	# 查看所有tcp连接的网络相关信息，如连接、端口、路由表等
alias nsat="netstat -atnp"
	# 仅查看正在监听(listen)的tcp连接的网络相关信息，如连接、端口、路由表等
alias nslt="netstat -ltnp"
	# 查看所有udp连接的网络相关信息，如连接、端口、路由表等
alias nsau="netstat -aunp"
	# 查看所有tcp、udp连接的网络相关信息，如连接、端口、路由表等
alias nsatu="netstat -atunp"
	# 查看指定的网络相关信息(区分大小写)，如连接、端口、路由表等
alias nsatg="netstat -anpt|grep -nC1 --color=auto"
	# 查看指定的网络相关信息(不区分大小写)，如连接、端口、路由表等
alias nsatgi="netstat -anpt|grep -niC1 --color=auto"
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

	# 使用kill命令杀死进程，必须指定进程PID，因此kill命令使用之前必须使用ps等命令再配合grep来查找PID，
	# 而killall直接指定进程名称即可，把这两个过程合二为一，更为简单快捷。
	# 注：应该总是优先使用15信号(TERM信号)，这也是kill命令的默认信号，即不指定信号则默认使用15信号(TERM信号)；
	#     发送15信号后，等一两秒钟，如果没效果，发送2信号(INT信号)，还不行则发送1信号(HUP信号)，万不得已才用
	#     9信号(KILL信号)
	#     也就是说，杀死进程最安全的方法是单纯使用kill命令，不加修饰符，不带标志，如使用ps -ef|grep process-name命令
	#     确定要杀死进程的PID，然后输入以下命令：
	#         kill PID  或以优雅的方式结束进程：
	#         kill -l PID  # -l选项告诉kill命令用好像启动进程的用户已注销的方式来结束进程。当使用该选项时，
	#                      # kill命令也试图杀死所留下的子进程。但这个命令也不是总能成功--或许仍然需要先手工
	#                      # 杀死子进程，然后再杀死父进程。
	#         注意：标准的kill命令通常都能达到目的。终止有问题的进程，并把进程的资源释放给系统。然而，如果进程
	#               启动了子进程，只杀死父进程，子进程仍可能在运行，因此仍消耗资源。为防止这些所谓的“僵尸进程”，
	#               应确保在杀死父进程之前，先杀死其所有的子进程。
	# 注：pkill命令与killall命令类似，都用于杀死指定名字的进程（kill processes by name）。
	#     不同之处在于，pkill默认使用正则进行模糊匹配，而killall默认使用文本进行精确匹配。
	#     因此，killall对于盲目复制和粘贴的用户而言更为安全。而从两个命令各自的选项功能来看则各有所长，详见各自帮助信息。
alias ka="killall -viI"  # 注：killall命令的进程参数为进程名称(Process Name)，可一次处理同样名称的所有进程
	# 注意：9信号应慎用！
alias k9="kill -9"  # 注：kill命令的进程参数为进程ID(即PID，Process ID)，一次只能处理一个进程

	# 动态跟踪监控文件变化，用于在shell中实时查看日志非常方便
alias tf="tail -F -n 20"

	# 【特别注意：g开头的别名，不要与下面同样是g开头的git别名相冲突了！(注：部分别名覆盖了git插件定义的别名)】
	#
	# -n：输出行号
	# -C1：同时只显示匹配行的前后各1行
	# -E：egrep, Extended grep（即egrep = grep -E）
	# 使用grep查找文件内容时，对于没有查询权限的文件会不断出现Permission denied，导致不容易看到正确的查询结果，
	# 而Permission denied属于错误，将错误(0为标准输入，1为标准输出，2为标准错误)重定向到黑洞文件/dev/null即可,
	# 2>/dev/null相当于将错误不显示出来，也不写入文件，而是直接抛弃掉
alias gg="grep -nC1 -E --color=auto $@ 2>/dev/null"  # 覆盖了git插件所定义的别名：gg="git gui citool"
	# -i：不区分大小(即大小写不敏感)
alias ggi="grep -niC1 -E --color=auto $@ 2>/dev/null"
	# 递归查找文件内容(区分大小写)
	# -r：递归查找当前文件夹及其子文件夹
alias ggr="grep -rnC1 -E --color=auto $@ 2>/dev/null"
	# 递归查找文件内容(不区分大小写)
alias ggri="grep -rniC1 -E --color=auto $@ 2>/dev/null"
	# -o：只输出匹配正则表达式的字符串，而非输出整个匹配行(gnu新版独有, 并非所有版本都支持)
	#     该选项仅显示匹配行中与正则表达式PATTERN相匹配的字符串
alias ggrio="grep -rniC1 -oE --color=auto $@ 2>/dev/null"
	# 递归查找文件内容(不区分大小写，且只在指定文件类型中查找)
	# 比如：grep -rn --include='*.c' --include='*.h' re  或写作：
	#       grep -rn --include='*.[ch]' re
alias ggrn="grep -rnC1 -E --color=auto --include $@ 2>/dev/null"
alias ggrin="grep -rniC1 -E --color=auto --include $@ 2>/dev/null"

# git命令别名【特别注意：g开头的git别名不要与上面同样是g开头的其他别名相冲突了！】
# -------------------------------------------------------------------------------
# 以下为zsh的git插件所定义的git别名
# （参见：https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git）
# -------------------------------------------------------------------
# g	                    git
# ga	                git add
# gaa	                git add --all
# gapa	                git add --patch
# gau	                git add --update
# gb	                git branch
# gba	                git branch -a
# gbda	                git branch --merged | command grep -vE "^(*|\smaster\s$)" | command xargs -n 1 git branch -d
# gbl	                git blame -b -w
# gbnm	                git branch --no-merged
# gbr	                git branch --remote
# gbs	                git bisect
# gbsb	                git bisect bad
# gbsg	                git bisect good
# gbsr	                git bisect reset
# gbss	                git bisect start
# gc	                git commit -v
# gc!	                git commit -v --amend
# gca	                git commit -v -a
# gcam	                git commit -a -m
# gca!	                git commit -v -a --amend
# gcan!	                git commit -v -a -s --no-edit --amend
# gcb	                git checkout -b
# gcf	                git config --list
# gcl	                git clone --recursive  # 注：被自定义的gcl="git clone"覆盖，取而代之的是：gclr
# gclean	            git clean -df
# gcm	                git checkout master
# gcd	                git checkout develop
# gcmsg	                git commit -m
# gco	                git checkout
# gcount	            git shortlog -sn
# gcp	                git cherry-pick
# gcpa	                git cherry-pick --abort
# gcpc	                git cherry-pick --continue
# gcs	                git commit -S
# gd	                git diff
# gdca	                git diff --cached
# gdt	                git diff-tree --no-commit-id --name-only -r
# gdw	                git diff --word-diff
# gf	                git fetch
# gfa	                git fetch --all --prune
# gfo	                git fetch origin
# gg	                git gui citool  注：被自定义的gg="grep -nC1 -E --color=auto $@ 2>/dev/null"覆盖
# gga	                git gui citool --amend
# ggf	                git push --force origin $(current_branch)
# ghh	                git help
# ggpull	            ggl
# ggpush	            ggp
# ggpur	                ggu
# ggl                   git pull origin $(current_branch)
# ggp                   git push origin $(current_branch)
# ggu                   git pull --rebase origin $(current_branch)
# ggsup	                git branch --set-upstream-to = origin/$(current_branch)
# gpsup	                git push --set-upstream origin $(current_branch)
# gignore	            git update-index --assume-unchanged
# gignored	            git ls-files -v | grep "^:lower:"
# git-svn-dcommit-push	git svn dcommit && git push github master:svntrunk
# gk	                \gitk --all --branches
# gke	                \gitk --all $(git log -g --pretty = format:%h)
# gl	                git pull  # 注：下面还同时自定义了gpl="git pull"
# glg	                git log --stat --color
# glgg	                git log --graph --color
# glgga	                git log --graph --decorate --all
# glgm	                git log --graph --max-count = 10
# glgp	                git log --stat --color -p
# glo	                git log --oneline --decorate --color
# glog	                git log --oneline --decorate --color --graph
# glol	                git log --graph --pretty = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
# glola	                git log --graph --pretty = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all
# glp	                _git_log_prettily
# gm	                git merge
# gmom	                git merge origin/master
# gmt	                git mergetool --no-prompt
# gmtvim	            git mergetool --no-prompt --tool = vimdiff
# gmum	                git merge upstream/master
# gp	                git push  # 注：下面还同时自定义了gps="git push"
# gpd	                git push --dry-run
# gpoat	                git push origin --all && git push origin --tags
# gpristine	            git reset --hard && git clean -dfx
# gpu	                git push upstream
# gpv	                git push -v
# gr	                git remote
# gra	                git remote add
# grb	                git rebase
# grba	                git rebase --abort
# grbc	                git rebase --continue
# grbi	                git rebase -i
# grbm	                git rebase master
# grbs	                git rebase --skip
# grh	                git reset HEAD
# grhh	                git reset HEAD --hard
# grmv	                git remote rename  # 注：下面还同时自定义了grrn="git remote rename"
# grrm	                git remote remove
# grset	                git remote set-url
# grt	                cd $(git rev-parse --show-toplevel || echo ".")
# gru	                git reset --
# grup	                git remote update
# grv	                git remote -v  # 注：被自定义的grv="git revert"覆盖，取而代之的是：grm
# gsb	                git status -sb  # 注：被自定义的gsb="git submodule"覆盖，取而代之的是：gssb
# gsd	                git svn dcommit
# gsi	                git submodule init
# gsps	                git show --pretty = short --show-signature
# gsr	                git svn rebase
# gss	                git status -s
# gst	                git status  # 注：下面还同时自定义了gs="git status"
# gsta	                git stash save
# gstaa	                git stash apply
# gstd	                git stash drop
# gstl	                git stash list
# gstp	                git stash pop
# gstc	                git stash clear
# gsts	                git stash show --text
# gsu	                git submodule update
# gts	                git tag -s
# gunignore	            git update-index --no-assume-unchanged
# gunwip	            git log -n 1 | grep -q -c "--wip--" && git reset HEAD~1
# gup	                git pull --rebase
# gupv	                git pull --rebase -v
# glum	                git pull upstream master
# gvt	                git verify-tag
# gwch	                git whatchanged -p --abbrev-commit --pretty = medium
# gwip	                git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
# 下面为自定义的git别名，会覆盖上面的git插件定义的同名别名
# （注：被注释的别名，与git插件定义的别名重复）
#-----------------------------------------------------------------------------------------
#alias ga="git add"  # 注：上面已定义了同名别名
alias gai="git add .ideavimrc"
#alias gb="git branch"  # 注：上面已定义了同名别名
#alias gc="git commit"  # 注：上面已定义了同名别名
alias gcl="git clone"  # 注：覆盖了上面定义的git clone --recursive（以下行定义的gclr代替）
alias gclr="git clone --recursive"
#alias gco="git checkout"  # 注：上面已定义了同名别名
#alias gd="git diff"  # 注：上面已定义了同名别名
#alias gf="git fetch"  # 注：上面已定义了同名别名
alias gi="git init"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
#alias gm="git merge"  # 注：上面已定义了同名别名
alias gps="git push"  # 注：上面同时还定义了gp="git push"
alias gpsom="git push origin master"
alias gpl="git pull"  # 注：上面同时还定义了gl="git pull"
alias gplom="git pull origin master"
alias grs="git reset"
#alias grb="git rebase"  # 注：上面已定义了同名别名
alias grt="git revert"
alias grm="git rm"
alias grmc="git rm --cached -r"  # -r，递归删除
alias grmcf="git rm --cached --force -r"
alias grrn="git remote rename"  # 注：上面同时还定义了grmv="git remote rename"
	#origin一般习惯指向上位仓库(即上游仓库，比如github中的仓库)（可在各个git仓库的配置文件.git/config中修改）
alias grao="git remote add origin"
	#condingnet指的是码市conding.net
alias grac="git remote add codingnet"
alias gs="git status"  # 注：上面同时还定义了gst="git status"
alias gssb="git status -sb"
alias gsb="git submodule"  # 注：覆盖了上面定义的git status -sb
alias gsh="git show"
alias gt="git tag"
#-----------------------------------------------------------------------------------------

alias slog="socketlog-server > /dev/null &"

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
#*****************************************定义别名 结束***********************************************
#*****************************************************************************************************


#*****************************************************************************************************
#****************************************自定义函数 开始**********************************************
	# 创建一个目录并进入该目录里：mcd [目录名]；
	# 默认mkdir一次只能创建一层目录，如果在当前目录下创建一个div/css这样的多层目录就需要逐层创建：
	# 先mkdir div，然后cd div，然后再mkdir css；加上-p参数，可一次性创建：mkdir -p div/css
	# -p参数：表示创建一条完整的路径(当路径中的某个目录已经存在时，跳过该目录继续创建下一级目录)；
mcd() { mkdir -p "$1"; cd "$1";}

	# 类似上一个函数，进入一个目录并列出它的内容：cdls [目录名]
cdls() { cd "$1"; ls;}
cdll() { cd "$1"; ll;}

	# 简单的给文件创建一个备份：bak [文件]，将会在同一个目录下创建 [文件].bak
bak() { cp "$1"{,.bak};}

	# 如果不喜欢通过手工比较文件的md5校验值，这个函数会计算它并进行比较：md5check [文件] [校验值]
md5check() { md5sum "$1" | grep "$2";}

	# 找到某个文件后用vim打开该文件(如果有多个同名文件，则只能打开第一个文件)
#vfin() {vim $(find / -iname "$1")}

	# 将找到的所有文件用vim以标签页的形式全部打开(一个文件一个标签，可用:tabn、:tabp切换)
#vmfin() {find / -iname "$1" -exec vim -p {} +}

	# 使用fzf列出当前目录下的文件(即只查找当前目录及其子目录中的文件)，然后选择一个用vim打开
	# 注：vcf——vim current-directory's file
vcf() {vim $(fzf)}

	# 使用locate命令全局查找文件(即从根目录开始查找)，然后用fzf进行选择后用Vim打开选择的文件
vf() {
    local file

    	# 更新locate索引数据库
    	# 【【注意：在某些情况下(比如安装了大量软件之后)，updatedb的过程可能会耗时较长(从几秒到几十秒不等)，
    	# 这时可通过另开一个终端会话窗口的办法来规避】】
    sudo updatedb
  
    	# locate -Ai -0 $@：
    	#     -A：匹配列出的所有模式
    	#         注：CentOS 6中0.22版的mlocate不支持-A参数，貌似该参数为默认参数(？)
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
    #file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
  	    # CentOS6中0.22版的mlocate不支持-A参数，貌似该参数为默认参数(？)
    file="$(locate -i -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
    #file="$(locate -Ai -0 $@ | fzf --read0 -0 -1)"
  
    vim "${file}"
}

	# cf - fuzzy cd from anywhere
	# ex: cf word1 word2 ... (even part of a file name)
	# zsh autoload function
cf() {
    local file
  
    sudo updatedb

    	#file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
    	# 注：CentOS6中0.22版的mlocate不支持-A参数，貌似该参数为默认参数(？)
    file="$(locate -i -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
  
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

echo_rm_hint() {
    echo Don\'t use \'rm\'. Try to use trash related commands.; false
}

pathReg1="^/$|^/\*$|^/bin/?$|^/data/?$|^/etc/?$|^/media/?$|^/opt/?$|^/sbin/?$|^/usr/?$|^/var/?$|^/root/?$|^/home/?$|^/lib/?$|^/lib64/?$|^/test/?$"
pathReg2="^/bin/.+|^/data/.+|^/etc/.+|^/media/.+|^/opt/.+|^/sbin/.+|^/usr/.+|^/var/.+|^/root/.+|^/home/.+|^/lib/.+|^/lib64/.+|^/test/.+"

mv_command_hint() {
    #echo $1
    if [[ "$1" =~ $pathReg1 ]]; then
        echo WARNING: The operation is not allowed: mv $1 to $2.
        setopt glob
    elif [[ "$1" =~ $pathReg2 ]]; then
        setopt glob
        printf "\nWARNING: Are you sure you want to do this: mv $1 to $2? [Y/n]"
        if read -q; then
            echo "\nMoving $1 to $2..."
                # \mv表示调用系统原生的mv命令，而非mv别名命令
                # 这里若不用\mv调用系统原生的mv命令，会导致死循环，因为本函数即用于mv别名命令的定义中
            \mv $1 $2
                # 如果执行没有出错
            if [[ $? == 0 ]]; then
                echo Moved.
            fi
        fi
    else
        setopt glob
        \mv $1 $2
            # 如果执行没有出错
        if [[ $? == 0 ]]; then
            echo "\nThe mv command is executed."
        fi
    fi
    #echo $1
}

trash-put_command_hint() {
    #echo $1
    if [[ "$1" =~ $pathReg1 ]]; then
        echo WARNING: The operation is not allowed: trash-put $1.
        setopt glob
    elif [[ "$1" =~ $pathReg2 ]]; then
        setopt glob
        printf "\nWARNING: Are you sure you want to do this: trash-put $1? [Y/n]"
        if read -q; then
            echo "\n"
            trash-put $1
                # 如果执行没有出错
            if [[ $? == 0 ]]; then
                echo "Trash-put $1 successfully."
            fi
        fi
    else
        setopt glob
        trash-put $1
            # 如果执行没有出错
        if [[ $? == 0 ]]; then
            echo "\nThe trash-put command is executed."
        fi
    fi
    #echo $1
}
#****************************************自定义函数 结束**********************************************
#*****************************************************************************************************
