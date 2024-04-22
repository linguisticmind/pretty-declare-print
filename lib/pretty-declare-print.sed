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

# Run this script as follows: sed -nEf <script>

1 {
  h
  n
}

/^declare -[aA][^=]*=\(\[/! p

/^declare -[aA][^=]*=\(\[/ {
  {
    H
    x
    s/\n/\x0/
    s/^(.*\x00declare -[aA][^=]*=\()(.*)/\1/
    x
  }
  s/^declare -[aA][^=]*=\(|\s*\)$//g
  s/(^|\s+)(\[([^]]*|"([^"]|\\")*"|\$'([^']|\\')*')\]=("([^"]|\\")*"|\$'([^']|\\')*'))/\2\n/g
  x
  G
  h
  s/\s*$//
  s/'/'\\''/g
  s/^(.*)\x00(.*)\x00([^\n]*)\n(.*)/printf '%s' '\2' | \/usr\/bin\/env bash '\1'\/format_array.bash '\3' '\4'/ge
  p
  {
    x
    s/^(.*)\x00(.*)/\1/
    x
  }
}
