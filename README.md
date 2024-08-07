# pretty-declare-print

`pretty-declare-print` allows the user to easily view contents of Bash variables by formatting the output of Bash's `declare` builtin when run with the `-p` option. It can also be used to view values of special and positional paramaters, which can't normally be displayed with `declare -p`, by creating temporary arrays to hold the values of those parameters.

For more information on parameters in Bash, see https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameters

Run `help declare` for more information on the `declare` builtin.

Video tutorial:

[![Mindful Technology - [Bash scripting #6] declare -p + pretty-declare-print: a better way to view values of Bash variables](https://img.youtube.com/vi/lO6avzX2QBg/0.jpg)](https://www.youtube.com/watch?v=lO6avzX2QBg)

<a href='https://ko-fi.com/linguisticmind'><img src='https://github.com/linguisticmind/linguisticmind/raw/master/res/kofi/kofi_donate_1.svg' alt='Support me on Ko-fi' height='48'></a>

## Changelog

<table>
    <tr>
        <th>Version</th>
        <th>Date</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.6'>0.1.6</a>
        </td>
        <td>
            2024-06-20
        </td>
        <td>
            Fixed incorrect handling of options to <code>sed</code>. A <code>sed</code> filter would break if the script part (which follows the options string) contained a double hyphen (<code>--</code>) surrounded by one or more spaces.
        </td>
    </tr>
</table>

[Read more](CHANGELOG.md)

## Dependencies

### bat

`pretty-declare-print` requires [`bat`](https://github.com/sharkdp/bat) to be installed to enable syntax highlighting in the output. If `bat` is not installed, syntax highlighting will not be available.

On Debian, run `sudo apt install bat` to install it.

Note that on Debian, `bat`'s executable is [called `batcat` instead of `bat`](https://github.com/sharkdp/bat/issues/982).

### Other

`pretty-declare-print` was written and tested on Debian 12, and takes advantage of standard utilities that come with the system. In order to run `pretty-declare-print` on other systems, make sure that the following are installed and available on system's `PATH`:

* Bash >= 5.2.15
* Enhanced getopt
* GNU coreutils
* GNU sed

## Installation

1. Clone this repository to a directory of your choice (e.g. `~/repos`):

    ```bash
    cd ~/repos
    git clone https://github.com/linguisticmind/pretty-declare-print.git
    ```

2. Symlink or copy the [script file](pretty-declare-print) to a directory on your `PATH` (e.g. `~/bin`):

    ```bash
    cd ~/bin
    # To symlink:
    ln -sv ../repos/pretty-declare-print/pretty-declare-print
    # To copy:
    cp -av ../repos/pretty-declare-print/pretty-declare-print .
    ```

    Symlinking is recommended, otherwise you will have to do an additional step (see step 3).

3. If you copied the script file in step 2 instead of symlinking it, you will also need to copy the [`lib`](lib) directory to a location of your choice (e.g. `~/lib`), and set the `PRETTY_DECLARE_PRINT_LIB_DIR` environment variable:

    ```bash
    cd ~/lib
    cp -av ../repos/pretty-declare-print/lib pretty-declare-print
    ```

    Now, add the following line to your `~/.bashrc` file (or other appropriate configuration file for your shell):

    ```bash
    export PRETTY_DECLARE_PRINT_LIB_DIR="$HOME"'/lib/pretty-declare-print'
    ```

    Restart your terminal session for changes to take effect.

    You can also test the environment variable in your terminal session before adding it to the shell configuration file, like this:

    ```bash
    PRETTY_DECLARE_PRINT_LIB_DIR="$HOME"'/lib/pretty-declare-print' pretty-declare-print <arguments to pretty-declare-print>
    ```

4. (OPTIONAL) Symlink or copy the [man page](man/man1/pretty-declare-print.1) to a directory on your `MANPATH` (e.g. `~/man`):

    ```bash
    cd ~/man/man1 # The `man` directory should contain subdirectories for different manual sections: `man1`, `man2` etc.
    # To symlink:
    ln -sv ../../repos/pretty-declare-print/man/man1/pretty-declare-print.1
    # To copy:
    cp -av ../../repos/pretty-declare-print/man/man1/pretty-declare-print.1 .
    ```

    A copy of the manual page is also [included in this README file](#manual).

5. (OPTIONAL) Copy the [example config file](config.bash) to the config directory:

    ```bash
    mkdir -v ~/.config/pretty-declare-print
    cp -v ~/repos/pretty-declare-print/config.bash ~/.config/pretty-declare-print
    ```

## Manual

```plain
PRETTY-DECLARE-PRINT(1)     General Commands Manual    PRETTY-DECLARE-PRINT(1)

NAME
       pretty-declare-print - prettify output of `declare -p`

SYNOPSIS
        declare -p [<name> ...] |[&] pretty-declare-print [<options>]

        pretty-declare-print [<options>] <name> ...

DESCRIPTION
       pretty-declare-print  allows  the  user to easily view contents of Bash
       variables by formatting the output of Bash's `declare` builtin when run
       with the `-p` option. It can also be used to view values of special and
       positional paramaters, which can't normally be displayed with  `declare
       -p`,  by  creating temporary arrays to hold the values of those parame‐
       ters.

       For    more    information    on    parameters     in     Bash,     see
       <https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameters>.

       Run `help declare` for more information on the `declare` builtin.

       pretty-declare-print  requires  bat  to  be  installed to enable syntax
       highlighting in the output. If bat is not installed, syntax  highlight‐
       ing will not be available.

MODES
       pretty-declare-print  has  two modes of operation: the default mode and
       the names mode. These modes correspond to the two syntax forms that can
       be seen in the SYNOPSIS above.

   Default mode
       In  the default mode, pretty-declare-print takes output of `declare -p`
       via stdin and formats it according to the <options> set:

        declare -p [<name> ...] |[&] pretty-declare-print [<options>]

       One may choose to use the control operator `|%` instead of the  regular
       pipe  (`|`)  to  direct  both  stdout and stderr of declare to stdin of
       pretty-declare-print. This will allow the `unset_from_error` filter  to
       be  used.  See -f, --filter for more information. The names mode option
       --names-pipe-stderr / --names-no-pipe-stderr is also related.

       For more information on Bash pipelines, see  <https://www.gnu.org/soft‐
       ware/bash/manual/bash.html#Pipelines>.

   Names mode
       Names  mode  is activated when at least one positional parameter <name>
       is passed to pretty-declare-print:

        pretty-declare-print [<options>] <name> ...

       In this mode, pretty-declare-print generates code corresponding to  the
       form of the default mode.

       <name>  here  technically  should be <name|pos_param|spec_param|@|%|+>,
       but is simplified to '<name>' for the sake of brevity.

       These different possibilities of what '<name>' can be mean the  follow‐
       ing:

       <name>
           A valid Bash variable name. Variable names can only consist of let‐
           ters (a-z, A-Z), numbers (0-9), and underscores (_), and the  first
           character cannot be a number.

       <pos_param>
           A  positional  parameter. Positional parameters are always positive
           integers (1, 2, 3, ...).

           pretty-declare-print creates code for generating  a  temporary  in‐
           dexed array variable (whose name is set by --names-pos-params-name)
           to hold the values of positional parameters. This variable  is  put
           in  a  subshell, so it will not appear in the enviroment after run‐
           ning the generated code.

           Positional parameter 1 is assigned to index 1, positional parameter
           2 to index 2 etc. Index 0 is not used.

           For   more  information  on  positional  parameters  in  Bash,  see
           <https://www.gnu.org/software/bash/manual/bash.html#Positional-Pa‐
           rameters>.

       <spec_param>
           A  special  parameter. Possible values are `*`, `#`, `?`, `-`, `$`,
           `!`, `0`.

           Special parameter `@` can also be passed, but  is  treated  differ‐
           ently. See below.

           pretty-declare-print  creates code for generating a temporary asso‐
           ciative array variable (whose name is set  by  --names-spec-params-
           name)  to  hold  the values of special parameters. This variable is
           put in a subshell, so it will not appear in  the  enviroment  after
           running the generated code.

           For   more   information   on   special  parameters  in  Bash,  see
           <https://www.gnu.org/software/bash/manual/bash.html#Special-Parame‐
           ters>.

       @   Tells  pretty-declare-print  to  display all positional parameters.
           When `@` is passed, integer values (<pos_param>s) are ignored,  and
           all  positional parameters are added to the temporary indexed array
           variable.

       %   Tells pretty-declare-print to display all special parameters.  When
           `%`  is  passed, <spec_param>s are ignored, and all special parame‐
           ters are added to the temporary associative array variable.

       +   Tells pretty-declare-print to display all variables in the environ‐
           ment.

           This  generates `declare -p |[&] pretty-declare-print [<options>]`,
           i.e. no names are passed to declare.

           When  this  value  is  passed,  all  other  positional   parameters
           ('<name>'s) passed to pretty-declare-print are ignored.

   Using the generated code with (and without) eval
       Code generated by pretty-declare-print in names mode can also be passed
       to eval, but there are peculiarities to this usage:

        eval "$(pretty-declare-print -x "$?" [<options>] <name> ...)"

       Since pretty-declare-print has to run before passing its output over to
       eval,  some of the parameters in the environment will have changed as a
       result of that. Then, the generated code has to  run  too,  which  will
       also  result in changes to parameters. (The latter is also true even if
       one doesn't use eval.)

       This implementation takes care of preserving values of  the  underscore
       variable (`$_`), the PIPESTATUS variable, and the question mark special
       parameter (`$?`). It does so by generating additional code  when  those
       '<name>'s are passed to pretty-declare-print in names mode, and by pre‐
       serving the exit status of the previous command by using  -x,  --names-
       preserve-exit-status.

       To  preserve  the  value of the question mark special parameter (`$?`),
       -x, --names-preserve-exit-status must be used to pass the value of `$?`
       to  pretty-declare-print.  This will cause pretty-declare-print to exit
       with the same exit status as the previous command, thus  preseving  the
       value of the question mark special parameter.

OPTIONS
   Colons syntax (replace/append)
       Some  of  the options described below use a special syntax which deter‐
       mines whether the previously set values of this option  should  be  re‐
       placed or appended to.

       The syntax looks like this:

       -o, --option=[:[:]]<value>

       It  means  that  <value>  can  be  preceded by a single colon, a double
       colon, or nothing.

       There may also be some structure to the <value> that makes it  possible
       to pass several pieces of information at once. For example, it may be a
       comma-separated list (<value>[,...]) or an option string (<opts>).

       The indication '<value>' will be used going forward to refer  to  this,
       but  keep  in  mind  that this '<value>' can really consist of multiple
       values.

       The leading colons control whether <value> gets appended to  previously
       set values, or replaces them.

       The  phrase  'previously set values' refers to either the default value
       baked into the script itself, or a value set in the configuration file.

       When a single colon (`:`) is used, <value> replaces the previously  set
       values.

       When  a  double colon (`::`) is used, <value> is appended to the previ‐
       ously set values.

       When the leading colons are omitted, whether <value> replaces the  pre‐
       viously  set  values, or is appended to them is determined by an *addi‐
       tonal* value that is yet again either baked into the script itself,  or
       is set in the configuration file.

       The  variable  that  controls this can be recognized as having the same
       name as the option in question with the word `_append` added to it. For
       example,  if  the  option's variable is `opt_option`, then the variable
       that controls what happens when  the  leading  colons  are  omitted  is
       called `opt_option_append`.

   General
       -s, --sort-associative-arrays
              Present  contents  of associative arrays in a sorted order. This
              is the default.

       -S, --no-sort-associative-arrays
              Do not present contents of associative arrays in a sorted order.

       -m, --multiline-arrays
              Display each element of an array on a separate line. This is the
              default.

       -M, --no-multiline-arrays
              Do not display each element of an array on a separate line.

       -i, --multiline-arrays-indent=<value>
              Width  of indentation when each element of an array is displayed
              on a separate line. <value> must be a positive integer. The  de‐
              fault <value> is `2`.

       -f, --filter=[:[:]]<filter_name>[,...]
              Modify  output of pretty-declare-print with one or more filters.
              The default is ``.

              Filters are sed scripts. They are applied in the order that  was
              specified  in  the comma-separated list of <filter_name>s passed
              as a value to this option. This option can also be passed multi‐
              ple  times, in which case, the order of the filters is respected
              as well.

              The following filters are available by default:

              omit_values
                     Only show the `declare <attrs> <name>` part, omitting the
                     values.

              simplify
                     Only show the names and the values, omitting the `declare
                     <attrs> ` part wnen <attrs> is `--` or `-a`.

              simplify_all
                     Like `simplify`, but omits  `declare  <attrs>  `  in  all
                     cases.

              unset_before_declare
                     Add  an `unset -n <name>; unset "$_"` line before declar‐
                     ing each variable.

                     If one were to source the output of pretty-declare-print,
                     each variable should be unset first, before declaring it.
                     Not doing so may result in erroneous assignments if,  for
                     instance, one of the variables was previously declared as
                     a name reference, or an array.

              unset_from_error
                     Convert declare's '<name>: not found' error  messages  to
                     `unset -n <name>; unset "$_"`.

                     Note that in order for this filter to work, stderr of de‐
                     clare must be piped to pretty-declare-print. This can  be
                     acheived  by  using the `|&` control operator, or by set‐
                     ting --names-pipe-stderr when working in names mode.

              Custom filters can be  defined  in  the  configuration  file  by
              adding values to the `filters` associative array. Pass --filter-
              list to view that array.

       --filter-list
              Print the list of available filters.

       -e, --filter-commands=[[+]<sed_opts> -- ]<sed_script>
              Like -f, --filter, but takes a sed script as the  value  instead
              of a filter name.

              Options  to  sed can also be passed if needed. If <sed_opts> are
              preceded with a plus sign (`+`), then they are appended  to  the
              default  sed  options.  The default sed options are `-E`. If the
              plus sign is not added, then <sed_opts> replace the default  sed
              options.

              This  option  can  be  passed  multiple  times with the order of
              scripts being respected. These 'on-the-fly' filters are added to
              the  chain  of filters passed with -f, --filter while respecting
              the order of scripts that came from either option.

       --bat-opts=[:[:]]<opts>
              Options to bat. The default is ``.

       --sort-opts=[:[:]]<opts>
              Options to sort. The default is ``.

   Names mode
       --names-pos-params-name=<value>
              Name of a temporary variable to hold values of positional param‐
              eters. The default it `_pos_params`.

       --names-spec-params-name=<value>
              Name  of  a temporary variable to hold values of special parame‐
              ters. The default it `_spec_params`.

       --names-var-underscore-name=<value>
              Name of a temporary variable to hold  value  of  the  underscore
              variable. The default it `_var_underscore`.

       --names-var-pipestatus-name=<value>
              Name  of  a  temporary  variable to hold value of the underscore
              variable. The default it `_var_pipestatus`.

       --names-spec-param-question-mark-name=<value>
              Name of a temporary variable to hold  value  of  the  underscore
              variable. The default it `_spec_param_question_mark`.

       -x, --names-preserve-exit-status=<value>
              Exit  status of the previous command - for using pretty-declare-
              print in names mode with eval. Usage: `-x "$?"`.

              When set, it will cause pretty-declare-print to  exit  with  the
              specified exit status.

              See  MODES  > 'Using the generated code with (and without) eval'
              for more information.

       --names-pipe-stderr
              Pipe stderr of declare to pretty-declare-print together with its
              stdout.

       --names-no-pipe-stderr
              Do  not  pipe stderr of declare to pretty-declare-print together
              with its stdout. This is the default.

   Other
       -c, --color
              Colorize the output. This is the default.

       -C, --no-color
              Disable colorization of the output.

       -h, --help
              Print help.

       -V, --version
              Print version information.

ENVIRONMENT
       pretty-declare-print is a program that consists of multiple files.  All
       the  files that pretty-declare-print requires are stored in the lib di‐
       rectory located in the same folder as the main script.

       Normally, pretty-declare-print should be able to determine its own  lo‐
       catiion,  and thus the location of the lib folder. If for whatever rea‐
       son pretty-declare-print is unable to determine its  own  location,  or
       the  user wishes to store pretty-declare-print library files elsewhere,
       the PRETTY_DECLARE_PRINT_LIB_DIR enviroment variable can be set to man‐
       ually  point  to  a  directory  containing pretty-declare-print library
       files.

FILES
       A configuration file can be used to set default options.

       The configuration file's location  is  $XDG_CONFIG_HOME/pretty-declare-
       print/config.bash.  If  XDG_CONFIG_HOME  is  not  set,  it  defaults to
       ~/.config.

AUTHOR
       Alex Rogers <https://github.com/linguisticmind>

HOMEPAGE
       <https://github.com/linguisticmind/ezedl>

COPYRIGHT
       Copyright © 2024 Alex Rogers. License GPLv3+:  GNU  GPL  version  3  or
       later <https://gnu.org/licenses/gpl.html>.

       This  is  free  software:  you  are free to change and redistribute it.
       There is NO WARRANTY, to the extent permitted by law.

PRETTY-DECLARE-PRINT 0.1.6           2024              PRETTY-DECLARE-PRINT(1)
```

## License

[GNU General Public License v3.0](LICENSE)
