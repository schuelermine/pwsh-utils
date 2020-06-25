function Get-CompletelyUnique {
    param($InputObject, [String]$Property)

    $Input | Group-Object $Property |
        Where-Object Count -EQ 1 |
        Select-Object -ExpandProperty Group
}