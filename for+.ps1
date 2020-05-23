<#
.Description
For+ acts as a python-esque alternative to PowerShell for syntax.
In contrast to foreach, for+ allows access to the current index and the current item.
The supplied script block can acces the current item using $_ and the current index using $i.

.PARAMETER Array
The array to iterate through.

.PARAMETER ScriptBlock
The script block that is executed for each item in the array.
User $_ to refer to the current item and $i to refer to that item's index.

.INPUTS
None

.OUTPUTS
Whatever the supplied script block outputs.

.EXAMPLE
> for+ ((1,2),(3,4)) {$_[$i]}
1
4

.EXAMPLE
> for+ ('a'..'c') {"$_" * $i}

b
cc

.EXAMPLE
> for+ (,('a'..'e')*5) {$_[$i]}
a
b
c
d
e

.LINK
https://github.com/schuelermine/pwsh-utils
#>

function For+ {    
    param(
        [Parameter(
            Mandatory,
            Position = 0
        )]
        [Object[]]
        $Array,

        [Parameter(
            Mandatory,
            Position = 1
        )]
        [ScriptBlock]
        $ScriptBlock
    )

    for ($i = 0; $i -lt $Array.Count; $i++) {
        $_ = $Array[$i]
        & $ScriptBlock
    }
}
