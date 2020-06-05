function Get-ShortCommands {
    foreach ($Command in Get-Command) {
        $Verb = $Command.Verb -as [Char[]]
        $Noun = $Command.Noun -as [Char[]]

        $ShortVerb, $ShortNoun = "", ""

        if ($Verb.Count -ne 0) {
            foreach ($Char in $Verb) {
                if ([Char]::IsUpper($Char)) {
                    $ShortVerb += $Char
                }
            }
        }

        if ($Noun.Count -ne 0) {
            foreach ($Char in $Noun) {
                if ([Char]::IsUpper($Char)) {
                    $ShortNoun += $Char
                }
            }
        }

        $ShortName =
            @($ShortVerb, $ShortNoun).Where({$_.Length -ne 0}) -join "-"

        [PSCustomObject]@{
            Name = $Command.Name
            ShortName = $ShortName
        }
    }
}