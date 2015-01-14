function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#changing mode clobbers the keybinds, so store the keybinds before and execute 
#them after
binds=`bindkey -L`
bindkey -v
for bind in ${(@f)binds}; do eval $bind; done
unset binds

CMD_INDICATOR="%{$fg_bold[red]%}*%{$fg[red]%}%{$reset_color%}"
INS_INDICATOR="%{$fg_bold[red]%} %{$fg[red]%}%{$reset_color%}"

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$CMD_INDICATOR}/(main|viins)/$INS_INDICATOR}"
}

bindkey -M viins 'jk' vi-cmd-mode
