# This is an alternative approach. Single line minimalist in git repo.
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"

  function prompt_callback {
    local PS1="$(gp_truncate_pwd)"
    gp_set_window_title "$PS1"
  }

  Time12a="\$(date +%H:%M:%S)"
  PathShort="\W";

  GIT_PROMPT_PREFIX="["
  GIT_PROMPT_SUFFIX="]"
  GIT_PROMPT_SEPARATOR=" "
  GIT_PROMPT_STAGED="${Red}●${ResetColor}"
  GIT_PROMPT_CONFLICTS="${Red}✖${ResetColor}"
  GIT_PROMPT_CHANGED="${Blue}✚${ResetColor}"
  GIT_PROMPT_UNTRACKED="${Cyan}…${ResetColor}"
  GIT_PROMPT_STASHED="${BoldBlue}⚑${ResetColor}"
  GIT_PROMPT_CLEAN="${BoldGreen}✔${ResetColor}"

  GIT_PROMPT_COMMAND_OK="${Green}✔"
  GIT_PROMPT_COMMAND_FAIL="${Red}✘"

  KUBE_PS1_SYMBOL_COLOR=33
  KUBE_PS1_PREFIX=" ("
  source $HOME/Code/jonmosco/kube-ps1/kube-ps1.sh

  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${White}${Time12a}${ResetColor} ${Cyan}${PathShort}${ResetColor}"
  GIT_PROMPT_END_USER="${ResetColor}\$(kube_ps1) $ "
  GIT_PROMPT_END_ROOT="${ResetColor}\$(kube_ps1) ${BoldRed}# "
}

reload_git_prompt_colors "Custom"
