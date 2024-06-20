# pretty-declare-print changelog

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
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.5'>0.1.5</a>
        </td>
        <td>
            2024-06-01
        </td>
        <td>
            <p>
                <b>IMPORTANT</b>: Fixed a bug where the closing parenthesis of an array consisting of a single element wouldn't get printed when breaking up arrays into multiple lines was disabled (<code>-M, --no-multiline-arrays</code>).
            </p>
            <p>
                Now, <code>-c, --color / -C, --no-color</code> also affects colorization of the output in names mode.<br>
                <code>bat</code>'s <code>--paging</code> is now always set to <code>never</code> in names mode.
            </p>
            <p>
                Fixed formatting in the CHANGELOG file.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.4'>0.1.4</a>
        </td>
        <td>
            2024-05-02
        </td>
        <td>
            <p>
                Updated <code>simplify_all</code> and <code>unset_before_declare</code> filters to work when there are multiple attributes.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.3'>0.1.3</a>
        </td>
        <td>
            2024-04-29
        </td>
        <td>
            <p>
                Fixed the description of <code>simplify</code> and <code>simplify_all</code> filters in the man page.
            </p>
            <p>
                Other minor improvements to the man page.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.2'>0.1.2</a>
        </td>
        <td>
            2024-04-26
        </td>
        <td>
            <p>
                Added a new <code>unset_before_declare</code> filter. If one were to source the output of <code>pretty-declare-print</code>, each variable should be unset first, before declaring it. Not doing so may result in erroneous assignments if, for instance, one of the variables was previously declared as a name reference, or an array.
            </p>
            <p>
                Fixed a bug in the <code>unset_from_error</code> filter that occurred when the <code>declare: &lt;name&gt;: not found</code> part of an error line would be preceded by more than one colon-terminated substring, e.g. <code>./test-script: line 11: declare: nonexistent: not found</code>.
            </p>
            <p>
                Fixed a bug where passing single-letter <code>&lt;name&gt;</code>s in names mode would result in the <code>declare -p</code> command being unnecessarily put in a subshell.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.1'>0.1.1</a>
        </td>
        <td>
            2024-04-22
        </td>
        <td>
            <p>
                Now, <code>$&lowbar;</code>, <code>PIPESTATUS</code>, and <code>$?</code> are preserved in names mode.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/pretty-declare-print/releases/tag/v0.1.0'>0.1.0</a>
        </td>
        <td>
            2024-04-18
        </td>
        <td>
            <p>
                Initial release.
            </p>
        </td>
    </tr>
</table>
