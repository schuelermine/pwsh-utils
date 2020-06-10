function Split-String {
    param(
        [String]$String,
        [UInt64]$LineLength
    )

    $Length = $String.Length
    $Output = @()

    $Index = 0

    while ($Index -lt $Length) {
        $NextIndex = $Index + $LineLength - 1
        
        $String[$Index..$NextIndex] -join ""

        $Index = $NextIndex + 1
    }
}