
# ==================== functions

# $1: text color number
# $2: background color number
# $3: content
# Command to show palette:
#   $ for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
coloring () {
    echo "%F{$1}%K{$2}$3%k%f"
}

# ~///path
get_directory () {
    ruby $SIMPLEMOON_ROOT_PATH/path.rb
}

# ==================== git

autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' max-exports 3                  # Get value $vcs_info_msg_0_, $vcs_info_msg_1_ ...
zstyle ':vcs_info:git:*' check-for-changes true     # In order to use %c, %u
zstyle ':vcs_info:git:*' stagedstr ':'              # %c
zstyle ':vcs_info:git:*' unstagedstr '.'            # %u
zstyle ':vcs_info:*' formats '%b' '%c%u'            # %b branch
zstyle ':vcs_info:*' actionformats '%b' '%c%u' '%a' # %a action (e.g. merge)
zstyle ':vcs_info:git+set-message:*' hooks git-hook

function +vi-git-hook() {

    # .git 内などは呼ばない
    if [[ `command git rev-parse --is-inside-work-tree 2> /dev/null` != 'true' ]]; then
        return 1
    fi

    # untracked file
    UNTRACKED_FILE_COUNT=`git status -s | grep "^??" | wc -l`
    if [[ $1 != '1' && $UNTRACKED_FILE_COUNT -ge 1 ]]; then
        hook_com[unstaged]+='.'
    fi
}

# ==================== precmd

precmd () {

    # first - username
    PROMPT=`coloring 231 70 ' %n '`

    # second - directory
    PROMPT=$PROMPT`get_directory`

    # third - git
    vcs_info
    if test -n "$vcs_info_msg_0_"; then
        git_infos=()
        test -n "$vcs_info_msg_0_" && git_infos+=( "$vcs_info_msg_0_" )
        test -n "$vcs_info_msg_1_" && git_infos+=( "$vcs_info_msg_1_" )
        git_info="${(j: :)git_infos}"
        PROMPT=$PROMPT`coloring 231 202 ' $git_info '`
    fi

    # fourth - git (if exists action)
    test -n "$vcs_info_msg_2_" && PROMPT=$PROMPT`coloring 231 196 ' $vcs_info_msg_2_ '`

    # last
    PROMPT=$PROMPT' '
}

export SIMPLEMOON_ROOT_PATH=`dirname $0`
