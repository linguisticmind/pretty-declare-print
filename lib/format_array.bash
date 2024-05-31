# pretty-declare-print - prettify output of declare -p
# copyright (c) 2024  Alex Rogers (https://github.com/linguisticmind)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

eval "$(</dev/stdin)"

printf '%s' "$1"
[[ $opt_multiline_arrays ]] && printf '\n'

if [[ $opt_sort_associative_arrays && $1 = 'declare -A '* ]]; then
  <<<"$2" sort "${opt_sort_opts[@]}" 
else
  printf '%s\n' "$2"
fi |

if [[ $opt_multiline_arrays ]]; then
  sed -E 's/^\[/'"$(printf ' %.s' $(seq 1 "$opt_multiline_arrays_indent"))"'&/'
  printf '%s\n' ')'
else
  case $1 in
    'declare -a'* ) closing_parenthesis=')' ;;
    'declare -A'* ) closing_parenthesis=' )' ;;
  esac
  sed -E '$ ! { :a; N; $ ! b a }; s/\n/ /g; s/$/'"$closing_parenthesis"'/'
fi
