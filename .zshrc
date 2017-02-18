# 日本語に設定
export LANG=ja_JP.UTF-8
# エディタをvimに設定
export EDITOR=vim

# おまい fr Pandoc in WSL
export GHCRTS=-V0

PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

autoload -U compinit
compinit -u
autoload zmv
autoload -U colors; colors

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zaw"
zplug "zsh-users/zsh-history-substring-search"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-autosuggestions"

zplug load --verbose

# dircolors-solarizedを適用
eval $(dircolors ~/dircolors-solarized/dircolors.ansi-universal)
# eval $(dircolors ~/solarized/dircolors-solarized/dircolors.256dark)

# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
if [ -n "$LS_COLORS" ]; then
        zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi        

### 履歴の設定 ### 
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数

# Ctrl-h でzaw-history
bindkey '^h' zaw-history

autoload history-search-end  
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Ctrl-P, N で逆、順方向に履歴検索。
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

# Ctrl-R, X でインクリメンタルから逆、順方向に履歴検索
bindkey "^R" history-incremental-search-backward
bindkey "^X" history-incremental-search-forward

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 余分な空白は詰めて記録
setopt hist_reduce_blanks  

# 古いコマンドと同じものは無視 
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開         
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

# 補間の際に、[tab]で選択できるようにする。
zstyle ':completion:*default' menu select=2

# ディレクトリ名+Enterでcd
setopt auto_cd
# コマンドのスペルを訂正する
setopt correct
# =以降も補完する(--prefix=/usrなど)
setopt magic_equal_subst 

# 補間時にセパレータを表示する
zstyle ':completion:*' list-separator '-->'
# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 

# apt-getとかdpkgコマンドをキャッシュを使って速くする
zstyle ':completion:*' use-cache true

# 全履歴を一覧表示する
functions history-all() { history -E l }

# 重複を記録しない
setopt hist_ignore_dups 

# 出力時に8bitを通す
setopt print_eight_bit

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# spellcheck
setopt correct 

### Prompt ###
# 一般ユーザ時
tmp_prompt="%n@%m%# "
tmp_prompt2="%_> "
tmp_rprompt=" [%~]"
tmp_sprompt="%r is correct? [Yes, No, Abort, Edit]: "

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
          tmp_prompt="%B%U${tmp_prompt}%u%b"
            tmp_prompt2="%B%U${tmp_prompt2}%u%b"
              tmp_rprompt="%B%U${tmp_rprompt}%u%b"
                tmp_sprompt="%B%U${tmp_sprompt}%u%b"
                fi

                PROMPT=$tmp_prompt    # 通常のプロンプト
                PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
                RPROMPT=$tmp_rprompt  # 右側のプロンプト
                SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
                [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
                  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
                  ;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm)
  precmd() {
              echo -ne "\033]0;${USER}@${HOST%%.*}\007"
                }
                  ;;
                  esac


# alias
alias ls='ls -aF --color'
alias ...='../../'
alias zmv='noglob zmv'
alias ffind='find . -type f'
alias rm='safe-rm -i'
alias activate="source $PYENV_ROOT/versions/miniconda3-latest/bin/activate"

# alias suffix
alias -s rb='ruby'
alias -s py='python'

# alias -g
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'
alias -g N='| nkf'
alias -g X='| xargs'
