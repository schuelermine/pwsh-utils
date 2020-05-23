<#
.Description
For+ acts as a python-esque alternative to PowerShell for syntax.
In contrast to foreach, for+ allows access to the current index and the current item.
The supplied script block can acces the current item using $_ and the current index using $i.

.Parameter Array
The array to iterate through.

.Parameter ScriptBlock
The script block that is executed for each item in the array.
User $_ to refer to the current item and $i to refer to that item's index.
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
