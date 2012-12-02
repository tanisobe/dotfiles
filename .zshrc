################################################################################
##
##  .zshrc
##      zsh の初期設定
##
################################################################################




################################################################################
##
##  シェル変数・環境変数 (環境別の設定，.zshenv などに書くテンプレート)
##
################################################################################
## テンポラリディレクトリ
# TEMP_DIR="/tmp/${USER}";
# VAR_TEMP_DIR="/var/tmp/${USER}";
# [[ -d ${TEMP_DIR} ]] || mkdir -m 700 ${TEMP_DIR}
# [[ -d ${VAR_TEMP_DIR} ]] || mkdir -m 700 ${VAR_TEMP_DIR}
## 補完のキャッシュファイル
# ZCOMPDUMP="${TEMP_DIR}/zcompdump"
## 言語環境
# export LANG='ja_JP.eucJP'
export LANG='ja_JP.UTF-8'
## ls のカラー表示オプション
 LS_COLOR_OPTION='-G'
#LS_COLOR_OPTION='--color'
## ls & 補完候補の色付け
##- 通常
#export LSCOLORS='exfxcxdxbxegedabagacad'
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
##- 背景が黒で青が見えにくい場合
 export LSCOLORS='gxfxcxdxbxegedabagacad'
 export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# export EDITOR='emacs'					# エディタ
export EDITOR=emacsclient
export VISUAL=emacsclient
# export PAGER='less'						# ページャ
# export LESS='-R --tabs=4 --no-init --LONG-PROMPT --ignore-case'	#- less 実行時のオプション
 export CC='gcc'							# C コンパイラ
 export CXX='g++'						# C++ コンパイラ
# export SCREENDIR="${HOME}/.screen"		# screen のセッション保存先
# export GNUTERM='x11'					# gnuplot の標準のターミナル
# export OMP_NUM_THREADS=2				# OpenMP でのスレッド数
#rsenseのせってい




################################################################################
##
##  zsh function
##
################################################################################
autoload -Uz zed				##- 簡易テキストエディタ
autoload -Uz zmv				##- リネーム (zmv -W 'hoge.*' 'moge.*')
autoload -Uz colors;			##- 色の記述を簡単に
colors							##-- colors の初期化





################################################################################
##
##  zsh option
##
################################################################################
setopt correct				##- コマンド補正
setopt extended_glob		##- グロッピング拡張




################################################################################
##
##  dir 操作
##
################################################################################
##--------------------------------------
## environment variable  (p. 50)
##--------------------------------------
cdpath=( ${HOME} )			##- カレントに指定した dir がない場合，${cdpath} を基準に移動を試みる
DIRSTACKSIZE=20				##- dirスタックのサイズ
##--------------------------------------
## option  (pp. 50-51)
##--------------------------------------
setopt auto_cd				##- dir 名だけで cd
setopt auto_name_dirs		##- 代入直後から名前付きdirを有効に
setopt auto_pushd			##- dir 移動で自動的に push
setopt cdable_vars			##- dir が存在しない場合，名前付きdirへの移動を試みる
setopt pushd_ignore_dups	##- dirスタックの内容と同じ dir を push しない
setopt pushd_to_home		##- pushd の引数がない場合，${HOME} へ移動




################################################################################
##
##  history
##
################################################################################
##--------------------------------------
## environment variable (p. 54)
##--------------------------------------
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
##--------------------------------------
## option (pp. 68-72)
##--------------------------------------
setopt extended_history		##- history file を拡張フォーマットで保存
setopt hist_ignore_all_dups	##- history に重複があった場合は古い方を削除
setopt hist_ignore_dups		##- 直前と同じコマンドを記録しない
setopt hist_ignore_space	##- 先頭に space で記録しない
setopt hist_reduce_blanks	##- history に追加する際に無駄な space を削除
setopt hist_save_no_dups	##- history file に保存する際，重複があった場合は古い方を削除
setopt hist_verify			##- 編集して実行できるように
setopt share_history		##- history を すべての zsh プロセスで共有




################################################################################
##
##  command complete
##
################################################################################
## 補完機能の読み込みと初期化
autoload -Uz compinit		##- コマンド補間
##- compinitの初期化
[[ -n ${ZCOMPDUMP} ]] && compinit -d ${ZCOMPDUMP} || compinit
# autoload -Uz predict-on; 	##- 予測補間
# predict-on				##- predict-onの初期化
##--------------------------------------
## option (pp. 131-135)
##--------------------------------------
setopt always_last_prompt	##- 候補一覧を表示しても元の prompt に留まる
setopt complete_in_word		##- 文字列の途中でもカーソル一位置で補完
setopt auto_list			##- 候補が複数あるとき，自動的に一覧を出す
setopt auto_menu			##- 補完キーの連打でメニュー補完に移行
setopt auto_param_keys		##- 変数名のカッコ対応などを自動的に補完
setopt auto_param_slash		##- dir の補完で / を自動的に付加
setopt auto_remove_slash	##- auto_param_slash で付加された / を，次の入力がデリミタの場合削除
setopt glob_complete		##- グロッビングパターンを展開せずに，メニュー補完
setopt hash_list_all		##- 補完時にコマンドハッシュを確認
setopt list_ambiguous
setopt list_beep			##- 補完結果が1つに確定しない場合，beep
setopt list_packed			##- 補間一覧を詰めて表示
# setopt list_rows_first		##- 候補一覧の移動を横に
setopt list_types			##- 候補一覧にファイル種別を表す記号を付加
##--------------------------------------
## 補完スタイル (pp. 135-)
##--------------------------------------
## メニュー補完を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補・メッセージ・警告の共通スタイル
##- 補完候補を沢山???
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
		# _complete		普通の補完関数
		# _approximate	ミススペルを訂正した上で補完を行う．
		# _match		*などのグロブによってコマンドを補完できる(例えばvi* と打つとviとかvimとか補完候補が表示される)
		# _expand		グロブや変数の展開を行う．もともとあった展開と比べて、細かい制御が可能
		# _history		履歴から
##- 補完一覧の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
##- 補完一覧をグループ表示
zstyle ':completion:*' group-name ''
##- その他
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:messages' format '%{[33m%}%d%{[m%}'
zstyle ':completion:*:warnings' format '%{[31m%}No matches for: %{[33m%}%d%{[m%}'
zstyle ':completion:*:descriptions' format '%{[32m%}-- %d%{[m%}'

## 小文字の文字列で補完した場合，大文字にもマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## cd なしの dir 移動で dir を補完候補の最初に
##- 検索順
zstyle ':completion:*' tag-order local-directories 'path-directories named-directories'
##- 表示順
zstyle ':completion:*' group-order local-directories path-directories named-directories

## cd
##- cd の検索順
zstyle ':completion:*:cd:*' tag-order local-directories 'path-directories named-directories'
##- cd の表示順
zstyle ':completion:*:cd:*' group-order local-directories path-directories named-directories
##- cd は親dir からカレントdir を選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

## その他
##- ~/.ssh/configで設定したホスト名を ssh などの補完候補に
zstyle ':completion:*:hosts' hosts




################################################################################
##
##  prompt
##
################################################################################
## プロンプト
PROMPT="%n@%m: %{${fg[green]}%}%c %#%{${reset_color}%} "
PROMPT2="%{${fg[red]}%}%_%#%{${reset_color}%} "
## コマンドを間違えたときの修正するか否かのメッセージ
SPROMPT="correct: %R -> %r ? [n,y,a,e]: "
## 右プロンプト
RPROMPT="%{${bg[green]}${fg[black]}%} %~ %{${reset_color}%}"




################################################################################
##
##  SSH環境・端末環境別の設定
##
################################################################################
## ssh 環境用
if [[ -n ${SSH_TTY} ]]; then
	##- プロンプト
	PROMPT="%{${bg[red]}%}%n@%m%{${reset_color}%}: %{${fg[green]}%}%c %#%{${reset_color}%} "
fi


## screen 環境用
if [[ -n ${STY} ]]; then
	##- preexec 用のコマンド (一覧表示名をコマンドに変える)
	alias preexec_screen='print -n "\ek@_${1%% *}\e\\"'
	##- precmd 用のコマンド (一覧表示名をディレクトリに変える)
	alias precmd_screen='print -n "\ek${PWD##*/}\e\\"'
	##- ssh のホスト名を一覧表示名に
	function ssh ()
	{
		screen -t "ssh ->${@[${#}]}" ssh "${@}"
	}
else
	alias preexec_screen=''
	alias precmd_screen=''
fi


## Emacs 環境用
if [[ -n ${EMACS} ]]; then
	##- Emacs 環境でコマンドを禁止する
	#alias emacs='print "@emacs!!!"'
fi




################################################################################
##
##  VCS INFO (バージョン管理システムの支援機能)
##
################################################################################
## version >= 4.3.6 なら vcs_info を有効に
if [[ ${${(s:.:)ZSH_VERSION}[1]} -gt 4 ]]; then
	VCS_INFO_ENABLE=true
elif [[ ${${(s:.:)ZSH_VERSION}[1]} -eq 4 ]]; then
	if [[ ${${(s:.:)ZSH_VERSION}[2]} -gt 3 ]]; then
		VCS_INFO_ENABLE=true
	elif [[ ${${(s:.:)ZSH_VERSION}[2]} -eq 3 ]]; then
		[[ ${${(s:.:)ZSH_VERSION}[3]} -ge 6 ]] && VCS_INFO_ENABLE=true
	fi
fi


## 有効な場合の設定
if [[ -n ${VCS_INFO_ENABLE} ]]; then
	##- VCS INFO を有効に
	autoload -Uz vcs_info
	##- 右プロンプトに追加
	RPROMPT="%1(v|%F{green}%1v%f|)${RPROMPT}"
	##- 表示設定
	zstyle ':vcs_info:*' formats '[%b (%s)] %S '
	zstyle ':vcs_info:*' actionformats '[%b|%a (%s)] %S '
	##- precmd 用のコマンド
	alias precmd_vcs_info='LANG=en_US.UTF-8 vcs_info; psvar[1]="${vcs_info_msg_0_}"'
else
	alias precmd_vcs_info=''
fi
unset VCS_INFO_ENABLE




################################################################################
##
##  コマンド実行前，プロンプト表示前に実行される関数
##
################################################################################
## コマンド実行前に実行される
function preexec ()
{
	preexec_screen
}


## プロンプト表示前に実行される
function precmd ()
{
	precmd_screen
	precmd_vcs_info
}




################################################################################
##
##  key bind
##
################################################################################
## Emacs風
bindkey -e
## 履歴検索
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
## 補完リストで ^P, ^N を有効に
zmodload -i zsh/complist
bindkey -M menuselect \
	"^P" up-line-or-history \
	"^N" down-line-or-history




################################################################################
##
##  alias
##
################################################################################
alias history-all='history -E 1'
setopt complete_aliases
## グローバルエイリアス
alias -g I=/dev/stdin
alias -g O=/dev/stdout
alias -g E=/dev/stderr
alias -g N=/dev/null
alias -g LE="| ${PAGER}"
alias -g G='| grep'
alias -g X='| xargs'
## その他
alias where='command -v'
alias j='jobs -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l="ls ${LS_COLOR_OPTION} -a"
alias ls="ls ${LS_COLOR_OPTION}"
alias la="ls ${LS_COLOR_OPTION} -a"
alias lf="ls ${LS_COLOR_OPTION} -F"
alias ll="ls ${LS_COLOR_OPTION} -lh"
alias lla="ls ${LS_COLOR_OPTION} -lah"
alias du='du -h'
alias df='df -h'
alias su='su -l'
alias zmv='noglob zmv'
#alias emc='emacs -nw'
alias ec='emacsclient'
#alias es='emacs -fs --iconic &'
#alias r='rails'
alias cd..='cd ..'
## nkf による文字コード変換
#if ( whence nkf > /dev/null 2>&1 ); then
if [[ -x $( whence nkf ) ]]; then
	alias utf='nkf -w -Lu --overwrite'		#- utf8-jp
	alias euc='nkf -e -Lu --overwrite'		#- euc-jp
	alias sjis='nkf -s -Lu --overwrite'		#- shift-jis
fi




################################################################################
##
##  自分用の設定 & その他の設定を読み込み
##
################################################################################
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
#export
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig"
# MacPorts Installer addition on 2010-06-25_at_20:56:19: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages
# Finished adapting your PATH environment variable for use with MacPorts.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
route add -net add default 10.1.0.0/16 10.2.128.10
