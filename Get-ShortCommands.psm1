function Get-ShortCommands {
    [CmdletBinding()]param()

    foreach ($Command in Get-Command) {
        $Name = $Command.Name

        $Verb, $Noun =
            $Name -split "-", 2 -as [Char[][]]
        
        Write-Debug "Values:"
        Write-Debug " $Name"
        Write-Debug " $Verb"
        Write-Debug " $Noun"

        $ShortVerb, $ShortNoun = "", ""

        if ($Verb.Count -ne 0) {
            Write-Debug "Verb nonempty."

            foreach ($Char in $Verb) {
                Write-Debug "Current item:"
                Write-Debug " $Char"

                if ([Char]::IsUpper($Char)) {
                    $ShortVerb += $Char
                }

                Write-Debug "Short verb:"
                Write-Debug " $ShortVerb"
            }
        }

        if ($Noun.Count -ne 0) {
            Write-Debug "Verb nonempty."

            foreach ($Char in $Noun) {
                Write-Debug "Current item:"
                Write-Debug " $Char"

                if ([Char]::IsUpper($Char)) {
                    $ShortNoun += $Char
                }

                Write-Debug "Short noun:"
                Write-Debug " $ShortNoun"
            }
        }

        $ShortName = 
            Join-String* @($ShortVerb, $ShortNoun) "-"

        Write-Debug "Short name:"
        Write-Debug " $ShortName"

        [PSCustomObject]@{
            Name = $Command.Name
            ShortName = $ShortName
        }
    }
}

function Join-String* {
    param(
        [String[]]$Array,
        [String]$Seperator
    )

    $Array.Where({$_.Length -ne 0}) -join "-"
}

Export-ModuleMember -Function "Get-ShortCommands"