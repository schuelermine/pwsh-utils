<#
.Description
For+ acts as a python-esque alternative to PowerShell for syntax.
In contrast to foreach, for+ allows access to the current index and the current item.
The supplied script block can acces the current item using $x and the current index using $i (customizable).

.PARAMETER Array
The array to iterate through.

.PARAMETER ScriptBlock
The script block that is executed for each item in the array.
By default, use $x to refer to the current item and $i to refer to that item's index.

.PARAMETER ItemVariableName
The variable name that the current item is bound to.
Use this if you don't want to use $x for the item in your scriptblock.

.PARAMETER IndexVariableName
The variable name that the current index is bound to.
Use this if you don't want to use $i for the item's index in your scriptblock.

.INPUTS
None

.OUTPUTS
Whatever the supplied script block outputs.

.EXAMPLE Basic functionality
> for+ (1..5) {$x - 1}
0
1
2
3
4

.EXAMPLE Using the index variable
> for+ ('a'..'c') {"$x" * $i}

b
cc

.EXAMPLE Using the index variable to index into an array
> for+ ((1,2),(3,4)) {$x[$i]}
1
4

.EXAMPLE Using the index variable to index into an array
> for+ (,('a'..'e')*5) {$x[$i]}
a
b
c
d
e

.EXAMPLE Changing the item and index variable name
> for+ ('a'..'c') {"$u $p"} "u" "p"
a 0
b 1
c 2

.EXAMPLE Expanding the argument names for free order of arguments
> For+ -ScriptBlock {$Item, $Index} -IndexVariableName "Index" -ItemVariableName "Item" -Array (1..4)
1
0
2
1
3
2
4
3

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
        $ScriptBlock,
        
        [Alias("Item", "x")]
        [PSDefaultValue(
            Help = "x",
            Value = "x"
        )]
        [Parameter(
            Position = 2
        )]
        [String]
        $ItemVariableName = "x",
        
        [Alias("Index", "i")]
        [PSDefaultValue(
            Help = "i",
            Value = "i"
        )]
        [Parameter(
            Position = 3
        )]
        $IndexVariableName = "i"
    )

    for ($i = 0; $i -lt $Array.Count; $i++) {
        $Vars = @(
            [PSVariable]::new($ItemVariableName, $Array[$i])
            [PSVariable]::new($IndexVariableName, $i)
        )
        
        $ScriptBlock.InvokeWithContext($null, $Vars, $null)
    }
}
