function bat_or_cat {

  local bat_bin

  for bat_bin in bat batcat; do
    type -P "$bat_bin" > /dev/null && break
    bat_bin=
  done

  case $bat_bin in
    bat | batcat ) "$bat_bin" --language='bash' --style='plain' --paging='never' --color='never' ${opt_color:+--color='auto'} "${opt_bat_opts[@]}" ${bat_color_override:+--color="$bat_color_override"} ${bat_paging_override:+--paging="$bat_paging_override"} -- "$@" ;;
    * ) cat -- "$@" ;;
  esac

}
