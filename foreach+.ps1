function ForEach+ {    
    param(
        [Parameter(
            Mandatory,
            Position = 0
        )]
        [Object[]]
        $List,

        [Parameter(
            Mandatory,
            Position = 1
        )]
        [ScriptBlock]
        $ScriptBlock
    )

    for ($i = 0; $i -lt $List.Count; $i++) {
        $_ = $List[$i]
        & $ScriptBlock
    }
}