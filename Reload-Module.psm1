function Reload-Module {
    [CmdletBinding()]
    param([ValidateScript({Test-Path -LiteralPath $_})]
    [Parameter(Mandatory)][String]$Path)

    Write-Debug (Get-Location)

    $Path = Convert-Path $Path
    Write-Debug $Path

    $Name = Get-Module -ListAvailable -Name $Path |
        Where-Object Path -EQ $Path |
        Select-Object -First 1 -ExpandProperty Name
    
    if ($Name) {
        $EscapedName = $Name.Replace("'", "''")

        "Remove-Module '$EscapedName'"
    }

    $EscapedPath = $Path.Replace("'", "''")

    "Import-Module '$EscapedPath'"
}